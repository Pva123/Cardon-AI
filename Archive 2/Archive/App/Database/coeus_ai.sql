CREATE DATABASE CoeusAI;
-- Database Schema

-- Switch to the CoeusAI database
USE CoeusAI;

-- Table to store user information
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table to store user schedules
CREATE TABLE Schedules (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    location VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Table to store intelligent notifications
CREATE TABLE Notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    message TEXT NOT NULL,
    notify_time DATETIME NOT NULL,
    status ENUM('pending', 'sent', 'dismissed') DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Table to track user's mood
CREATE TABLE MoodTracking (
    mood_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    mood ENUM('happy', 'sad', 'stressed', 'neutral', 'excited') NOT NULL,
    mood_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Table to store wellness suggestions
CREATE TABLE WellnessSuggestions (
    suggestion_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    suggestion TEXT NOT NULL,
    suggested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Table to store user feedback
CREATE TABLE UserFeedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    feedback TEXT NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Additional table for tracking user's habits
CREATE TABLE UserHabits (
    habit_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    habit_name VARCHAR(100) NOT NULL,
    habit_start_time TIME,
    habit_end_time TIME,
    frequency ENUM('daily', 'weekly', 'monthly'),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Creating indexes to optimize queries
CREATE INDEX idx_user_id ON Schedules(user_id);
CREATE INDEX idx_user_id ON Notifications(user_id);
CREATE INDEX idx_user_id ON MoodTracking(user_id);
CREATE INDEX idx_user_id ON WellnessSuggestions(user_id);
CREATE INDEX idx_user_id ON UserFeedback(user_id);
CREATE INDEX idx_user_id ON UserHabits(user_id);

-- Granting appropriate permissions to secure the database
-- (This example assumes a MySQL environment)
CREATE USER 'coeus_user'@'localhost' IDENTIFIED BY 'secure_password';
GRANT SELECT, INSERT, UPDATE, DELETE ON CoeusAI.* TO 'coeus_user'@'localhost';
FLUSH PRIVILEGES;