import pymysql

# --- Database connection settings ---
DB_SETTINGS = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'UniversityTimetabling'
}

def test_db_connection():
    try:
        # Connect to the database
        conn = pymysql.connect(**DB_SETTINGS)
        print("✅ Successfully connected to 'UniversityTimetabling' database.")

        # Create a cursor and run a test query
        cursor = conn.cursor()
        test_query = "SELECT * FROM Departments LIMIT 5;"
        cursor.execute(test_query)
        rows = cursor.fetchall()

        # Display results
        if rows:
            print("📋 Sample rows from 'Departments':")
            for row in rows:
                print("  -", row)
        else:
            print("⚠️ 'Departments' table exists but has no data.")

        # Clean up
        cursor.close()
        conn.close()
        print("🔌 Connection closed.")

    except Exception as e:
        print("❌ Failed to connect or query the database:")
        print(e)

if __name__ == '__main__':
    test_db_connection()
