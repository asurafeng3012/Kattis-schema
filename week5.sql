CREATE DATABASE IF NOT EXISTS competitive_programming;

USE competitive_programming;

CREATE TABLE users (
	user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

INSERT INTO users (username, email, password)
VALUES 
    ('habeebhaliru', 'johndoe@project.com', 'hashed_password_1'),
    ('woodlayer', 'woodlayer@project.com', 'hashed_password_2'),
    ('monkeydluffy', 'monkeydluffy@project.com', 'hashed_password_3'),
    ('spiderman', 'spiderman@project.com', 'hashed_password_4'),
    ('colepalmer', 'colepalmer@project.com', 'hashed_password_5');


CREATE TABLE problems (
	problem_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    difficulty_level ENUM('easy', 'medium', 'hard')
);

INSERT INTO problems (title, description, difficulty_level)
VALUES 
    ('Two Sum', 'Find two numbers that add up to a target value.', 'easy'),
    ('Binary Tree Paths', 'Return all root-to-leaf paths in a binary tree.', 'medium'),
    ('Graph Cycle Detection', 'Determine if a directed graph has a cycle.', 'hard'),
    ('Palindrome Checker', 'Check if a given string is a palindrome.', 'easy'),
    ('Knapsack Problem', 'Optimize the selection of items within a weight limit.', 'medium');


CREATE TABLE submissions (
	submission_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    problem_id INT NOT NULL,
    code TEXT NOT NULL,
    status ENUM('pass', 'fail') NOT NULL,
    submission_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id)
);

INSERT INTO submissions (user_id, problem_id, code, status)
VALUES 
    (1, 1, 'code_for_two_sum()', 'pass'),
    (2, 2, 'code_for_binary_tree_paths()', 'fail'),
    (3, 3, 'code_for_graph_cycle_detection()', 'pass'),
    (4, 1, 'alternative_code_for_two_sum()', 'fail'),
    (5, 4, 'code_for_palindrome_checker()', 'pass');
    

SELECT EXISTS (
	SELECT 1
    FROM submissions
    WHERE user_id = 1 and problem_id = 1 AND status = 'pass'
) AS has_solved;


SELECT *
FROM submissions
WHERE user_id = 3
ORDER BY submission_time DESC
LIMIT 50;

SELECT
	problem_id,
    COUNT(CASE WHEN status = 'pass' THEN 1 END) AS correct_solutions,
    COUNT(*) AS total_solutions
FROM submissions
WHERE problem_id = 3
GROUP BY problem_id;


SELECT
	problem_id,
    COUNT(CASE WHEN status = 'fail' THEN 1 END) / COUNT(*) AS difficulty_score
FROM submissions
GROUP BY problem_id
ORDER BY difficulty_score DESC;    
