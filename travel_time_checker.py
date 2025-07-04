import pymysql
import json
from config import TIME_SLOTS


# Helper: Retrieve full location details for a room_id.
def get_full_location_details(room_id, conn):
    """
    Returns a tuple (city_name, building_name, room_name)
    from the Locations table for a given room_id.
    """
    cursor = conn.cursor()
    query = "SELECT city_name, building_name, room_name FROM Locations WHERE location_id = %s"
    cursor.execute(query, (room_id,))
    row = cursor.fetchone()
    cursor.close()
    if row:
        return row
    return (None, None, None)


def parse_time(time_str):
    parts = time_str.split(":")
    return int(parts[0]) * 60 + int(parts[1])


# Get required travel time between two buildings using TravelTimes table.
def get_travel_time(origin_building, destination_building, conn):
    """
    Returns the travel time (in minutes) between two buildings.
    Searches the TravelTimes table for a match (in either direction).
    If no match is found, returns a default travel time (e.g., 60 minutes).
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


def check_subject_travel(schedule, conn):
    """
    For each subject in the timetable, check that the gap between the lecture’s end time
    and each tutorial’s start time is sufficient if they are held in different cities.
    Returns a list of conflict messages.
    """
    conflicts = []
    # Iterate over each subject in the schedule.
    for subj, data in schedule.items():
        if "lecture" not in data:
            continue  # skip subjects with no lecture data.
        day = data.get("day", "monday")
        lec_slot, lec_room = data["lecture"]
        # Retrieve lecture times (assumed to be in TIME_SLOTS as ("HH:MM", "HH:MM"))
        lec_start_str, lec_end_str = TIME_SLOTS[lec_slot]
        lec_end = parse_time(lec_end_str)
        # Get lecture location details.
        lec_city, lec_building, _ = get_full_location_details(lec_room, conn)
        # Check each tutorial.
        for idx, (slot, room) in enumerate(data.get("tutorials", []), 1):
            tut_start_str, _ = TIME_SLOTS[slot]
            tut_start = parse_time(tut_start_str)
            # Get tutorial location details.
            tut_city, tut_building, _ = get_full_location_details(room, conn)
            # Only check travel if the lecture and tutorial are in different cities.
            if lec_city and tut_city and lec_city.lower() != tut_city.lower():
                required = get_travel_time(lec_building, tut_building, conn)
                gap = tut_start - lec_end
                if gap < required:
                    conflicts.append(
                        f"{subj} on {day.capitalize()}: Lecture in {lec_building} (ends at {lec_end_str}) and Tutorial {idx} in {tut_building} (starts at {tut_start_str}) have insufficient travel gap: required {required} min, gap is {gap} min."
                    )
    return conflicts


def main():
    # Load the timetable from final_schedule.json.
    try:
        with open("final_schedule.json", "r") as f:
            timetable = json.load(f)
    except Exception as e:
        print("Error loading final_schedule.json:", e)
        return

    # Connect to the database.
    conn = pymysql.connect(
        host='localhost',
        user='root',
        password='Nadiy512002',
        database='UniversityTimetabling'
    )

    try:
        conflicts = check_subject_travel(timetable, conn)
        if conflicts:
            print("\nTravel Time Conflicts between Lecture and Tutorials for each subject:")
            for conflict in conflicts:
                print("  -", conflict)
        else:
            print(
                "\nAll subjects have sufficient travel time between lecture and tutorials (when in different cities).")
    finally:
        conn.close()


if __name__ == '__main__':
    main()
