-- EO1 ASSIGNMENT -- 

CREATE TABLE users (
    user_id INT IDENTITY PRIMARY KEY,
    user_first_name VARCHAR(30) NOT NULL,
    user_last_name VARCHAR(30) NOT NULL,
    user_email_id VARCHAR(50) NOT NULL,
    user_email_validated BIT DEFAULT 0,
    user_password VARCHAR(200),
    user_role VARCHAR(1) NOT NULL DEFAULT 'U', --U and A
    is_active BIT DEFAULT 0,
    created_dt DATE DEFAULT GETDATE()
);

SELECT TOP 3 * FROM users;

-- EO2 ASSIGNMENT --

CREATE TABLE courses (
	course_id INT IDENTITY PRIMARY KEY,
	course_name VARCHAR(60),
	course_author VARCHAR(40),
	course_status VARCHAR(10), -- draft, published, or inactive
    course_published_dt DATE
    );

INSERT INTO courses (course_name, course_author, course_status, course_published_dt) VALUES
('Programming using Python', 'Bob Dillon', 'published', '2020-09-30');

INSERT INTO courses (course_name, course_author, course_status, course_published_dt) VALUES
('Data Engineering using Python', 'Bob Dillon', 'published', '2020-07-15'),
('Programming using Scala', 'Elvis Presley', 'published', '2020-05-12'),
('Programming using Java', 'Mike Jack', 'inactive', '2020-08-10'),
('Web Applications - Python Flask', 'Bob Dillon', 'inactive', '2020-07-20'),
('Streaming Pipelines - Python	', 'Bob Dillon', 'published', '2020-10-05'),
('Web Applications - Scala Play', 'Elvis Presley', 'inactive', '2020-09-30'),
('Web Applications - Python Django', 'Bob Dillon', 'published', '2020-06-23'),
('Server Automation - Ansible', 'Uncle Sam', 'published', '2020-07-05')
;

INSERT INTO courses (course_name, course_author, course_status) VALUES
('Data Engineering using Scala', 'Elvis Presley', 'draft'),
('Web Applications - Java Spring', 'Mike Jack', 'draft'),
('Pipeline Orchestration - Python', 'Bob Dillon', 'draft')
;

UPDATE courses
SET course_status = 'published'
WHERE course_status = 'draft';


Select * from courses

DELETE FROM courses
WHERE course_status != 'published' AND course_status != 'draft';

SELECT course_author, count(1) AS course_count
FROM courses
WHERE course_status= 'published'
GROUP BY course_author
