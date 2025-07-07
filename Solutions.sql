SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM return_status;
SELECT * FROM members;

-- Library Management System Project;
-- 1. Database Setup


use library_project;

drop table if exists branch;
CREATE TABLE branch (
    branch_id VARCHAR(10) PRIMARY KEY,
    manager_id VARCHAR(10),
    branch_address VARCHAR(100),
    Contact_no INT
);

drop table if exists employees;
CREATE TABLE employees (
    emp_id VARCHAR(10) primary key,
    emp_name VARCHAR(50),
    position VARCHAR(20),
    salary INT,
    branch_id VARCHAR(10)
);


drop table if exists books;
CREATE TABLE books (
    isbn VARCHAR(25) primary key,
    book_title VARCHAR(100),
    category VARCHAR(20),
    rental_price float,
    status VARCHAR(5),
    author varchar(50),
    publisher varchar(55)
);


drop table if exists members;
CREATE TABLE members (
    member_id varchar(10) primary key,
    member_name VARCHAR(50),
    member_address VARCHAR(20),
    reg_date date
);

drop table if exists issue_status;
CREATE TABLE issue_status (
    issue_id VARCHAR(25) primary key,
    issue_member_id VARCHAR(10),
    issued_book_name VARCHAR(100),
    issue_date date,
    issued_book_isbn VARCHAR(5),
    issued_emp_id varchar(50)
);


drop table if exists return_status;
CREATE TABLE return_status (
    return_id VARCHAR(25) primary key,
    issue_id VARCHAR(10),
    return_book_name VARCHAR(100),
    return_date date,
    return_book_isbn VARCHAR(20)
);


-- foreign key
alter table issue_status
add constraint fk_members
foreign key (issue_member_id)
references members(member_id);


alter table issue_status
add constraint fk_books
foreign key (issued_book_isbn)
references books(isbn);

alter table issue_status
modify issued_book_isbn varchar(25);

alter table issue_status
add constraint fk_empid
foreign key (issued_emp_id)
references employees(emp_id);


alter table employees
add constraint fk_branchid
foreign key (branch_id)
references branch(branch_id);

alter table return_status
add constraint fk_issueid
foreign key (issue_id)
references issue_status(issue_id);

alter table return_status
add constraint fk_returnisbn
foreign key (return_book_isbn)
references books(isbn);

alter table branch
modify Contact_no varchar(20);

alter table return_status
modify return_book_isbn varchar(30);
 
 select * from issue_status;
 ``` 

-- insert the data in table 
insert into  return_status(return_id,issue_id,return_book_name,return_date,return_book_isbn)
values
('RS102', 'IS122', NULL, '2023-06-07', NULL),
('RS103', 'IS123', NULL, '2023-08-07', NULL),
('RS104', 'IS106', NULL, '2024-05-01', NULL),
('RS105', 'IS107', NULL, '2024-05-03', NULL),
('RS106', 'IS108', NULL, '2024-05-05', NULL),
('RS107', 'IS109', NULL, '2024-05-07', NULL),
('RS108', 'IS110', NULL, '2024-05-09', NULL),
('RS109', 'IS111', NULL, '2024-05-11', NULL),
('RS110', 'IS112', NULL, '2024-05-13', NULL),
('RS111', 'IS113', NULL, '2024-05-15', NULL),
('RS112', 'IS114', NULL, '2024-05-17', NULL),
('RS113', 'IS115', NULL, '2024-05-19', NULL),
('RS114', 'IS116', NULL, '2024-05-21', NULL),
('RS115', 'IS117', NULL, '2024-05-23', NULL),
('RS116', 'IS118', NULL, '2024-05-25', NULL),
('RS117', 'IS119', NULL, '2024-05-27', NULL),
('RS118', 'IS120', NULL, '2024-05-29', NULL);


-- Project Task
-- 2. CRUD Operations
-- Task 1. Create a New Book Record --
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

insert into books
values
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT 
    *
FROM
    books;

-- Task 2: Update an Existing Member's Address

UPDATE members 
SET 
    member_address = 'B.k,Pune'
WHERE
    member_id = 'C103';
SELECT 
    *
FROM
    members;


-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the

DELETE FROM issue_status 
WHERE
    issue_id = 'IS126';

-- Task 4: Retrieve All Books Issued by a Specific Employee 
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT 
    *
FROM
    employees
WHERE
    emp_id = 'E101';

-- Task 5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT 
    issue_member_id, COUNT(*) AS issue_time
FROM
    issue_status
GROUP BY issue_member_id
HAVING issue_time > 1;

-- 3. CTAS (Create Table As Select)
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results -
-- each book and total book_issued_cnt**

CREATE TABLE book_issued_cnt AS SELECT books.isbn,
    books.book_title,
    COUNT(issue_status.issue_id) AS issue_time FROM
    books
        JOIN
    issue_status ON books.isbn = issue_status.issued_book_isbn
GROUP BY books.isbn , books.book_title;

select * from book_issued_cnt;

-- 4. Data Analysis & Findings
-- Task 7. Retrieve All Books in a Specific Category:
select * from books
where category = 'Classic';

-- Task 8: Find Total Rental Income by Category:
select category, sum(rental_price) as total_rental_income
from books
group by category;

-- List Members Who Registered in the Last 180 Days:
select * from members
where reg_date >= current_date() - interval 180 day;

-- List Employees with Their Branch Manager's Name and their branch details:
SELECT 
    e.emp_name,
    e.position,
    e.salary,
    b.branch_address,
    e2.emp_name AS manager_name
FROM
    employees AS e
        JOIN
    branch AS b ON e.branch_id = b.branch_id
        JOIN
    employees AS e2 ON e2.emp_id = b.manager_id;

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:
create table expensive_books as
select * from books
where rental_price > 7;

-- Task 12: Retrieve the List of Books Not Yet Returned

select  i.issue_id, i.issued_book_name, i.issue_date, r.return_date
from issue_status as i
left join return_status as r
on i.issue_id = r.issue_id
where r.return_date is null
;

-- Advanced SQL Operations
-- Task 13: Identify Members with Overdue Books
-- Write a query to identify members who have overdue books (assume a 30-day return period). 
-- Display the member's_id, member's name, book title, issue date, and days overdue.

SELECT 
    m.member_id,
    m.member_name,
    b.book_title,
    i.issue_date,
    r.return_date,
    (CURRENT_DATE() - i.issue_date) AS Overdue_days
FROM
    members AS m
        JOIN
    issue_status AS i ON m.member_id = i.issue_member_id
        JOIN
    books AS b ON b.isbn = i.issued_book_isbn
        LEFT JOIN
    return_status AS r ON r.issue_id = i.issue_id
WHERE
    r.return_date IS NULL
        AND CURRENT_DATE() - i.issue_date > 30;

-- Task 14: Branch Performance Report
-- Create a query that generates a performance report for each branch, 
-- showing the number of books issued, the number of books returned, 
-- and the total revenue generated from book rentals.
CREATE TABLE branch_report AS SELECT b.branch_id,
    b.branch_address,
    COUNT(i.issue_id) AS issue_qty,
    COUNT(r.return_id) AS return_qty,
    SUM(bo.rental_price) AS revenue FROM
    branch AS b
        JOIN
    employees AS e ON b.branch_id = e.branch_id
        JOIN
    issue_status AS i ON i.issued_emp_id = e.emp_id
        LEFT JOIN
    return_status AS r ON r.issue_id = i.issue_id
        JOIN
    books AS bo ON bo.isbn = i.issued_book_isbn
GROUP BY b.branch_id;

SELECT 
    *
FROM
    branch_report;

-- Task 15: CTAS: Create a Table of Active Members
-- Use the CREATE TABLE AS (CTAS) 
-- statement to create a new table active_members containing members
--  who have issued at least one book in the last 2 months.

CREATE TABLE active_member AS SELECT * FROM
    members
WHERE
    member_id IN (SELECT DISTINCT
            issue_status.issue_member_id
        FROM
            issue_status
        WHERE
            issue_status.issue_date <= (CURRENT_DATE() - INTERVAL 60 DAY));

-- Task 16: Find Employees with the Most Book Issues Processed
-- Write a query to find the top 3 employees who have processed the most book issues.
-- Display the employee name, number of books processed, and their branch.

SELECT 
    e.emp_name,
    COUNT(i.issue_id) AS book_issued,
    b.branch_id,
    b.branch_address
FROM
    employees AS e
        LEFT JOIN
    issue_status AS i ON e.emp_id = i.issued_emp_id
        JOIN
    branch AS b ON b.branch_id = e.branch_id
GROUP BY e.emp_id
ORDER BY book_issued DESC
LIMIT 3;

-- Task 17: Create Table As Select (CTAS) Objective: Create a CTAS (Create Table As Select) 
-- query to identify overdue books and calculate fines.
-- Description: Write a CTAS query to create a new table that lists each member
-- and the books they have issued but not returned within 30 days. The table should include: 
-- The number of overdue books. The total fines, with each day's fine calculated at $0.50. 
-- The number of books issued by each member. The resulting table should show: 
-- Member ID Number of overdue books Total fines

CREATE TABLE fine_registar AS
SELECT 
    m.member_id,
    COUNT(CASE WHEN DATEDIFF(r.return_date, i.issue_date) > 30 THEN 1 END) AS overdue_books,
    SUM(CASE 
        WHEN DATEDIFF(r.return_date, i.issue_date) > 30 
        THEN (DATEDIFF(r.return_date, i.issue_date) - 30) * 0.50 
        ELSE 0 
    END) AS total_fine,
    COUNT(i.issue_id) AS total_books_issued
FROM members AS m
JOIN issue_status AS i ON m.member_id = i.issue_member_id
LEFT JOIN return_status AS r ON i.issue_id = r.issue_id
WHERE r.return_date IS NOT NULL
GROUP BY m.member_id;

