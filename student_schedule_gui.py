import sys
import json
import pymysql
from PyQt5.QtWidgets import (
    QApplication, QMainWindow, QWidget,
    QVBoxLayout, QHBoxLayout, QLabel, QLineEdit,
    QPushButton, QComboBox, QTableWidget, QTableWidgetItem, QMessageBox
)
from PyQt5.QtGui import QColor, QBrush, QFont
from PyQt5.QtCore import Qt

from config import TIME_SLOTS
from database import (
    get_subject_details_for_course,
    get_professor_name,
    cache_location_details,
    cache_travel_times
)
from student_schedule import allocate_student_timetable_conflict_free


DAYS = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]


class TimetableWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Student Timetable Viewer")
        self.resize(1000, 600)
        self.setup_ui()

    def setup_ui(self):
        main_widget = QWidget()
        self.setCentralWidget(main_widget)
        layout = QVBoxLayout(main_widget)

        form_layout = QHBoxLayout()
        form_layout.addWidget(QLabel("Student ID:"))
        self.student_id_input = QLineEdit()
        form_layout.addWidget(self.student_id_input)

        form_layout.addWidget(QLabel("Term:"))
        self.term_combo = QComboBox()
        self.term_combo.addItems(["1", "2"])
        form_layout.addWidget(self.term_combo)

        self.load_button = QPushButton("Load Timetable")
        self.load_button.clicked.connect(self.on_load_timetable)
        form_layout.addWidget(self.load_button)

        layout.addLayout(form_layout)

        # Timetable grid
        self.table = QTableWidget()
        self.table.setRowCount(len(TIME_SLOTS))
        self.table.setColumnCount(len(DAYS))
        self.table.setHorizontalHeaderLabels(DAYS)
        for i, slot in enumerate(TIME_SLOTS):
            time_range = f"{TIME_SLOTS[slot][0]} - {TIME_SLOTS[slot][1]}"
            self.table.setVerticalHeaderItem(i, QTableWidgetItem(f"Slot {slot}\n{time_range}"))

        self.table.setEditTriggers(QTableWidget.NoEditTriggers)
        self.table.verticalHeader().setDefaultSectionSize(130)
        self.table.horizontalHeader().setDefaultSectionSize(160)
        layout.addWidget(self.table)

    def on_load_timetable(self):
        student_id_str = self.student_id_input.text().strip()
        if not student_id_str.isdigit():
            QMessageBox.warning(self, "Input Error", "Please enter a valid numeric Student ID.")
            return

        student_id = int(student_id_str)
        term = int(self.term_combo.currentText())

        try:
            conn = pymysql.connect(
                host='localhost',
                user='root',
                password='',
                database='UniversityTimetabling'
            )
            travel_map = cache_travel_times(conn)
            location_cache = cache_location_details(conn)

            with conn.cursor() as cursor:
                cursor.execute("SELECT student_id, course_code, course_name, department, year FROM Students WHERE student_id = %s", (student_id,))
                student = cursor.fetchone()
                if not student:
                    QMessageBox.warning(self, "Not Found", "Student not found.")
                    return

                sid, course_code, course_name, dept, year = student
                subjects = get_subject_details_for_course(course_code, year, term, conn)

                if not subjects:
                    QMessageBox.warning(self, "Not Found", "No subjects found for this student.")
                    return

                with open("final_schedule.json", "r") as f:
                    global_schedule = json.load(f)

                subject_codes = list(subjects.keys())
                allocation = allocate_student_timetable_conflict_free(subject_codes, global_schedule, conn, travel_map)

                self.populate_table(allocation, subjects, conn)

        except Exception as e:
            QMessageBox.critical(self, "Error", str(e))
        finally:
            if 'conn' in locals():
                conn.close()

    def populate_table(self, allocation, subject_details, conn):
        self.table.clearContents()

        for subj_code, session in allocation.items():
            if not session:
                continue

            day = session["day"]
            col = DAYS.index(day)

            subject_name = subject_details.get(subj_code, subj_code)
            professor_name = get_professor_name(subject_name, conn)

            def insert_item(slot_data, label):
                if not slot_data:
                    return
                slot = int(slot_data["slot"])
                info = f"{label}\n{subj_code} - {subject_name}\n{professor_name}\n{slot_data['building']} - {slot_data['room']}"
                item = QTableWidgetItem(info)
                item.setTextAlignment(Qt.AlignCenter)
                font = QFont("Arial", 12, QFont.Bold)
                item.setFont(font)
                item.setBackground(QBrush(QColor(220, 240, 255) if label == "Lecture" else QColor(255, 240, 220)))
                self.table.setItem(slot, col, item)

            insert_item(session.get("lecture"), "Lecture")
            insert_item(session.get("tutorial"), "Tutorial")


def main():
    app = QApplication(sys.argv)
    window = TimetableWindow()
    window.show()
    sys.exit(app.exec_())


if __name__ == "__main__":
    main()
