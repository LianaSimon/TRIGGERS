# SQL TRIGGERS FOR TEACHERS MANAGEMENT

## Overview

This project demonstrates SQL triggers for handling insert and delete operations on a teachers table in MySQL, ensuring data integrity and logging actions.

## Features

* Table Creation: Teachers table with fields id, name, subject, experience, and salary.
* Insert Trigger (Before Insert): Prevents negative salary values using a BEFORE INSERT trigger.
* Insert Trigger (After Insert): Logs insert actions into teacher_log using an AFTER INSERT trigger.
* Delete Trigger (Before Delete): Prevents deletion of teachers with more than 10 years of experience using a BEFORE DELETE trigger.
* Delete Trigger (After Delete): Logs deletion actions into teacher_log using an AFTER DELETE trigger.

# SQL SCRIPT

USE TABLE;

* 1. CREATE A TABLE NAMED 'TEACHERS' AND INSERT 8 ROWS IN IT
  
CREATE TABLE TEACHER(ID INT AUTO_INCREMENT PRIMARY KEY, FULLNAME VARCHAR(30) NOT NULL, SUBJECTNAME VARCHAR(30), EXPERIENCE VARCHAR(20),SALARY DECIMAL(10,2) NOT NULL);

INSERT INTO TEACHER(FULLNAME,SUBJECTNAME,EXPERIENCE,SALARY) VALUES('Alice Johnson', 'Math', 12, 60000),('Bob Smith', 'Science', 8, 55000),('Charlie Brown', 'English', 15, 70000),
('David Lee', 'History', 5, 50000),('Emma Wilson', 'Physics', 10, 65000),('Frank Martin', 'Biology', 7, 58000),('Grace Kelly', 'Chemistry', 9, 62000),('Hank Adams', 'Computer Science', 14, 75000);

SELECT * FROM TEACHER;

![image](https://github.com/user-attachments/assets/3649566b-ba80-4e67-b761-e9030b2b18a1)

* 2. CREATE A 'BEFORE INSERT' TRIGGER TO PREVENT NEGATIVE SALARY

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

INSERT INTO TEACHER(FULLNAME,SUBJECTNAME,EXPERIENCE,SALARY) VALUES
('Wills Johnson','Math',12,-2);

  ![image](https://github.com/user-attachments/assets/43f76094-6f0e-4915-ab72-cb2d02c7a367)


* 3. Create teacher_log table
  4. 
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

![image](https://github.com/user-attachments/assets/afaf3458-aa5f-45e4-a55e-d4a930b467d4)

* 4. Create a before delete trigger to prevent deletion if experience > 10 years

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
 
![image](https://github.com/user-attachments/assets/cdaeddd6-c2e3-4dd8-8d9f-3520626143c8)

* 5. Create an after delete trigger to log delete actions

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


  ![image](https://github.com/user-attachments/assets/c18d7531-9980-4a8f-a292-b19e33361f5c)


# USAGE

* Run the provided SQL script in MySQL Workbench or any MySQL-supported environment.
  
* The triggers will automatically enforce the constraints and log actions.

  
# PREREQUISITES

* MySQL 8.0+ (for SIGNAL SQLSTATE error handling)
* Basic SQL knowledge

  
# HOW IT WORKS

* Any attempt to insert a negative salary raises an error.
  
* Successful insertions are logged in teacher_log.
  
* Attempting to delete a teacher with more than 10 years of experience is blocked.
  
* Successful deletions are logged in teacher_log.




