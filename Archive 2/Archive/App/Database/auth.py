import hashlib  # Import hashlib for hashing passwords
import mysql.connector  # Import mysql.connector to connect to the MySQL database
from database import get_db_connection  # Import the get_db_connection function from database.py

def hash_password(password):
    # Hash the password using SHA-256
    return hashlib.sha256(password.encode()).hexdigest()

def signup(username, password, email):
    try:
        conn = get_db_connection()  # Establish a database connection
        cursor = conn.cursor()
        # Insert the new user into the Users table
        cursor.execute("INSERT INTO Users (username, password_hash, email) VALUES (%s, %s, %s)", 
                       (username, hash_password(password), email))
        conn.commit()  # Commit the transaction
        conn.close()  # Close the connection
        return True
    except mysql.connector.IntegrityError:
        # If there is an integrity error (e.g., duplicate username or email), return False
        return False

def login(username, password):
    conn = get_db_connection()  # Establish a database connection
    cursor = conn.cursor()
    # Retrieve the password hash for the given username
    cursor.execute("SELECT password_hash FROM Users WHERE username = %s", (username,))
    result = cursor.fetchone()
    conn.close()  # Close the connection
    if result and result[0] == hash_password(password):
        # If the password matches the hash, return True
        return True
    else:
        # If the password does not match, return False
        return False
