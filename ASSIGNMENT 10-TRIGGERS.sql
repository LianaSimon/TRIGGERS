-- ASSIGNMENT 10-TRIGGERS

-- CREATE A TABLE NAMED 'TEACHERS' AND INSERT 8 ROWS IN IT

USE TABLES;
CREATE TABLE TEACHER(ID INT PRIMARY KEY, 
FULLNAME VARCHAR(30) NOT NULL, 
SUBJECTNAME VARCHAR(30), 
EXPERIENCE VARCHAR(20),
SALARY DECIMAL(10,2) NOT NULL);

INSERT INTO TEACHER(ID,FULLNAME,SUBJECTNAME,EXPERIENCE,SALARY) VALUES
(101,'Alice Johnson', 'Math', 12, 60000),
(102,'Bob Smith', 'Science', 8, 55000),
(103,'Charlie Brown', 'English', 15, 70000),
(104,'David Lee', 'History', 5, 50000),
(105,'Emma Wilson', 'Physics', 10, 65000),
(106,'Frank Martin', 'Biology', 7, 58000),
(107,'Grace Kelly', 'Chemistry', 9, 62000),
(108,'Hank Adams', 'Computer Science', 14, 75000);

SELECT * FROM TEACHER;

-- 2. Create a before insert trigger to prevent negative salary

DELIMITER $$
CREATE TRIGGER before_insert_teacher
BEFORE INSERT ON teacher
FOR EACH ROW
BEGIN
IF NEW.salary<0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Salary cannot be Negative';
END IF;
END $$
DELIMITER ;

SELECT * FROM TEACHER;
INSERT INTO TEACHER(ID,FULLNAME,SUBJECTNAME,EXPERIENCE,SALARY) VALUES
(109,'Wills Johnson','Math',12,-2);

-- 3. Create teacher_log table

CREATE TABLE teacher_log(teacher_id INT,action VARCHAR(20), timestamp DATETIME DEFAULT CURRENT_TIMESTAMP);

-- Create an after insert trigger to log insert actions

DELIMITER $$
CREATE TRIGGER after_insert_teacher
AFTER INSERT ON TEACHER
FOR EACH ROW
BEGIN
INSERT INTO teacher_log(teacher_id,action,timestamp) VALUES (NEW.ID,'INSERT',NOW());
END$$
DELIMITER ;

INSERT INTO TEACHER(ID,FULLNAME,SUBJECTNAME,EXPERIENCE,SALARY) VALUES(110,'Yuvan Derrick','Math',12,30000);
SELECT *FROM teacher_log;
SELECT * FROM teacher;

-- 4. Create a before delete trigger to prevent deletion if experience > 10 years

DELIMITER $$
CREATE TRIGGER before_delete_teacher
BEFORE DELETE ON teacher
FOR EACH ROW
BEGIN
IF OLD.EXPERIENCE>10 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Cannot delete a teacher with more than 10 years of experience';
END IF;
END $$
DELIMITER ;

DELETE FROM TEACHER WHERE ID=101;

-- 5. Create an after delete trigger to log delete actions

DELIMITER $$

CREATE TRIGGER after_delete_teacher
AFTER DELETE ON teacher
FOR EACH ROW

BEGIN
INSERT INTO teacher_log(teacher_id,action,timestamp) VALUES (OLD.ID,'DELETE',NOW());
END $$
DELIMITER ;

DELETE FROM TEACHER WHERE ID=106;
SELECT * FROM teacher_log;


