import json
import pymysql

from config import TIME_SLOTS
from database import get_location_details, get_travel_time, get_subject_details_for_course, cache_travel_times


def parse_time(time_str):
    parts = time_str.split(":")
    return int(parts[0]) * 60 + int(parts[1])


def get_session_times(slot):
    times = TIME_SLOTS[int(slot)]
    return parse_time(times[0]), parse_time(times[1])


def build_options(global_session, conn):
    options = {"day": global_session.get("day", "Monday").capitalize()}
    lecture_opts = []
    if "lecture" in global_session:
        lec = global_session["lecture"]
        slot, room = lec
        start, end = get_session_times(slot)
        building, room_name = get_location_details(room, conn)
        lecture_opts.append({"slot": slot, "start": start, "end": end, "building": building, "room": room_name})
    elif "lectures" in global_session:
        for slot, room in global_session["lectures"]:
            start, end = get_session_times(slot)
            building, room_name = get_location_details(room, conn)
            lecture_opts.append({"slot": slot, "start": start, "end": end, "building": building, "room": room_name})
    options["lecture_options"] = lecture_opts

    tutorial_opts = []
    for slot, room in global_session.get("tutorials", []):
        start, end = get_session_times(slot)
        building, room_name = get_location_details(room, conn)
        tutorial_opts.append({"slot": slot, "start": start, "end": end, "building": building, "room": room_name})
    options["tutorial_options"] = tutorial_opts

    return options


def allocate_student_timetable_conflict_free(subject_codes, global_schedule, conn, travel_time_map):
    allocation = {}
    allocated_sessions = {}

    for subj in sorted(subject_codes):
        global_session = global_schedule.get(subj)
        if not global_session:
            allocation[subj] = None
            continue
        opts = build_options(global_session, conn)
        day = opts["day"]
        allocated_sessions.setdefault(day, [])
        chosen_option = None

        for lec in opts["lecture_options"]:
            for tut in opts["tutorial_options"]:
                option = {"day": day, "lecture": lec, "tutorial": tut}
                conflict = False
                for sess in allocated_sessions[day]:
                    if not (lec["end"] <= sess["start"] or lec["start"] >= sess["end"]):
                        conflict = True
                        break
                    if not (tut["end"] <= sess["start"] or tut["start"] >= sess["end"]):
                        conflict = True
                        break
                    if lec["building"] != sess["building"]:
                        req = get_travel_time(lec["building"], sess["building"], travel_time_map)
                        if lec["start"] - sess["end"] < req and lec["start"] > sess["end"]:
                            conflict = True
                            break
                    if tut["building"] != sess["building"]:
                        req = get_travel_time(tut["building"], sess["building"], travel_time_map)
                        if tut["start"] - sess["end"] < req and tut["start"] > sess["end"]:
                            conflict = True
                            break
                if not conflict:
                    chosen_option = option
                    allocated_sessions[day].append(lec)
                    allocated_sessions[day].append(tut)
                    break
            if chosen_option:
                break

        if not chosen_option:
            lec = opts["lecture_options"][0] if opts["lecture_options"] else None
            tut = opts["tutorial_options"][0] if opts["tutorial_options"] else None
            chosen_option = {"day": day, "lecture": lec, "tutorial": tut}
            if lec:
                allocated_sessions[day].append(lec)
            if tut:
                allocated_sessions[day].append(tut)
        allocation[subj] = chosen_option
    return allocation


def print_student_timetable(allocation):
    print("\n--- Final Allocated Timetable ---")
    for subj, option in allocation.items():
        if option is None:
            print(f"Subject {subj}: No schedule allocated.")
            continue
        print(f"Subject {subj}:")
        day = option.get("day", "Unknown")
        lec = option.get("lecture")
        if lec:
            start, end = lec["start"], lec["end"]
            print(f"  Lecture: {day}, {start//60:02d}:{start%60:02d} - {end//60:02d}:{end%60:02d} in {lec['building']} - {lec['room']}")
        else:
            print("  Lecture: Not allocated.")
        tut = option.get("tutorial")
        if tut:
            start, end = tut["start"], tut["end"]
            print(f"  Tutorial: {day}, {start//60:02d}:{start%60:02d} - {end//60:02d}:{end%60:02d} in {tut['building']} - {tut['room']}")
        else:
            print("  Tutorial: Not allocated.")


# --- Main Execution ---

if __name__ == '__main__':
    try:
        student_id = int(input("Enter Student ID: ").strip())
        term = int(input("Enter term (1 for first term, 2 for second term): ").strip())
        if term not in [1, 2]:
            raise ValueError("Term must be 1 or 2.")
    except ValueError as e:
        print(f"Input error: {e}")
        exit(1)

    conn = pymysql.connect(
        host='localhost',
        user='root',
        password='Nadiy512002',
        database='UniversityTimetabling'
    )

    try:
        travel_time_map = cache_travel_times(conn)

        cursor = conn.cursor()
        cursor.execute("SELECT student_id, course_code, course_name, department, year FROM Students WHERE student_id = %s", (student_id,))
        student = cursor.fetchone()
        cursor.close()
        if not student:
            print(f"No student found with ID {student_id}.")
            exit(1)

        student_id, course_code, course_name, dept, year = student
        print(f"\nStudent ID: {student_id}")
        print(f"Course: {course_code} - {course_name}")
        print(f"Department: {dept}")
        print(f"Year: {year}, Term: {term}\n")

        subject_details = get_subject_details_for_course(course_code, year, term, conn)
        if not subject_details:
            print("No subject details found for this student's course and term.")
            exit(1)
        subject_codes = list(subject_details.keys())
        print("Student is enrolled in the following subjects:")
        for code, name in subject_details.items():
            print(f"  {code}: {name}")
        print()

        try:
            with open("final_schedule.json", "r") as f:
                global_schedule = json.load(f)
        except FileNotFoundError:
            print("Error: final_schedule.json not found. Please run main.py first.")
            exit(1)

        allocation = allocate_student_timetable_conflict_free(subject_codes, global_schedule, conn, travel_time_map)
        print_student_timetable(allocation)

    finally:
        conn.close()
