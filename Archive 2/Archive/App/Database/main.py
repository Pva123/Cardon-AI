from ui import CoeusAIApp  # Importing the CoeusAIApp class from ui.py
from database import setup_database  # Importing the setup_database function from database.py

# Main execution block
if __name__ == '__main__':
    setup_database()  # Set up the database before starting the application
    app = CoeusAIApp()  # Create an instance of the CoeusAIApp class
    app.mainloop()  # Start the Tkinter event loop to run the application

