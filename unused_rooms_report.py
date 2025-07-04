import json

import pymysql

from config import TIME_SLOTS


def load_final_schedule():
    try:
        with open("final_schedule.json", "r") as f:
            schedule = json.load(f)
        return schedule
    except Exception as e:
        print("Error loading final_schedule.json:", e)
        return None


def get_all_rooms(conn):
    cursor = conn.cursor()
    query = """
        SELECT location_id, building_name, room_name, room_type 
        FROM Locations 
        WHERE room_type IN ('Classroom', 'LectureTheatre') 
          AND room_name IS NOT NULL
    """
    cursor.execute(query)
    rows = cursor.fetchall()
    cursor.close()
    # Build dictionary: room_id -> { building, room, room_type }
    rooms = {}
    for row in rows:
        room_id, building, room, room_type = row
        rooms[room_id] = {
            "building": building,
            "room": room,
            "room_type": room_type
        }
    return rooms


def build_used_rooms(schedule):
    """
    Build a dictionary mapping each day to a mapping of time slot -> set of room_ids used.
    Assume schedule is a dictionary with subject codes as keys. Each subject has:
      - "day": a string (e.g., "monday")
      - "lecture": [slot, room_id]
      - "tutorials": list of [slot, room_id]
    """
    used = {}
    days = ["monday", "tuesday", "wednesday", "thursday", "friday"]
    # Initialise dictionary for each day and each time slot.
    for d in days:
        used[d] = {slot: set() for slot in TIME_SLOTS.keys()}
    for subj, data in schedule.items():
        day = data.get("day", "monday").lower()
        # Lecture
        lec = data.get("lecture")
        if lec:
            lec_slot, lec_room = lec
            used.setdefault(day, {}).setdefault(lec_slot, set()).add(lec_room)
        # Tutorials
        for tut in data.get("tutorials", []):
            slot, room = tut
            used.setdefault(day, {}).setdefault(slot, set()).add(room)
    return used


def report_unused_rooms(conn, schedule):
    used_rooms = build_used_rooms(schedule)
    all_rooms = get_all_rooms(conn)
    # For each day and time slot, list room_ids that are not used.
    report = {}
    for day in ["monday", "tuesday", "wednesday", "thursday", "friday"]:
        report[day] = {}
        for slot in TIME_SLOTS.keys():
            # All rooms available (room ids) from our all_rooms dictionary.
            all_room_ids = set(all_rooms.keys())
            used = used_rooms.get(day, {}).get(slot, set())
            unused = all_room_ids - used
            report[day][slot] = list(unused)
    return report, all_rooms


def print_unused_rooms_report(report, all_rooms):
    print("\n=== Unused Rooms Report ===")
    for day in sorted(report.keys()):
        print(f"\nDay: {day.capitalize()}")
        for slot in sorted(report[day].keys()):
            time_range = TIME_SLOTS[slot]
            room_ids = report[day][slot]
            if room_ids:
                room_details = []
                for rid in room_ids:
                    # Look up full details.
                    details = all_rooms.get(rid)
                    if details:
                        room_details.append(f"{details['building']} - {details['room']} ({details['room_type']})")
                    else:
                        room_details.append(str(rid))
                details_str = ", ".join(room_details)
            else:
                details_str = "None"
            print(f"  Time slot {slot} ({time_range[0]} - {time_range[1]}): {details_str}")


def main():
    schedule = load_final_schedule()
    if schedule is None:
        return
    conn = pymysql.connect(
        host='localhost',
        user='root',
        password='Nadiy512002',
        database='UniversityTimetabling'
    )
    try:
        report, all_rooms = report_unused_rooms(conn, schedule)
        print_unused_rooms_report(report, all_rooms)
    finally:
        conn.close()

if __name__ == '__main__':
    main()
