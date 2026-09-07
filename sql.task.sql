CREATE DATABASE todo_app;
USE todo_app;
CREATE TABLE users(
User_id INT PRIMARY KEY AUTO_INCREMENT ,
User_name VARCHAR(20) UNIQUE NOT NULL,
Email VARCHAR(40) UNIQUE NOT NULL,
Password VARCHAR(20) NOT NULL,
Create_it TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Priority_levels(
Priority_id INT PRIMARY KEY AUTO_INCREMENT,
Priority_name VARCHAR(20) UNIQUE NOT NULL,
Priority_value INT 
);
CREATE TABLE Statuss(
status_id INT PRIMARY KEY AUTO_INCREMENT,
status_name VARCHAR(20) UNIQUE NOT NULL
);
CREATE TABLE tasks(
task_id INT PRIMARY KEY AUTO_INCREMENT,
User_id INT NOT NULL,
Title VARCHAR(100) NOT NULL,
descriptions TEXT,
priority_id INT NOT NULL,
Status_id INT NOT NULL,
Due_date DATE,
Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
Updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (User_id) REFERENCES users(User_id),
FOREIGN KEY (priority_id) REFERENCES Priority_levels(Priority_id),
FOREIGN KEY (Status_id) REFERENCES Statuss(status_id)
);
CREATE TABLE Categories(
Category_id INT PRIMARY KEY AUTO_INCREMENT,
User_id INT NOT NULL,
Category_name VARCHAR(40) NOT NULL,
FOREIGN KEY (User_id) REFERENCES users(User_id)
);
CREATE TABLE Task_categories(
Task_id INT NOT NULL,
Category_id INT NOT NULL,
PRIMARY KEY (Task_id,Category_id),
FOREIGN KEY (Task_id) REFERENCES tasks(task_id),
FOREIGN KEY (Category_id) REFERENCES Categories(Category_id)
);
INSERT INTO users
(user_name , email , password )
VALUES 
("Shubhangi" , "shubhangi@gmail.com" , "pas_word"),
("Arjun" , "arjun@gmail.com" , "pass_word" ),
("Carl" , "carl@gmail.com" , "Pa_ssword"),
("David" , "david@gmail.com" , "p_assword");
INSERT INTO Priority_levels
(Priority_name , Priority_value)
VALUES 
("Low" , 1),
("Medium" , 2),
("High" , 3),
("Urgent" , 4);
INSERT INTO Statuss
(status_name)
VALUES
("Pending"),
("In Progress"),
("Completed"),
("Cancelled");
INSERT INTO Categories
( User_id , Category_name)
VALUES
(2,"Work"),
(1,"Personal"),
(1,"Shopping"),
(3,"Work"),
(4,"Health"),
(2,"Health");
INSERT INTO tasks
(User_id ,Title ,descriptions, priority_id , Status_id , Due_date)
VALUES
(2,"Complete project","Finish Q3 project report" , 3 , 2, '2026-9-15'),
(1,"Call your family","discuss" , 2 , 1, '2026-9-15'),
(1,"Buy groceries","Milk veggies" , 2 , 1, '2026-9-13'),
(3,"Team Meeting","Discuss Project" , 4 , 1, '2026-9-14'),
(4,"Call Dentist","Schedule Appointment" , 1 , 1, '2026-9-12'),
(2,"Take Medicine","Cold" , 4 , 2, '2026-9-15');
INSERT INTO Task_categories
(Task_id, Category_id)
VALUES
(1 ,1),
(2,3),
(3,2),
(4,4),
(5,5);
SELECT
t.Task_id,
t.Title,
p.Priority_name,
s.status_name,
t.Due_date
FROM tasks t 
JOIN Priority_levels p 
ON t.Priority_id =p.Priority_id 
JOIN Statuss s
ON t.Status_id =s.Status_id
WHERE t.User_id = 1
ORDER BY t.Due_date;

UPDATE tasks SET Status_id = 3 
WHERE task_id = 1;

SELECT s.status_name , COUNT(t.task_id) AS task_columnn
FROM Statuss s 
LEFT JOIN  tasks t ON s.status_id = t.status_id AND t.user_id = 1
GROUP BY s.status_name;