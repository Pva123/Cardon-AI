import mysql.connector

def get_db_connection():
    conn = mysql.connector.connect(
        host='localhost',
        user='coeus_user',
        password='secure_password',
        database='CoeusAI'
    )
    return conn

def setup_database():
    conn = get_db_connection()
    cursor = conn.cursor()
    # Assuming the tables are already created using the provided SQL script
    conn.close()

# Function to add a new schedule
def add_schedule(user_id, title, description, start_time, end_time, location):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO Schedules (user_id, title, description, start_time, end_time, location) VALUES (%s, %s, %s, %s, %s, %s)",
        (user_id, title, description, start_time, end_time, location)
    )
    conn.commit()
    conn.close()

# Function to retrieve schedules for a user
def get_schedules(user_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM Schedules WHERE user_id = %s", (user_id,))
    schedules = cursor.fetchall()
    conn.close()
    return schedules

# Function to add a new mood tracking entry
def add_mood(user_id, mood, notes):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO MoodTracking (user_id, mood, notes) VALUES (%s, %s, %s)",
        (user_id, mood, notes)
    )
    conn.commit()
    conn.close()

# Function to retrieve mood tracking entries for a user
def get_moods(user_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM MoodTracking WHERE user_id = %s", (user_id,))
    moods = cursor.fetchall()
    conn.close()
    return moods

# Function to add a new wellness suggestion
def add_wellness_suggestion(user_id, suggestion):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO WellnessSuggestions (user_id, suggestion) VALUES (%s, %s)",
        (user_id, suggestion)
    )
    conn.commit()
    conn.close()

# Function to retrieve wellness suggestions for a user
def get_wellness_suggestions(user_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM WellnessSuggestions WHERE user_id = %s", (user_id,))
    suggestions = cursor.fetchall()
    conn.close()
    return suggestions

# Function to add user feedback
def add_feedback(user_id, feedback):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO UserFeedback (user_id, feedback) VALUES (%s, %s)",
        (user_id, feedback)
    )
    conn.commit()
    conn.close()

# Function to retrieve user feedback
def get_feedback(user_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM UserFeedback WHERE user_id = %s", (user_id,))
    feedback = cursor.fetchall()
    conn.close()
    return feedback
