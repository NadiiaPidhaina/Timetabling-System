# University Timetable Scheduler

A Python-based scheduling system for generating, optimising, and managing university timetables. This project ingests course and room data, applies optimisation algorithms, and produces student and room allocation schedules, along with various utility reports and tools.

## Features
- Configuration management via `main.py`, `student_room_allocation.py`, `student_schedule.py`, `travel_time_checker.py`, `unused_rooms_report.py`
- Core scheduling engine with customisable constraints
- Core scheduling logic, including constraint handling (`scheduling.py`)
- Database integration with MySQL/SQLite schema (`UniversityTimetable.sql`, `database.py`)
- Genetic Algorithm optimisation for balanced timetables (`ga.py`)
- Global scheduler script (`global_scheduler.py`)
- Main scheduler entry point and CLI interface (`main.py`)
- Professor’s availability and automatic generation of students’ availability (`availability.py`)
- Room allocation module to assign courses to available rooms (`student_room_allocation.py`)
- Schedule ingestion and parsing from JSON and SQL sources
- Student timetable generation (console and GUI) (`student_schedule.py`, `student_schedule_gui.py`)
- Timeslot management via `time_slot.py`
- Travel-time feasibility checker for lectures and tutorials (`travel_time_checker.py`)
- Unused rooms reporting to identify free rooms (`unused_rooms_report.py`)

## Prerequisites
- Python 3.8 or higher
- `pip` for package installation
- MySQL or SQLite database (see `UniversityTimetable.sql`)

## Installation
1. Ensure Python 3.8 or higher is installed.
2. Install required Python packages:
   ```bash
   pymysql>=1.0.2
   PyQt5>=5.15.2
   ```
3. Configure database connection in `main.py`, `student_room_allocation.py`, `student_schedule.py`, `travel_time_checker.py`, `unused_rooms_report.py`:
   ```python
   if __name__ == '__main__':
       conn = pymysql.connect(
           host='',
           user='',
           password='',
           database='UniversityTimetabling'
       )
   ```
4. Initialise the database schema:
   ```bash
   mysql -u your_user -p university_timetable < UniversityTimetable.sql
   ```

## Usage
Follow these steps to run each component of the scheduling system:
### Generate a Schedule
Run the main scheduler:
```bash
python main.py --input final_schedule.json --output 
```
### Matching Statistics
Generate student–availability matching percentages for all subjects:
```bash
python main.py --match-stats --year <YEAR> --term <TERM>

```
### Generate the Global Schedule  
Create a master timetable for all subjects across departments and years:
```bash
python main.py --input final_schedule.json --output output_schedule.json
```

### Student Timetable
- **Console version**:
  ```bash
  python student_schedule.py --student-id <58654>
  ```
- **GUI version**:
  ```bash
  python student_schedule_gui.py
  ```

### Room Allocation Report
```bash
python unused_rooms_report.py --schedule final_schedule.json
```

### Travel Time Check
```bash
python travel_time_checker.py --schedule final_schedule.json
```



## Project Structure
```
├── availability.py            # Helpers to generate/parse student & professor availabilities
├── config.py                  # Time‑slot definitions and global constants
├── database.py                # MySQL connection & query utilities
├── ga.py                      # Core genetic‑algorithm implementation
├── global_scheduler.py        # “Global” GA: builds full uni‑wide schedule
├── main.py                    # CLI entry point for timetable generation
├── scheduling.py              # Shared scheduling helpers & scoring functions
├── student_room_allocation.py # Algorithms to allocate students into rooms
├── student_schedule.py        # Console tool: student‑specific timetable view
├── student_schedule_gui.py    # GUI frontend for student timetable lookup
├── travel_time_checker.py     # Finds tight lecture→tutorial transitions
├── unused_rooms_report.py     # Reports on unused or under‑utilised rooms
├── final_schedule.json        # Last‑run global timetable output
└── README.md                  # Project overview & instructions

```
