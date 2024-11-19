import tkinter as tk
from tkinter import messagebox, simpledialog
from auth import signup, login
from database import get_db_connection, add_schedule, get_schedules, add_mood, get_moods, add_wellness_suggestion, get_wellness_suggestions, add_feedback, get_feedback

class CoeusAIApp(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Coeus AI - Login")
        self.geometry("300x250")
        self.create_login_screen()
        self.user_id = None  # To keep track of the logged-in user

    def create_login_screen(self):
        for widget in self.winfo_children():
            widget.destroy()

        tk.Label(self, text="Username").pack(pady=5)
        self.username_entry = tk.Entry(self)
        self.username_entry.pack(pady=5)

        tk.Label(self, text="Password").pack(pady=5)
        self.password_entry = tk.Entry(self, show='*')
        self.password_entry.pack(pady=5)

        tk.Button(self, text="Login", command=self.handle_login).pack(pady=5)
        tk.Button(self, text="Sign Up", command=self.create_signup_screen).pack(pady=5)

    def create_signup_screen(self):
        for widget in self.winfo_children():
            widget.destroy()

        tk.Label(self, text="Username").pack(pady=5)
        self.username_entry = tk.Entry(self)
        self.username_entry.pack(pady=5)

        tk.Label(self, text="Email").pack(pady=5)
        self.email_entry = tk.Entry(self)
        self.email_entry.pack(pady=5)

        tk.Label(self, text="Password").pack(pady=5)
        self.password_entry = tk.Entry(self, show='*')
        self.password_entry.pack(pady=5)

        tk.Button(self, text="Sign Up", command=self.handle_signup).pack(pady=5)
        tk.Button(self, text="Back to Login", command=self.create_login_screen).pack(pady=5)

    def handle_login(self):
        username = self.username_entry.get()
        password = self.password_entry.get()
        if login(username, password):
            self.user_id = self.get_user_id(username)  # Retrieve and store the user ID
            self.create_main_interface()
        else:
            messagebox.showerror("Error", "Incorrect username or password")

    def handle_signup(self):
        username = self.username_entry.get()
        password = self.password_entry.get()
        email = self.email_entry.get()
        if signup(username, password, email):
            messagebox.showinfo("Success", "User signed up successfully!")
            self.create_login_screen()
        else:
            messagebox.showerror("Error", "Username or email already exists")

    def create_main_interface(self):
        self.title("Coeus AI - Main Interface")
        for widget in self.winfo_children():
            widget.destroy()
        tk.Label(self, text="Welcome to Coeus AI!").pack(pady=20)

        tk.Button(self, text="Add Schedule", command=self.add_schedule_screen).pack(pady=5)
        tk.Button(self, text="View Schedules", command=self.view_schedules_screen).pack(pady=5)
        tk.Button(self, text="Track Mood", command=self.track_mood_screen).pack(pady=5)
        tk.Button(self, text="View Moods", command=self.view_moods_screen).pack(pady=5)
        tk.Button(self, text="Add Wellness Suggestion", command=self.add_wellness_suggestion_screen).pack(pady=5)
        tk.Button(self, text="View Wellness Suggestions", command=self.view_wellness_suggestions_screen).pack(pady=5)
        tk.Button(self, text="Add Feedback", command=self.add_feedback_screen).pack(pady=5)
        tk.Button(self, text="View Feedback", command=self.view_feedback_screen).pack(pady=5)

    def add_schedule_screen(self):
        title = simpledialog.askstring("Title", "Enter schedule title:")
        description = simpledialog.askstring("Description", "Enter schedule description:")
        start_time = simpledialog.askstring("Start Time", "Enter start time (YYYY-MM-DD HH:MM:SS):")
        end_time = simpledialog.askstring("End Time", "Enter end time (YYYY-MM-DD HH:MM:SS):")
        location = simpledialog.askstring("Location", "Enter location:")
        add_schedule(self.user_id, title, description, start_time, end_time, location)
        messagebox.showinfo("Success", "Schedule added successfully!")

    def view_schedules_screen(self):
        schedules = get_schedules(self.user_id)
        schedule_list = "\n".join([f"{s[1]}: {s[2]} from {s[4]} to {s[5]} at {s[6]}" for s in schedules])
        messagebox.showinfo("Schedules", schedule_list)

    def track_mood_screen(self):
        mood = simpledialog.askstring("Mood", "Enter your mood (happy, sad, stressed, neutral, excited):")
        notes = simpledialog.askstring("Notes", "Enter any notes:")
        add_mood(self.user_id, mood, notes)
        messagebox.showinfo("Success", "Mood tracked successfully!")

    def view_moods_screen(self):
        moods = get_moods(self.user_id)
        mood_list = "\n".join([f"{m[2]}: {m[3]} on {m[4]}" for m in moods])
        messagebox.showinfo("Moods", mood_list)

    def add_wellness_suggestion_screen(self):
        suggestion = simpledialog.askstring("Suggestion", "Enter wellness suggestion:")
        add_wellness_suggestion(self.user_id, suggestion)
        messagebox.showinfo("Success", "Wellness suggestion added successfully!")

    def view_wellness_suggestions_screen(self):
        suggestions = get_wellness_suggestions(self.user_id)
        suggestion_list = "\n".join([f"{s[2]} on {s[3]}" for s in suggestions])
        messagebox.showinfo("Wellness Suggestions", suggestion_list)

    def add_feedback_screen(self):
        feedback = simpledialog.askstring("Feedback", "Enter your feedback:")
        add_feedback(self.user_id, feedback)
        messagebox.showinfo("Success", "Feedback submitted successfully!")

    def view_feedback_screen(self):
        feedback = get_feedback(self.user_id)
        feedback_list = "\n".join([f"{f[2]} on {f[3]}" for f in feedback])
        messagebox.showinfo("User Feedback", feedback_list)

    def get_user_id(self, username):
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT user_id FROM Users WHERE username = %s", (username,))
        user_id = cursor.fetchone()[0]
        conn.close()
        return user_id

if __name__ == "__main__":
    app = CoeusAIApp()
    app.mainloop()
