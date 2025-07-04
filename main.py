import json

import pymysql

from config import TIME_SLOTS
from database import (
    get_course_info,
    get_subject_details_for_course,
    get_all_subject_details,
    get_combined_students_availabilities_for_subjects,
    get_professor_availabilities,
    get_location_details,
    get_students_availabilities_for_course,
    cache_location_details,
    cache_travel_times,
    cache_room_capacities
)
from ga import genetic_algorithm
from global_scheduler import global_schedule_genetic_algorithm, explain_global_conflicts
from scheduling import (
    calculate_students_per_subject,
    generate_all_subjects_matching,
    subject_matching_count
)

if __name__ == '__main__':
    conn = pymysql.connect(
        host='localhost',
        user='root',
        password='Nadiy512002',
        database='UniversityTimetabling'
    )

    location_cache = cache_location_details(conn)
    travel_time_map = cache_travel_times(conn)
    room_capacities = cache_room_capacities(conn)

    try:
        # Course-specific availability first
        print("\n----- Course-Specific Availability and Matching -----")
        user_input = input("Enter the course code or full course name (e.g., BM001 or Business Management (Extended), BA Hons): ").strip()
        course_code, course_name = get_course_info(user_input, conn)
        if not course_code or not course_name:
            print(f"Course '{user_input}' is not recognised. Exiting.")
            exit(1)
        print(f"Course found: {course_code} - {course_name}")

        year = int(input("Enter the study year (e.g., 1, 2, or 3): ").strip())
        term = int(input("Enter the term (e.g., 1 for first term, 2 for second term): ").strip())

        subject_details = get_subject_details_for_course(course_code, year, term, conn)
        subject_codes = list(subject_details.keys())
        prof_avail_filtered = get_professor_availabilities(subject_codes, conn)
        students_avails = get_students_availabilities_for_course(course_code, year, conn)

        print(f"\nRetrieved {len(students_avails)} student availabilities for {course_code}, Year {year}.")
        best_schedule, best_score = genetic_algorithm(subject_codes, prof_avail_filtered, students_avails)

        print("\n--- Optimal Schedule Based on Professor Availability ---")
        for subj in subject_codes:
            print(f"  {subj} - {subject_details.get(subj, '')}: {best_schedule.get(subj, 'N/A').capitalize()}")

        combined_students_avails = get_combined_students_availabilities_for_subjects(subject_codes, year, term, conn)

        print("\n--- Matching Percentages (Combined Students Across Departments) ---")
        for subj in subject_codes:
            total = len(combined_students_avails.get(subj, []))
            print(f"\nSubject {subj} - {subject_details.get(subj, '')}:")
            for day in prof_avail_filtered.get(subj, {}):
                matched = subject_matching_count(subj, day, prof_avail_filtered, combined_students_avails.get(subj, []))
                percent = (matched / total * 100) if total else 0
                chosen = " <-- Chosen" if best_schedule.get(subj, '').lower() == day.lower() else ""
                print(f"  {day.capitalize()}: {percent:.2f}% ({matched}/{total}){chosen}")

        # Matching for all years and terms
        generate_all_years = input("\nGenerate matching stats for ALL years and terms? (y/n): ").strip().lower()
        if generate_all_years == 'y':
            term_choice = input("Term choice ('1', '2', or 'both'): ").strip().lower()
            terms = [1, 2] if term_choice == 'both' else [int(term_choice)]
            for y in [1, 2, 3]:
                for t in terms:
                    print(f"\nYear {y}, Term {t}")
                    generate_all_subjects_matching(y, t, conn)

        # Global timetable generation
        print("\n----- Global Timetable Generation -----")
        generate_global = input("Generate Global Timetable for all departments (all 3 years)? (y/n): ").strip().lower()
        if generate_global == 'y':
            term = int(input("Enter term (1 or 2): ").strip())

            combined_day_mapping = {}
            all_subjects = {}

            for yr in [1, 2, 3]:
                print(f"\nProcessing Year {yr}...")
                year_subjects = get_all_subject_details(yr, term, conn)
                for subj in year_subjects:
                    all_subjects[subj] = yr
                prof_avail = get_professor_availabilities(list(year_subjects.keys()), conn)
                combined_avail = get_combined_students_availabilities_for_subjects(list(year_subjects.keys()), yr, term, conn)
                for subj in year_subjects:
                    if prof_avail[subj] and combined_avail[subj]:
                        best_day, _ = genetic_algorithm([subj], {subj: prof_avail[subj]}, combined_avail[subj])
                        combined_day_mapping.update(best_day)

            subject_student_counts = calculate_students_per_subject(list(all_subjects.keys()), 1, term, conn)

            cursor = conn.cursor()
            cursor.execute("SELECT subject_code, subject_name, course_name, department_name, year FROM Departments WHERE term = %s", (term,))
            rows = cursor.fetchall()
            cursor.close()

            subject_info = {}
            for row in rows:
                subj, subj_name, course, dept, yr = row
                subject_info.setdefault(subj, []).append({
                    "subject_name": subj_name,
                    "course_name": course,
                    "department": dept,
                    "year": yr
                })

            subject_course_mapping = {subj: info[0]["course_name"] for subj, info in subject_info.items()}

            final_schedule, penalty = global_schedule_genetic_algorithm(
                subject_codes=list(all_subjects.keys()),
                conn=conn,
                day_mapping=combined_day_mapping,  # <--- FIXED this line
                subject_student_counts=subject_student_counts,
                subject_course_mapping=subject_course_mapping,
                location_cache=location_cache,
                travel_time_map=travel_time_map
            )

            with open("final_schedule.json", "w") as f:
                json.dump(final_schedule, f)
            print("\nSaved timetable to final_schedule.json.")

            grouped = {}
            for subj, info_list in subject_info.items():
                for info in info_list:
                    grouped.setdefault(info["year"], {}).setdefault(info["department"], {}).setdefault(info["course_name"], {})[subj] = final_schedule.get(subj)

            print("\n=== Grouped Timetable ===")
            for yr in grouped:
                print(f"\nYear {yr}")
                for dept in grouped[yr]:
                    print(f"  Department: {dept}")
                    for course in grouped[yr][dept]:
                        print(f"    Course: {course}")
                        for subj in grouped[yr][dept][course]:
                            data = grouped[yr][dept][course][subj]
                            subj_name = subject_info[subj][0]["subject_name"]
                            print(f"      {subj} - {subj_name}:")
                            if not data:
                                print("         No schedule.")
                                continue
                            day = data["day"].capitalize()
                            if "lecture" in data:
                                lec_slot, lec_room = data["lecture"]
                                lec_time = TIME_SLOTS[lec_slot]
                                bldg, room = get_location_details(lec_room, conn)
                                print(f"         Lecture: {day}, {lec_time[0]} - {lec_time[1]} in {bldg} - {room}")
                            elif "lectures" in data:
                                for idx, (lec_slot, lec_room) in enumerate(data["lectures"], 1):
                                    lec_time = TIME_SLOTS[lec_slot]
                                    bldg, room = get_location_details(lec_room, conn)
                                    print(f"         Lecture {idx}: {day}, {lec_time[0]} - {lec_time[1]} in {bldg} - {room}")
                            for idx, (slot, room_id) in enumerate(data["tutorials"], 1):
                                tut_time = TIME_SLOTS[slot]
                                bldg, rm = get_location_details(room_id, conn)
                                print(f"         Tutorial {idx}: {day}, {tut_time[0]} - {tut_time[1]} in {bldg} - {rm}")

            print(f"\nTotal schedule penalty: {penalty}")
            conflicts = explain_global_conflicts(final_schedule, subject_student_counts, conn, location_cache, travel_time_map)
            if conflicts:
                print("\n=== Global Conflicts ===")
                for c in conflicts:
                    print(c)
            else:
                print("\nNo global conflicts detected.")

    finally:
        conn.close()
