# 📘 Library Management System using SQL

## 📚 Project Overview

**Project Title**: Library Management System  
**Level**: Intermediate  
**Database Name**: `library_db`

This project demonstrates the implementation of a **Library Management System** using SQL. It involves:

- Designing and creating normalized database tables.
- Performing CRUD (Create, Read, Update, Delete) operations.
- Writing and executing advanced SQL queries.
- Applying constraints, foreign keys, and relationships between tables.

The main objective is to showcase a strong understanding of **relational database design**, **data manipulation**, and **SQL-based data analysis** in a real-world context.

<img width="1269" height="828" alt="Database Schema" src="https://github.com/user-attachments/assets/ba321c39-cc15-44e6-8909-92286bf5be39" />

---

## 🎯 Project Objectives

1. **Set Up the Library Database**  
   Create and populate tables for: Branches,Employees,Members, Books, Issue Status, Return Status  

2. **CRUD Operations**  
   Perform Create, Read, Update, and Delete operations on all tables.

3. **CTAS (Create Table As Select)**  
   Use CTAS statements to create new tables based on query results for analytics and reporting.

4. **Advanced SQL Queries**  
   Develop and execute complex SQL queries for data analysis, such as calculating fines, tracking due dates, and member borrowing history.

---




## 🗂️ Project Structure

### 1. **Database Setup**

<img width="1269" height="828" alt="Database Diagram" src="https://github.com/user-attachments/assets/a42fd4a0-63d3-446f-ac24-a647f1df2ddf" />

- **Database Creation**: Created a database named `library_db`.
- **Table Creation**: Tables for `branches`, `employees`, `members`, `books`, `issue_status`, and `return_status` were created with proper relationships.
- **ER Diagram**: Visualizes how different entities are connected within the system.

---


```sql
-- Use the database
USE library_project;

-- Drop and create Branch table
DROP TABLE IF EXISTS branch;
CREATE TABLE branch (
    branch_id VARCHAR(10) PRIMARY KEY,
    manager_id VARCHAR(10),
    branch_address VARCHAR(100),
    Contact_no VARCHAR(20)
);

-- Drop and create Employees table
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    emp_id VARCHAR(10) PRIMARY KEY,
    emp_name VARCHAR(50),
    position VARCHAR(20),
    salary INT,
    branch_id VARCHAR(10)
);

-- Drop and create Books table
DROP TABLE IF EXISTS books;
CREATE TABLE books (
    isbn VARCHAR(25) PRIMARY KEY,
    book_title VARCHAR(100),
    category VARCHAR(20),
    rental_price FLOAT,
    status VARCHAR(5),
    author VARCHAR(50),
    publisher VARCHAR(55)
);

-- Drop and create Members table
DROP TABLE IF EXISTS members;
CREATE TABLE members (
    member_id VARCHAR(10) PRIMARY KEY,
    member_name VARCHAR(50),
    member_address VARCHAR(20),
    reg_date DATE
);

-- Drop and create Issue Status table
DROP TABLE IF EXISTS issue_status;
CREATE TABLE issue_status (
    issue_id VARCHAR(25) PRIMARY KEY,
    issue_member_id VARCHAR(10),
    issued_book_name VARCHAR(100),
    issue_date DATE,
    issued_book_isbn VARCHAR(25),
    issued_emp_id VARCHAR(50)
);

-- Drop and create Return Status table
DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status (
    return_id VARCHAR(25) PRIMARY KEY,
    issue_id VARCHAR(10),
    return_book_name VARCHAR(100),
    return_date DATE,
    return_book_isbn VARCHAR(30)
);

-- Foreign Keys
ALTER TABLE issue_status
    ADD CONSTRAINT fk_members
    FOREIGN KEY (issue_member_id) REFERENCES members(member_id);

ALTER TABLE issue_status
    ADD CONSTRAINT fk_books
    FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn);

ALTER TABLE issue_status
    ADD CONSTRAINT fk_empid
    FOREIGN KEY (issued_emp_id) REFERENCES employees(emp_id);

ALTER TABLE employees
    ADD CONSTRAINT fk_branchid
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id);

ALTER TABLE return_status
    ADD CONSTRAINT fk_issueid
    FOREIGN KEY (issue_id) REFERENCES issue_status(issue_id);

ALTER TABLE return_status
    ADD CONSTRAINT fk_returnisbn
    FOREIGN KEY (return_book_isbn) REFERENCES books(isbn);

-- Sample Query
SELECT * FROM issue_status;

-- Insert Dataset
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



```

### 2. **CRUD Operations**
Create: Inserted sample records into the books table.
Read: Retrieved and displayed data from various tables.
Update: Updated records in the employees table.
Delete: Removed records from the members table as needed.

**Task 1. Create a New Book Record** -- "978-1-60129-456-2', 'To Kill a Mockingbird',
'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

``` sql
insert into books
values
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT 
    *
FROM
    books;
```
**Task 2: Update an Existing Member's Address**
``` sql
UPDATE members 
SET 
    member_address = 'B.k,Pune'
WHERE
    member_id = 'C103';
SELECT 
    *
FROM
    members;
```
**Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.**

```sql
DELETE FROM issue_status 
WHERE
    issue_id = 'IS126';
```
**Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.**
```sql
SELECT 
    *
FROM
    employees
WHERE
    emp_id = 'E101';
```
**Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.**
``` sql
SELECT 
    issue_member_id, COUNT(*) AS issue_time
FROM
    issue_status
GROUP BY issue_member_id
HAVING issue_time > 1;
```
### ***3. CTAS (Create Table As Select)***
***Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt*****

```sql
CREATE TABLE book_issued_cnt AS SELECT books.isbn,
    books.book_title,
    COUNT(issue_status.issue_id) AS issue_time FROM
    books
        JOIN
    issue_status ON books.isbn = issue_status.issued_book_isbn
GROUP BY books.isbn , books.book_title;

select * from book_issued_cnt;
```
###***4. Data Analysis & Findings***
***The following SQL queries were used to address specific questions:***

***Task 7. Retrieve All Books in a Specific Category:***
```sql
select * from books
where category = 'Classic';
```
***Task 8: Find Total Rental Income by Category:***
```sql
select category, sum(rental_price) as total_rental_income
from books
group by category;
```
***Task 9:List Members Who Registered in the Last 180 Days:***
```sql
select * from members
where reg_date >= current_date() - interval 180 day;
```
***Task 10 : List Employees with Their Branch Manager's Name and their branch details:***
```sql
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
```
***Task 11: Create a Table of Books with Rental Price Above a Certain Threshold:***
```sql
create table expensive_books as
select * from books
where rental_price > 7;
```
***Task 12:Retrieve the List of Books Not Yet Returned***
```sql
select  i.issue_id, i.issued_book_name, i.issue_date, r.return_date
from issue_status as i
left join return_status as r
on i.issue_id = r.issue_id
where r.return_date is null
;
```
###***Advanced SQL Operations***
***Task 13: Identify Members with Overdue Books***
Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name, book title, issue date, and days overdue.
```sql
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
```
***Task 14: Branch Performance Report***
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.
```sql
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
```
***Task 15: CTAS: Create a Table of Active Members***
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.
```sql
CREATE TABLE active_member AS SELECT * FROM
    members
WHERE
    member_id IN (SELECT DISTINCT
            issue_status.issue_member_id
        FROM
            issue_status
        WHERE
            issue_status.issue_date <= (CURRENT_DATE() - INTERVAL 60 DAY));
```
***Task 16:Find Employees with the Most Book Issues Processed***
Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.
```sql
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
```
***Task 17: Create Table As Select (CTAS) Objective: Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines.***

Description: Write a CTAS query to create a new table that lists each member and the books they have issued but not returned within 30 days.
The table should include: The number of overdue books. The total fines, with each day's fine calculated at $0.50. 
The number of books issued by each member. The resulting table should show: Member ID Number of overdue books Total fines.

```sql
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
```

###***Reports***
**Database Schema**: Detailed table structures and relationships.
**Data Analysis**: Insights into book categories, employee salaries, member registration trends, and issued books.
**Summary Reports**: Aggregated data on high-demand books and employee performance.

###***Conclusion***
This project demonstrates the application of SQL skills in creating and managing a library management system. It includes database setup, data manipulation, and advanced querying, providing a solid foundation for data management and analysis.

## 🛠️ Tools & Technologies

- **SQL (MySQL)**
- **DBMS Concepts**
- **ER Diagrams**
- **Query Optimization Techniques**

***Thank you for your interest in this project!***
