CREATE DATABASE IF NOT EXISTS dss_database
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE dss_database;

-- 1. Students Table

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Admins Table

CREATE TABLE admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- 3. Specializations Table

CREATE TABLE specializations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT
);

-- 4. Criteria Table

CREATE TABLE criteria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    weight DECIMAL(4,2) NOT NULL,
    type ENUM('maximize', 'minimize') NOT NULL
);

-- 5. Evaluations Table

CREATE TABLE evaluations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    specialization_id INT NOT NULL,
    criterion_id INT NOT NULL,
    score INT NOT NULL CHECK (score BETWEEN 1 AND 10),

    FOREIGN KEY (student_id)
        REFERENCES students(id)
        ON DELETE CASCADE,

    FOREIGN KEY (specialization_id)
        REFERENCES specializations(id)
        ON DELETE CASCADE,

    FOREIGN KEY (criterion_id)
        REFERENCES criteria(id)
        ON DELETE CASCADE,

    UNIQUE (student_id, specialization_id, criterion_id)
);

-- Insert Specializations

INSERT INTO specializations (name, description)
VALUES
('Artificial Intelligence', 'Study of artificial intelligence'),
('Cybersecurity', 'Protection of computer systems'),
('Data Science', 'Analysis of data and information'),
('Information Systems and Software Engineering',
 'Development of software and information systems');

-- Insert Criteria

INSERT INTO criteria (name, weight, type)
VALUES
('Programming', 0.20, 'maximize'),
('Mathematics', 0.15, 'maximize'),
('Alignment with competencies', 0.20, 'maximize'),
('Career opportunities', 0.20, 'maximize'),
('Difficulty', 0.10, 'minimize'),
('Personal interest', 0.15, 'maximize');

-- Verify Tables

SHOW TABLES;

-- Display Specializations

SELECT * FROM specializations;

-- Display Criteria

SELECT * FROM criteria;