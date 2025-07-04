from availability import generate_random_student_availability
from availability import parse_professor_availability


def get_course_info(user_input: str, conn) -> tuple:
    cursor = conn.cursor()
    query = "SELECT course_code, course_name FROM Courses WHERE course_code = %s OR course_name = %s LIMIT 1"
    cursor.execute(query, (user_input, user_input))
    row = cursor.fetchone()
    cursor.close()
    return (row[0], row[1]) if row else (None, None)


def get_course_name_from_code(course_code: str, conn) -> str:
    cursor = conn.cursor()
    query = "SELECT course_name FROM Courses WHERE course_code = %s"
    cursor.execute(query, (course_code,))
    row = cursor.fetchone()
    cursor.close()
    return row[0] if row else None


def get_course_code_from_name(course_name: str, conn) -> str:
    cursor = conn.cursor()
    query = "SELECT course_code FROM Courses WHERE course_name = %s LIMIT 1"
    cursor.execute(query, (course_name,))
    row = cursor.fetchone()
    cursor.close()
    return row[0] if row else None


def get_subject_details_for_course(course_code: str, year: int, term: int, conn) -> dict:
    course_name = get_course_name_from_code(course_code, conn)
    if not course_name:
        return {}
    cursor = conn.cursor()
    query = "SELECT DISTINCT subject_code, subject_name FROM Departments " \
            "WHERE course_name = %s AND year = %s AND term = %s"
    cursor.execute(query, (course_name, year, term))
    rows = cursor.fetchall()
    cursor.close()
    return {row[0]: row[1] for row in rows}


def get_all_subject_details(year: int, term: int, conn) -> dict:
    cursor = conn.cursor()
    query = "SELECT DISTINCT subject_code, subject_name FROM Departments WHERE year = %s AND term = %s"
    cursor.execute(query, (year, term))
    rows = cursor.fetchall()
    cursor.close()
    return {row[0]: row[1] for row in rows}


def get_student_count_for_course(course_code: str, year: int, conn) -> int:
    cursor = conn.cursor()
    query = "SELECT COUNT(*) FROM Students WHERE course_code = %s AND year = %s"
    cursor.execute(query, (course_code, year))
    row = cursor.fetchone()
    cursor.close()
    return row[0] if row else 0


def get_students_availabilities_for_course(course_code: str, year: int, conn) -> list:
    count = get_student_count_for_course(course_code, year, conn)
    return [generate_random_student_availability() for _ in range(count)]


def get_combined_students_availabilities_for_subjects(subject_codes: list, year: int, term: int, conn) -> dict:
    subject_students = {}
    cursor = conn.cursor()
    query = "SELECT DISTINCT course_name FROM Departments WHERE subject_code = %s AND year = %s AND term = %s"
    for subject in subject_codes:
        cursor.execute(query, (subject, year, term))
        rows = cursor.fetchall()
        courses = [row[0] for row in rows]
        all_avail = []
        for course in courses:
            course_code = get_course_code_from_name(course, conn)
            if course_code:
                avail = get_students_availabilities_for_course(course_code, year, conn)
                all_avail.extend(avail)
        subject_students[subject] = all_avail
    cursor.close()
    return subject_students


def get_location_details(room_id, conn):
    cursor = conn.cursor()
    query = "SELECT building_name, room_name FROM Locations WHERE location_id = %s"
    cursor.execute(query, (room_id,))
    row = cursor.fetchone()
    cursor.close()
    return row if row else ("Unknown", "Unknown")


def get_available_rooms(room_type, conn):
    cursor = conn.cursor()
    query = "SELECT location_id, building_name, room_name, capacity FROM Locations WHERE room_type = %s"
    cursor.execute(query, (room_type,))
    rooms = cursor.fetchall()
    cursor.close()
    return rooms


def get_professor_availabilities(subject_codes: list, conn) -> dict:
    professor_availabilities = {}
    cursor = conn.cursor()
    for subject_code in subject_codes:
        query = "SELECT DISTINCT subject_name FROM Departments WHERE subject_code = %s LIMIT 1"
        cursor.execute(query, (subject_code,))
        row = cursor.fetchone()
        if row:
            subject_name = row[0]
            query2 = "SELECT availability FROM Professors WHERE subject = %s LIMIT 1"
            cursor.execute(query2, (subject_name,))
            prof_row = cursor.fetchone()
            if prof_row and prof_row[0]:
                avail_str = prof_row[0]
                avail_dict = parse_professor_availability(avail_str)
                professor_availabilities[subject_code] = avail_dict
            else:
                professor_availabilities[subject_code] = {}
        else:
            professor_availabilities[subject_code] = {}
    cursor.close()
    return professor_availabilities


def get_professor_name(subject_name: str, conn) -> str:
    """
    Retrieve the professor's name for a given subject name.
    """
    cursor = conn.cursor()
    query = "SELECT name FROM Professors WHERE subject = %s LIMIT 1"
    cursor.execute(query, (subject_name,))
    row = cursor.fetchone()
    cursor.close()
    return row[0] if row else "Unknown"


def cache_location_details(conn):
    cursor = conn.cursor()
    cursor.execute("SELECT location_id, city_name, building_name, room_name FROM Locations")
    rows = cursor.fetchall()
    cursor.close()
    return {row[0]: (row[1], row[2], row[3]) for row in rows}


def cache_travel_times(conn):
    cursor = conn.cursor()
    cursor.execute("SELECT origin_name, destination_name, travel_time_minutes FROM TravelTimes")
    rows = cursor.fetchall()
    cursor.close()
    travel_time_map = {}
    for origin, dest, minutes in rows:
        travel_time_map[(origin, dest)] = minutes
        travel_time_map[(dest, origin)] = minutes
    return travel_time_map


def cache_room_capacities(conn):
    cursor = conn.cursor()
    cursor.execute("SELECT location_id, capacity FROM Locations")
    rows = cursor.fetchall()
    cursor.close()
    return {loc_id: capacity for loc_id, capacity in rows}


def get_travel_time(origin_building, destination_building, travel_time_map):
    return travel_time_map.get((origin_building, destination_building)) or \
           travel_time_map.get((destination_building, origin_building)) or 60
