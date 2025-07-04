def calculate_students_per_subject(subject_codes: list, year: int, term: int, conn) -> dict:
    """
    Calculate the total number of students per subject across different courses.
    """
    total_students_per_subject = {}
    query = "SELECT DISTINCT course_name FROM Departments WHERE subject_code = %s AND year = %s AND term = %s"
    from database import get_course_code_from_name, get_student_count_for_course
    for subject in subject_codes:
        cursor = conn.cursor()
        cursor.execute(query, (subject, year, term))
        rows = cursor.fetchall()
        cursor.close()
        total = 0
        for row in rows:
            course_name = row[0]
            course_code = get_course_code_from_name(course_name, conn)
            if course_code:
                count = get_student_count_for_course(course_code, year, conn)
                total += count
        total_students_per_subject[subject] = total
    return total_students_per_subject


def calculate_matching_percentage_all(subjects: list, best_schedule: dict, professor_avail: dict,
                                      combined_students_avails: dict) -> dict:
    """
    For each subject, calculate the matching percentage based on the GA optimal schedule,
    using combined student availabilities from all courses offering that subject.
    Returns a dictionary mapping subject_code -> (matching_count, matching_percentage).
    """
    percentages = {}
    for subject in subjects:
        total = len(combined_students_avails.get(subject, []))
        if total > 0:
            chosen_day = best_schedule.get(subject, None)
            if chosen_day:
                count = subject_matching_count(subject, chosen_day, professor_avail, combined_students_avails[subject])
                percentages[subject] = (count, (count / total) * 100)
            else:
                percentages[subject] = (0, 0.0)
        else:
            percentages[subject] = (0, 0.0)
    return percentages


def generate_all_subjects_matching(year: int, term: int, conn) -> None:
    """
    Generate and print detailed matching percentages for ALL subjects (across all departments)
    for the given study year and term.
    Uses combined student availabilities (from all courses) as the denominator.
    If no combined student availabilities exist for a subject, still shows professor-provided available days with 0% matching.
    """
    from database import get_all_subject_details, get_combined_students_availabilities_for_subjects, get_professor_availabilities
    all_subject_details = get_all_subject_details(year, term, conn)
    all_subject_codes = list(all_subject_details.keys())
    combined_students_avails = get_combined_students_availabilities_for_subjects(all_subject_codes, year, term, conn)
    all_prof_avail = get_professor_availabilities(all_subject_codes, conn)

    print(f"\nDetailed matching percentages for ALL subjects for Year {year}, Term {term} (using combined student counts):")
    for subject in all_subject_codes:
        subj_name = all_subject_details.get(subject, "Unknown Subject")
        total_combined = len(combined_students_avails.get(subject, []))
        print(f"\nSubject {subject} - {subj_name}:")
        avail_days = all_prof_avail.get(subject, {})
        if total_combined == 0:
            for day in avail_days.keys():
                print(f"  {day.capitalize()}: 0.00% matching (0 / 0 students)")
        else:
            for day, session in avail_days.items():
                count = subject_matching_count(subject, day, all_prof_avail, combined_students_avails.get(subject, []))
                percentage = (count / total_combined * 100)
                print(f"  {day.capitalize()}: {percentage:.2f}% matching ({count} / {total_combined} students)")


def subject_matching_count(subject: str, chosen_day: str, professor_avail: dict, students_avails: list) -> int:
    """
    Compute the number of students whose availability on the chosen day for a subject
    covers the professor's session time.
    Returns the matching student count.
    """
    count = 0
    if subject in professor_avail:
        session_time = professor_avail[subject].get(chosen_day, None)
        if session_time:
            for student in students_avails:
                if chosen_day in student:
                    stud_time = student[chosen_day]
                    if stud_time[0] <= session_time[0] and stud_time[1] >= session_time[1]:
                        count += 1
    return count


def explain_schedule_penalty(candidate, conn, subject_student_counts, day_mapping):
    """
    Explain the penalties incurred by a scheduling candidate.
    """
    explanation = []
    room_usage = {}  # (day, slot, room) -> list of (subject, type)
    total_penalty = 0

    for subj, sessions in candidate.items():
        day = day_mapping.get(subj, "unscheduled").capitalize()
        lec_slot, lec_room = sessions['lecture']
        lec_key = (day, lec_slot, lec_room)
        room_usage.setdefault(lec_key, []).append((subj, 'Lecture'))

        cursor = conn.cursor()
        cursor.execute("SELECT capacity, building_name, room_name FROM Locations WHERE location_id = %s",
                       (lec_room,))
        row = cursor.fetchone()
        cursor.close()

        room_capacity = row[0] if row else 0
        building = row[1] if row else "Unknown"
        room_name = row[2] if row else "Unknown"
        student_count = subject_student_counts.get(subj, 0)

        if student_count > room_capacity:
            excess = student_count - room_capacity
            penalty = excess * 10
            total_penalty += penalty
            explanation.append(
                f" {subj}: Lecture in {building} {room_name} has capacity {room_capacity}, but {student_count} students enrolled (+{penalty})")

        tutorial_slots = []
        for idx, (slot, room) in enumerate(sessions['tutorials']):
            tut_key = (day, slot, room)
            room_usage.setdefault(tut_key, []).append((subj, f'Tutorial {idx + 1}'))

            if slot <= lec_slot:
                total_penalty += 50
                explanation.append(
                    f" {subj}: Tutorial {idx + 1} is scheduled at slot {slot}, before or same as lecture slot {lec_slot} (+50)")
            if slot in tutorial_slots:
                total_penalty += 20
                explanation.append(f" {subj}: Tutorial {idx + 1} uses duplicate slot {slot} (+20)")
            else:
                tutorial_slots.append(slot)

    for key, uses in room_usage.items():
        if len(uses) > 1:
            clash_penalty = 100 * (len(uses) - 1)
            total_penalty += clash_penalty
            day, slot, room_id = key
            cursor = conn.cursor()
            cursor.execute("SELECT building_name, room_name FROM Locations WHERE location_id = %s", (room_id,))
            row = cursor.fetchone()
            cursor.close()
            building = row[0] if row else "Unknown"
            room_name = row[1] if row else "Unknown"
            clash_list = ', '.join([f"{subj} ({typ})" for subj, typ in uses])
            explanation.append(
                f" Room Clash on {day} slot {slot} in {building} {room_name}: {clash_list} (+{clash_penalty})")

    print("\n=== Detailed Schedule Conflict Report ===")
    if not explanation:
        print(" No conflicts found — schedule is clean!")
    else:
        for line in explanation:
            print(line)
        print(f"\n Total penalty explained: {total_penalty}")


def explain_global_penalty(schedule, conn):
    """
    Explain the penalty details for the global schedule.
    """
    print("\n=== Conflict Report for Global Schedule ===")
    room_usage = {}
    total_penalty = 0
    explanation = []

    for subj, data in schedule.items():
        day = data['day'].capitalize()
        lec_slot, lec_room = data['lecture']
        lec_key = (day, lec_slot, lec_room)
        room_usage.setdefault(lec_key, []).append((subj, 'Lecture'))

        for idx, (slot, room) in enumerate(data['tutorials']):
            if slot <= lec_slot:
                total_penalty += 50
                explanation.append(f" {subj}: Tutorial {idx + 1} before or at same time as lecture (+50)")
            tut_key = (day, slot, room)
            room_usage.setdefault(tut_key, []).append((subj, f'Tutorial {idx + 1}'))

    for key, uses in room_usage.items():
        if len(uses) > 1:
            day, slot, room_id = key
            cursor = conn.cursor()
            cursor.execute("SELECT building_name, room_name FROM Locations WHERE location_id = %s", (room_id,))
            row = cursor.fetchone()
            cursor.close()
            building = row[0] if row else "Unknown"
            room_name = row[1] if row else "Unknown"
            clash_penalty = 100 * (len(uses) - 1)
            total_penalty += clash_penalty
            conflicts = ', '.join([f"{s} ({typ})" for s, typ in uses])
            explanation.append(
                f" Room Clash on {day} slot {slot} in {building} {room_name}: {conflicts} (+{clash_penalty})")

    if not explanation:
        print(" No conflicts found!")
    else:
        for line in explanation:
            print(line)
        print(f"\n Total penalty explained: {total_penalty}")
