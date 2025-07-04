import copy
import random

from time_slot import TIME_SLOTS
from database import get_available_rooms


def extract_room_ids(rooms):
    """Extract room IDs if rooms is a list of tuples."""
    if rooms and isinstance(rooms[0], (tuple, list)):
        return [r[0] for r in rooms]
    return rooms


def get_full_location_details(room_id, conn):
    """
    Retrieve full location details (city_name, building_name, room_name) for a given room_id.
    Assumes Locations table has columns: location_id, city_name, building_name, room_name.
    """
    cursor = conn.cursor()
    query = "SELECT city_name, building_name, room_name FROM Locations WHERE location_id = %s"
    cursor.execute(query, (room_id,))
    row = cursor.fetchone()
    cursor.close()
    if row:
        return row  # (city_name, building_name, room_name)
    return (None, None, None)


def parse_time(time_str):
    """ # Parse a time string 'HH:MM' and return minutes since midnight."""
    parts = time_str.split(":")
    return int(parts[0]) * 60 + int(parts[1])


def get_travel_time(origin_building, destination_building, conn):
    """
    Query the TravelTimes table to get travel_time_minutes between two buildings.
    Searches for a row where (origin_name, destination_name) match (or vice versa).
    Returns the travel time in minutes; if not found, returns a default value (60).
    """
    cursor = conn.cursor()
    query = """
      SELECT travel_time_minutes FROM TravelTimes
      WHERE ((origin_name = %s AND destination_name = %s)
             OR (origin_name = %s AND destination_name = %s))
      LIMIT 1
    """
    cursor.execute(query, (origin_building, destination_building, destination_building, origin_building))
    row = cursor.fetchone()
    cursor.close()
    if row:
        return row[0]
    return 60


def get_rooms_in_building(building, room_type, conn):
    """
    Retrieve room IDs in a given building and of a specified room_type.
    """
    cursor = conn.cursor()
    query = "SELECT location_id FROM Locations WHERE building_name = %s AND room_type = %s"
    cursor.execute(query, (building, room_type))
    rows = cursor.fetchall()
    cursor.close()
    return [row[0] for row in rows]


# Repair Operator for Lecture-to-Tutorial Gap
def repair_lecture_tutorial_gap(candidate, conn, location_cache, travel_time_map):
    """
    For each subject in the candidate schedule, ensure that the gap between the lecture's end
    and each tutorial's start is sufficient when the lecture and tutorial are held in different buildings.
    First, try to reassign the tutorial to a room in the lecture's building.
    If that isn't possible, try to reassign the tutorial to a later time slot.
    """
    for subj, data in candidate.items():
        # Determine which lecture info to use: either a single lecture or two lectures.
        if "lecture" in data:
            lec_sessions = [data["lecture"]]
        elif "lectures" in data:
            lec_sessions = data["lectures"]
        else:
            continue

        # Use the first lecture session as reference for timing.
        lec_session = lec_sessions[0]
        day = data.get("day", "monday").lower()
        lec_slot, lec_room = lec_session
        lec_start_str, lec_end_str = TIME_SLOTS[lec_slot]
        lec_end = parse_time(lec_end_str)
        _, lec_building, _ = location_cache.get(lec_room, (None, None, None))

        new_tutorials = []
        for slot, room in data.get("tutorials", []):
            tut_start_str, _ = TIME_SLOTS[slot]
            tut_start = parse_time(tut_start_str)
            _, tut_building, _ = get_full_location_details(room, conn)
            if lec_building and tut_building and lec_building != tut_building:
                required = travel_time_map.get((lec_building, tut_building), 60)

                gap = tut_start - lec_end
                if gap < required:
                    # Attempt 1: reassign tutorial room to one in the lecture's building.
                    rooms_same = get_rooms_in_building(lec_building, "Classroom", conn)
                    if rooms_same:
                        room = random.choice(rooms_same)
                        new_tutorials.append((slot, room))
                        continue
                    # Attempt 2: reassign tutorial to a later time slot.
                    possible_slots = [s for s, t in TIME_SLOTS.items() if parse_time(t[0]) >= lec_end + required]
                    if possible_slots:
                        slot = random.choice(possible_slots)
                        new_tutorials.append((slot, room))
                        continue
            new_tutorials.append((slot, room))
        data["tutorials"] = new_tutorials
    return candidate


# --- Global Scheduler Functions ---
def generate_global_candidate(subject_codes, conn, day_mapping, subject_student_counts,
                              location_cache, travel_time_map):
    """
    Generate a candidate schedule mapping each subject to a day, lecture (or lectures), and tutorials.
    For subjects with each 160 students (as per subject_student_counts), generate one more lecture sessions.
    """
    candidate = {}
    lecture_rooms = extract_room_ids(get_available_rooms("LectureTheatre", conn))
    tutorial_rooms = extract_room_ids(get_available_rooms("Classroom", conn))
    max_slot = max(TIME_SLOTS.keys())
    valid_lecture_slots = [slot for slot in TIME_SLOTS if slot <= max_slot - 3]
    used_slots_rooms = set()
    for subj in subject_codes:
        day = day_mapping.get(subj, "monday").lower()
        count = subject_student_counts.get(subj, 0)
        if count > 160:
            lecture_slot = random.choice(valid_lecture_slots)
            lec_room1 = random.choice(lecture_rooms)
            possible_rooms = [r for r in lecture_rooms if r != lec_room1]
            if possible_rooms:
                lec_room2 = random.choice(possible_rooms)
            else:
                lec_room2 = lec_room1
            while (day, lecture_slot, lec_room1) in used_slots_rooms:
                lecture_slot = random.choice(valid_lecture_slots)
                lec_room1 = random.choice(lecture_rooms)
            used_slots_rooms.add((day, lecture_slot, lec_room1))
            while (day, lecture_slot, lec_room2) in used_slots_rooms or lec_room2 == lec_room1:
                possible_rooms = [r for r in lecture_rooms if r != lec_room1]
                if not possible_rooms:
                    break
                lec_room2 = random.choice(possible_rooms)
            used_slots_rooms.add((day, lecture_slot, lec_room2))
            candidate[subj] = {
                "day": day,
                "lectures": [(lecture_slot, lec_room1), (lecture_slot, lec_room2)]
            }
        else:
            # Generate a single lecture session.
            lecture_slot = random.choice(valid_lecture_slots)
            lec_room = random.choice(lecture_rooms)
            while (day, lecture_slot, lec_room) in used_slots_rooms:
                lecture_slot = random.choice(valid_lecture_slots)
                lec_room = random.choice(lecture_rooms)
            used_slots_rooms.add((day, lecture_slot, lec_room))
            candidate[subj] = {
                "day": day,
                "lecture": (lecture_slot, lec_room)
            }
        # Generate tutorials
        possible_tutorial_slots = [slot for slot in TIME_SLOTS if slot > lecture_slot]
        tutorial_sessions = []
        attempts = 0
        while len(tutorial_sessions) < 3 and attempts < 20:
            slot = random.choice(possible_tutorial_slots)
            room = random.choice(tutorial_rooms)
            if (day, slot, room) not in used_slots_rooms:
                tutorial_sessions.append((slot, room))
                used_slots_rooms.add((day, slot, room))
            attempts += 1
        while len(tutorial_sessions) < 3:
            slot = random.choice(possible_tutorial_slots)
            room = random.choice(tutorial_rooms)
            tutorial_sessions.append((slot, room))
        candidate[subj]["tutorials"] = tutorial_sessions
    candidate = repair_lecture_tutorial_gap(candidate, conn, location_cache, travel_time_map)
    return candidate


def evaluate_global_schedule(candidate, subject_student_counts, conn,
                             subject_course_mapping=None,
                             location_cache=None, travel_time_map=None):

    """
    Evaluate a candidate schedule.
    For single-lecture subjects, checks capacity and travel gap.
    For subjects with two lectures, assumes expected students are split equally and applies capacity penalties accordingly.
    Also adds penalties for tutorials scheduled too early and for travel conflicts.
    if subject_course_mapping is provided (subject_code -> course name), adds a penalty if
    subjects from the same course on the same day share the same lecture time slot.
    """
    penalty = 0
    room_usage = {}
    for subj, sessions in candidate.items():
        day = sessions["day"]
        expected = subject_student_counts.get(subj, 0)
        # Evaluate lecture(s)
        if "lecture" in sessions:
            lec_slot, lec_room = sessions["lecture"]
            lec_key = (day, lec_slot, lec_room)
            room_usage.setdefault(lec_key, []).append((subj, "lecture"))
            cursor = conn.cursor()
            query = "SELECT capacity FROM Locations WHERE location_id = %s"
            room_id = lec_room[0] if isinstance(lec_room, (tuple, list)) else lec_room
            cursor.execute(query, (room_id,))
            row = cursor.fetchone()
            cursor.close()
            if row:
                capacity = row[0]
                if expected > capacity:
                    penalty += (expected - capacity) * 10
            lec_times = TIME_SLOTS[lec_slot]
            lec_end = parse_time(lec_times[1])
            _, lec_building, _ = get_full_location_details(room_id, conn)
        elif "lectures" in sessions:
            lectures = sessions["lectures"]
            if len(lectures) != 2:
                penalty += 500  # heavy penalty if not exactly 2 lectures
                continue
            # Check that the two lectures are in different rooms.
            lec_slot1, lec_room1 = lectures[0]
            lec_slot2, lec_room2 = lectures[1]
            if lec_room1 == lec_room2:
                penalty += 100
            half_expected = expected / 2.0
            for lec_slot, lec_room in lectures:
                lec_key = (day, lec_slot, lec_room)
                room_usage.setdefault(lec_key, []).append((subj, "lecture"))
                cursor = conn.cursor()
                query = "SELECT capacity FROM Locations WHERE location_id = %s"
                room_id = lec_room[0] if isinstance(lec_room, (tuple, list)) else lec_room
                cursor.execute(query, (room_id,))
                row = cursor.fetchone()
                cursor.close()
                if row:
                    capacity = row[0]
                    if half_expected > capacity:
                        penalty += (half_expected - capacity) * 10
            lec_times = TIME_SLOTS[lectures[0][0]]
            lec_end = parse_time(lec_times[1])
            _, lec_building, _ = get_full_location_details(lectures[0][1], conn)
        # Evaluate tutorials
        for slot, room in sessions["tutorials"]:
            ref_slot = sessions["lecture"][0] if "lecture" in sessions else sessions["lectures"][0][0]
            if slot <= ref_slot:
                penalty += 50
            tut_times = TIME_SLOTS[slot]
            tut_start = parse_time(tut_times[0])
            _, tut_building, _ = get_full_location_details(room, conn)
            if lec_building and tut_building and lec_building != tut_building:
                required = travel_time_map.get((lec_building, tut_building), 60)

                gap = tut_start - lec_end
                if gap < required:
                    diff = required - gap
                    penalty += diff * 15
            tut_key = (day, slot, room)
            room_usage.setdefault(tut_key, []).append((subj, "tutorial"))

    for key, uses in room_usage.items():
        if len(uses) > 1:
            penalty += 100 * (len(uses) - 1)

    # Additional constraint: For subjects in the same course on the same day, lecture slots must be distinct.
    if subject_course_mapping:
        course_day_lectures = {}
        for subj, sessions in candidate.items():
            if "lecture" in sessions:
                day = sessions["day"].lower()
                lec_slot, _ = sessions["lecture"]
                course = subject_course_mapping.get(subj)
                if course:
                    key = (course, day)
                    course_day_lectures.setdefault(key, []).append(lec_slot)
            elif "lectures" in sessions:
                day = sessions["day"].lower()
                course = subject_course_mapping.get(subj)
                if course:
                    lec_slot = sessions["lectures"][0][0]
                    key = (course, day)
                    course_day_lectures.setdefault(key, []).append(lec_slot)
        for key, slots in course_day_lectures.items():
            duplicates = len(slots) - len(set(slots))
            if duplicates > 0:
                penalty += duplicates * 100

    return penalty


def mutate_global_schedule(candidate, conn, day_mapping, location_cache, travel_time_map, mutation_rate=0.1, travel_improve_prob=0.7):

    lecture_rooms = extract_room_ids(get_available_rooms("LectureTheatre", conn))
    tutorial_rooms = extract_room_ids(get_available_rooms("Classroom", conn))
    for subj in candidate:
        day = day_mapping.get(subj, "monday").lower()
        if "lecture" in candidate[subj]:
            if random.random() < mutation_rate:
                valid_lecture_slots = [slot for slot in TIME_SLOTS if slot <= max(TIME_SLOTS) - 3]
                new_slot = random.choice(valid_lecture_slots)
                new_room = random.choice(lecture_rooms)
                possible_tut_slots = [s for s in TIME_SLOTS if s > new_slot]
                if len(possible_tut_slots) < 3:
                    tut_slots = (possible_tut_slots * 3)[:3]
                else:
                    tut_slots = random.sample(possible_tut_slots, 3)
                tutorials = [(slot, random.choice(tutorial_rooms)) for slot in tut_slots]
                candidate[subj]["lecture"] = (new_slot, new_room)
                candidate[subj]["tutorials"] = tutorials
        elif "lectures" in candidate[subj]:
            if random.random() < mutation_rate:
                valid_lecture_slots = [slot for slot in TIME_SLOTS if slot <= max(TIME_SLOTS) - 3]
                new_slot = random.choice(valid_lecture_slots)
                new_room1 = random.choice(lecture_rooms)
                possible_rooms = [r for r in lecture_rooms if r != new_room1]
                new_room2 = random.choice(possible_rooms) if possible_rooms else new_room1
                candidate[subj]["lectures"] = [(new_slot, new_room1), (new_slot, new_room2)]
            if random.random() < mutation_rate:
                possible_tut_slots = [s for s in TIME_SLOTS if s > (candidate[subj]["lectures"][0][0])]
                if len(possible_tut_slots) < 3:
                    tut_slots = (possible_tut_slots * 3)[:3]
                else:
                    tut_slots = random.sample(possible_tut_slots, 3)
                candidate[subj]["tutorials"] = [(slot, random.choice(tutorial_rooms)) for slot in tut_slots]
    candidate = repair_lecture_tutorial_gap(candidate, conn, location_cache, travel_time_map)
    return candidate


def crossover_global_schedule(p1, p2):
    child = {}
    for subj in p1:
        child[subj] = copy.deepcopy(p1[subj]) if random.random() < 0.5 else copy.deepcopy(p2.get(subj, p1[subj]))
    return child


def global_schedule_genetic_algorithm(subject_codes, conn, day_mapping, subject_student_counts,
                                      subject_course_mapping=None, generations=100, pop_size=30,
                                      location_cache=None, travel_time_map=None, room_capacities=None):

    """
    Generate a global schedule using a genetic algorithm.
    A subject_course_mapping (subject_code -> course name) can be provided to enforce that
    lectures for subjects in the same course on the same day are scheduled in different time slots.
    """
    population = [
        generate_global_candidate(subject_codes, conn, day_mapping, subject_student_counts,
                                  location_cache, travel_time_map)
        for _ in range(pop_size)
    ]

    best_candidate = None
    best_penalty = float('inf')
    for _ in range(generations):
        population = [repair_lecture_tutorial_gap(c, conn, location_cache, travel_time_map) for c in population]

        penalties = [
            evaluate_global_schedule(c, subject_student_counts, conn, subject_course_mapping,
                                     location_cache, travel_time_map)
            for c in population
        ]

        for cand, pen in zip(population, penalties):
            if pen < best_penalty:
                best_penalty = pen
                best_candidate = cand
        selected = random.choices(population, weights=[1 / (p + 1) for p in penalties], k=pop_size)
        next_gen = []
        for i in range(0, pop_size, 2):
            p1 = selected[i]
            p2 = selected[(i + 1) % pop_size]
            c1 = crossover_global_schedule(p1, p2)
            c2 = crossover_global_schedule(p2, p1)
            next_gen.extend([c1, c2])
        population = [
            mutate_global_schedule(c, conn, day_mapping, location_cache, travel_time_map)
            for c in next_gen
        ]

    return best_candidate, best_penalty


def explain_global_conflicts(candidate, subject_student_counts, conn, location_cache=None,
                             travel_time_map=None, subject_course_mapping=None):
    """Return detailed conflict messages including capacity, tutorial timing, room conflicts, travel time issues, and course slot overlaps."""
    conflicts = []
    total_penalty = 0
    room_usage = {}

    for subj, sessions in candidate.items():
        day = sessions.get("day", "monday")
        expected = subject_student_counts.get(subj, 0)

        # Determine lecture details
        if "lecture" in sessions:
            lec_slot, lec_room = sessions["lecture"]
            lec_key = (day, lec_slot, lec_room)
            room_usage.setdefault(lec_key, []).append((subj, "lecture"))
            room_id = lec_room[0] if isinstance(lec_room, (tuple, list)) else lec_room
            cursor = conn.cursor()
            cursor.execute("SELECT capacity FROM Locations WHERE location_id = %s", (room_id,))
            row = cursor.fetchone()
            cursor.close()
            if row:
                capacity = row[0]
                if expected > capacity:
                    excess = expected - capacity
                    penalty = excess * 10
                    conflicts.append(f"{subj} lecture capacity conflict on {day}: expected {expected} exceeds capacity {capacity} by {excess}. Penalty +{penalty}")
                    total_penalty += penalty
            lec_times = TIME_SLOTS[lec_slot]
            lec_end = parse_time(lec_times[1])
            _, lec_building, _ = location_cache.get(lec_room, get_full_location_details(lec_room, conn))
        elif "lectures" in sessions:
            lectures = sessions["lectures"]
            if len(lectures) != 2:
                conflicts.append(f"{subj} does not have exactly 2 lectures. Penalty +500")
                total_penalty += 100
                continue
            lec_slot1, lec_room1 = lectures[0]
            lec_slot2, lec_room2 = lectures[1]
            if lec_room1 == lec_room2:
                conflicts.append(f"{subj} has two lectures in the same room {lec_room1}. Penalty +100")
                total_penalty += 100
            half_expected = expected / 2.0
            for idx, (lec_slot, lec_room) in enumerate(lectures, 1):
                lec_key = (day, lec_slot, lec_room)
                room_usage.setdefault(lec_key, []).append((subj, f"lecture {idx}"))
                room_id = lec_room[0] if isinstance(lec_room, (tuple, list)) else lec_room
                cursor = conn.cursor()
                cursor.execute("SELECT capacity FROM Locations WHERE location_id = %s", (room_id,))
                row = cursor.fetchone()
                cursor.close()
                if row:
                    capacity = row[0]
                    if half_expected > capacity:
                        excess = half_expected - capacity
                        penalty = int(excess * 10)
                        conflicts.append(f"{subj} lecture {idx} capacity conflict on {day}: expected {half_expected:.0f} exceeds capacity {capacity} by {excess:.0f}. Penalty +{penalty}")
                        total_penalty += penalty
            lec_times = TIME_SLOTS[lectures[0][0]]
            lec_end = parse_time(lec_times[1])
            _, lec_building, _ = location_cache.get(lectures[0][1], get_full_location_details(lectures[0][1], conn))
        else:
            continue

        for slot, room in sessions["tutorials"]:
            ref_slot = sessions["lecture"][0] if "lecture" in sessions else sessions["lectures"][0][0]
            if slot <= ref_slot:
                conflicts.append(f"{subj} Tutorial scheduled at slot {slot} (before lecture ends). Penalty +50")
                total_penalty += 50
            tut_times = TIME_SLOTS[slot]
            tut_start = parse_time(tut_times[0])
            _, tut_building, _ = get_full_location_details(room, conn)
            if lec_building and tut_building and lec_building != tut_building:
                required_travel = travel_time_map.get((lec_building, tut_building), 60)
                gap = tut_start - lec_end
                if gap < required_travel:
                    diff = required_travel - gap
                    penalty = diff * 15
                    conflicts.append(f"{subj} travel conflict between lecture and tutorial on {day}: gap {gap} min, required {required_travel} min. Penalty +{penalty}")
                    total_penalty += penalty
            tut_key = (day, slot, room)
            room_usage.setdefault(tut_key, []).append((subj, "tutorial"))

    # Room conflicts
    for key, uses in room_usage.items():
        if len(uses) > 1:
            day, slot, room = key
            details = ", ".join([f"{s} ({typ})" for s, typ in uses])
            penalty = 100 * (len(uses) - 1)
            conflicts.append(f"Room conflict on {day} slot {slot} in room {room}: {details}. Penalty +{penalty}")
            total_penalty += penalty

    # Same course lecture slot conflicts
    if subject_course_mapping:
        course_day_lectures = {}
        for subj, sessions in candidate.items():
            course = subject_course_mapping.get(subj)
            if not course:
                continue
            day = sessions.get("day", "monday").lower()
            if "lecture" in sessions:
                lec_slot = sessions["lecture"][0]
            elif "lectures" in sessions:
                lec_slot = sessions["lectures"][0][0]
            else:
                continue
            key = (course, day)
            course_day_lectures.setdefault(key, []).append((subj, lec_slot))
        for (course, day), pairs in course_day_lectures.items():
            seen = {}
            for subj, slot in pairs:
                if slot in seen:
                    penalty = 100
                    conflicts.append(f"{subj} and {seen[slot]} (same course '{course}') share lecture slot {slot} on {day}. Penalty +{penalty}")
                    total_penalty += penalty
                else:
                    seen[slot] = subj

    conflicts.append(f"\n[Total Penalty Explained: {total_penalty}]")
    return conflicts
