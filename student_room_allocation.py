import json
from config import TIME_SLOTS
from database import get_location_details


def parse_time(time_str):
    parts = time_str.split(":")
    return int(parts[0]) * 60 + int(parts[1])


def get_session_times(slot):
    times = TIME_SLOTS[int(slot)]
    return parse_time(times[0]), parse_time(times[1])


def load_global_timetable(filename="final_schedule.json"):
    try:
        with open(filename, "r") as f:
            return json.load(f)
    except FileNotFoundError:
        print("Error: Global timetable file not found. Please run main.py first.")
        return None


def assign_session_for_student(student_id, global_session, conn):
    allocation = {}

    # Select lecture
    if "lecture" in global_session:
        lec = global_session["lecture"]
    elif "lectures" in global_session:
        lectures = global_session["lectures"]
        lec = lectures[student_id % len(lectures)]
    else:
        lec = None

    if lec:
        slot, room_id = lec
        start, end = get_session_times(slot)
        building, room = get_location_details(room_id, conn)
        allocation["lecture"] = {
            "slot": int(slot),
            "start": start,
            "end": end,
            "room": room,
            "building": building
        }
    else:
        allocation["lecture"] = None

    # Select tutorial
    tutorials = global_session.get("tutorials", [])
    if tutorials:
        tut = tutorials[student_id % len(tutorials)]
        slot, room_id = tut
        start, end = get_session_times(slot)
        building, room = get_location_details(room_id, conn)
        allocation["tutorial"] = {
            "slot": int(slot),
            "start": start,
            "end": end,
            "room": room,
            "building": building
        }
    else:
        allocation["tutorial"] = None

    allocation["day"] = global_session.get("day", "Monday").capitalize()
    return allocation


def build_student_enrollments(conn, term):
    enrollments = {}
    cursor = conn.cursor()
    cursor.execute("""
        SELECT s.student_id, d.subject_code
        FROM Students s
        JOIN Departments d ON s.course_name = d.course_name AND s.year = d.year
        WHERE d.term = %s
    """, (term,))
    for student_id, subject_code in cursor.fetchall():
        enrollments.setdefault(student_id, set()).add(subject_code)
    cursor.close()
    return {sid: list(subjs) for sid, subjs in enrollments.items()}


def allocate_all_students(global_schedule, enrollments, conn):
    lecture_allocations = {}
    tutorial_allocations = {}

    for student_id, subjects in enrollments.items():
        for subj in subjects:
            global_session = global_schedule.get(subj)
            if not global_session:
                continue
            allocation = assign_session_for_student(student_id, global_session, conn)
            if allocation["lecture"]:
                room = allocation["lecture"]["room"]
                lecture_allocations.setdefault(room, set()).add(student_id)
            if allocation["tutorial"]:
                room = allocation["tutorial"]["room"]
                tutorial_allocations.setdefault(room, set()).add(student_id)
    return lecture_allocations, tutorial_allocations


def print_room_allocations(allocations, session_type="Lecture"):
    print(f"\n=== {session_type} Allocations ===")
    for room, students in sorted(allocations.items()):
        print(f"Room {room}: {sorted(list(students))}")


# For external call (e.g. from main.py)
def run_room_allocation(term, conn, schedule_path="final_schedule.json"):
    global_schedule = load_global_timetable(schedule_path)
    if not global_schedule:
        return
    enrollments = build_student_enrollments(conn, term)
    if not enrollments:
        print(f"No enrollments found for term {term}")
        return
    lec_allocs, tut_allocs = allocate_all_students(global_schedule, enrollments, conn)
    print_room_allocations(lec_allocs, session_type="Lecture")
    print_room_allocations(tut_allocs, session_type="Tutorial")


# Optional standalone execution
if __name__ == '__main__':
    import pymysql
    try:
        conn = pymysql.connect(
            host='localhost',
            user='root',
            password='Nadiy512002',
            database='UniversityTimetabling'
        )
        term = int(input("Enter term for allocation (1 or 2): ").strip())
        run_room_allocation(term, conn)
    except Exception as e:
        print("Error:", e)
    finally:
        if 'conn' in locals():
            conn.close()
