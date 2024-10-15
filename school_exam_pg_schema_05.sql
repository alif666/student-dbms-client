-- Create Room Table
DROP TABLE IF EXISTS room;

CREATE TABLE room (
  id SERIAL PRIMARY KEY,
  room_number VARCHAR(20) NOT NULL,
  capacity INT NOT NULL,
  status VARCHAR(20) DEFAULT 'active',
  description VARCHAR(255) DEFAULT NULL
);

-- Insert into Room
INSERT INTO room (room_number, capacity, status, description)
VALUES
('Room 101', 30, 'active', 'First floor, main classroom.'),
('Room 102', 25, 'active', 'Second floor, science lab.');

-- Create School Table
DROP TABLE IF EXISTS school;

CREATE TABLE school (
  id SERIAL PRIMARY KEY,
  create_by VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  update_by VARCHAR(50) NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  class_name_end VARCHAR(20) DEFAULT NULL,
  class_name_start VARCHAR(20) DEFAULT NULL,
  contact_no VARCHAR(20) DEFAULT NULL,
  description VARCHAR(255) DEFAULT NULL,
  email VARCHAR(50) DEFAULT NULL,
  end_time TIME DEFAULT NULL,
  established_year TIMESTAMP DEFAULT NULL,
  name VARCHAR(200) NOT NULL,
  registration_no VARCHAR(20) NOT NULL UNIQUE,
  remarks VARCHAR(255) DEFAULT NULL,
  start_time TIME DEFAULT NULL,
  status VARCHAR(20) DEFAULT NULL,
  type VARCHAR(20) DEFAULT NULL,
  address_id INT DEFAULT NULL,
  name_bn VARCHAR(200) DEFAULT NULL,
  school_logo BYTEA DEFAULT NULL,
  FOREIGN KEY (address_id) REFERENCES address(id)
);

-- Insert into School
INSERT INTO school (create_by, created_at, update_by, updated_at, class_name_end, class_name_start, contact_no, description, email, end_time, established_year, name, registration_no, remarks, start_time, status, type, address_id, name_bn, school_logo)
VALUES
('admin', NOW(), 'admin', NOW(), '10', '1', '1234567890', 'A school for learning.', 'school@example.com', '15:00:00', '2020-01-01', 'Greenwood High', 'GH-001', 'No remarks', '08:00:00', 'active', 'public', NULL, 'গ্রীনউড হাই', NULL),
('admin', NOW(), 'admin', NOW(), '12', '3', '0987654321', 'An institution for education.', 'info@example.com', '16:00:00', '2018-09-01', 'Sunnydale School', 'SD-002', 'Great facilities', '09:00:00', 'active', 'private', NULL, 'সানিডেল স্কুল', NULL);

-- Create School Medium Table
DROP TABLE IF EXISTS school_medium;

CREATE TABLE school_medium (
  id INT NOT NULL,
  medium VARCHAR(255) NOT NULL,
  medium_bn VARCHAR(255) DEFAULT NULL,
  status VARCHAR(20) DEFAULT NULL,
  FOREIGN KEY (id) REFERENCES school(id)
);

-- Insert into School Medium
INSERT INTO school_medium (id, medium, medium_bn, status)
VALUES
(1, 'English', 'ইংরেজি', 'active'),
(1, 'Bengali', 'বাংলা', 'inactive');

-- Create Section Lookup Table
DROP TABLE IF EXISTS section_lookup;

CREATE TABLE section_lookup (
  id SERIAL PRIMARY KEY,
  code VARCHAR(20) NOT NULL,
  display_order INT DEFAULT NULL,
  status VARCHAR(20) DEFAULT NULL,
  value_bn VARCHAR(100) DEFAULT NULL,
  value_en VARCHAR(100) DEFAULT NULL
);

-- Insert into Section Lookup
INSERT INTO section_lookup (code, display_order, status, value_bn, value_en)
VALUES
('A', 1, 'active', 'A বিভাগ', 'Section A'),
('B', 2, 'active', 'B বিভাগ', 'Section B');

-- Create School Shift Table
DROP TABLE IF EXISTS school_shift;

CREATE TABLE school_shift (
  id INT NOT NULL,
  shift VARCHAR(255) NOT NULL,
  shift_bn VARCHAR(255) DEFAULT NULL,
  status VARCHAR(20) DEFAULT NULL,
  FOREIGN KEY (id) REFERENCES school(id)
);

-- Insert into School Shift
INSERT INTO school_shift (id, shift, shift_bn, status)
VALUES
(1, 'Morning', 'সকাল', 'active'),
(2, 'Evening', 'বিকাল', 'inactive');

-- Create Class Table
DROP TABLE IF EXISTS class;

CREATE TABLE class (
  id SERIAL PRIMARY KEY,
  create_by VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  update_by VARCHAR(50) NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  class_name VARCHAR(20) NOT NULL,
  is_routine_complete BOOLEAN DEFAULT NULL,
  medium VARCHAR(20) DEFAULT NULL,
  remark VARCHAR(255) DEFAULT NULL,
  section_name VARCHAR(20) NOT NULL,
  shift VARCHAR(20) NOT NULL,
  status VARCHAR(20) DEFAULT NULL,
  version VARCHAR(20) DEFAULT NULL,
  room_id INT NOT NULL,
  school_id INT NOT NULL,
  class_name_bn VARCHAR(200) DEFAULT NULL,
  section_name_bn VARCHAR(200) DEFAULT NULL,
  UNIQUE (class_name, section_name, shift, medium, version, school_id),
  FOREIGN KEY (room_id) REFERENCES room(id),
  FOREIGN KEY (school_id) REFERENCES school(id)
);

-- Insert into Class
INSERT INTO class (create_by, created_at, update_by, updated_at, class_name, is_routine_complete, medium, remark, section_name, shift, status, version, room_id, school_id, class_name_bn, section_name_bn)
VALUES
('admin', NOW(), 'admin', NOW(), 'Class 1', TRUE, 'English', 'First class of the year.', 'A', 'Morning', 'active', 'v1', 1, 1, 'ক্লাস ১', 'এ বিভাগ'),
('admin', NOW(), 'admin', NOW(), 'Class 2', FALSE, 'Bengali', 'Second class of the year.', 'B', 'Afternoon', 'active', 'v1', 1, 1, 'ক্লাস ২', 'বি বিভাগ');

-- Create Class Name Lookup Table
DROP TABLE IF EXISTS class_name_lookup;

CREATE TABLE class_name_lookup (
  id SERIAL PRIMARY KEY,
  code VARCHAR(50) NOT NULL,
  display_order INT DEFAULT NULL,
  status VARCHAR(20) DEFAULT NULL,
  value_bn VARCHAR(100) DEFAULT NULL,
  value_en VARCHAR(100) DEFAULT NULL
);

-- Insert into Class Name Lookup
INSERT INTO class_name_lookup (code, display_order, status, value_bn, value_en)
VALUES
('CLASS1', 1, 'active', 'ক্লাস ১', 'Class 1'),
('CLASS2', 2, 'active', 'ক্লাস ২', 'Class 2');

-- Create Class Group Table
DROP TABLE IF EXISTS class_group;

CREATE TABLE class_group (
  id INT NOT NULL,
  groups VARCHAR(255) NOT NULL,
  value_bn VARCHAR(255) DEFAULT NULL,
  status VARCHAR(20) DEFAULT NULL,
  FOREIGN KEY (id) REFERENCES class(id)
);

-- Insert into Class Group
INSERT INTO class_group (id, groups, value_bn, status)
VALUES
(1, 'Group A', 'গ্রুপ এ', 'active'),
(2, 'Group B', 'গ্রুপ বি', 'inactive');

-- Create Subject Lookup Table
DROP TABLE IF EXISTS subject_lookup;

CREATE TABLE subject_lookup (
  id SERIAL PRIMARY KEY,
  code VARCHAR(20) NOT NULL,
  display_order INT DEFAULT NULL,
  status VARCHAR(20) DEFAULT NULL,
  value_bn VARCHAR(100) DEFAULT NULL,
  value_en VARCHAR(100) DEFAULT NULL
);

-- Insert into Subject Lookup
INSERT INTO subject_lookup (code, display_order, status, value_bn, value_en)
VALUES
('MAT101', 1, 'active', 'গণিত ১০১', 'Mathematics 101'),
('SCI101', 2, 'active', 'বিজ্ঞান ১০১', 'Science 101');
