--Project On Library Management

--Creating Branch Table
DROP TABLE if exists branch;
CREATE TABLE branch(
	branch_id VARCHAR(15) PRIMARY KEY,
	manager_id VARCHAR(15),
	branch_address VARCHAR(35),
	contact_no VARCHAR(15)
);

--Creating Employee Table
DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
	emp_id VARCHAR(20) PRIMARY KEY,
	emp_name VARCHAR(25),
	emp_position VARCHAR(15),
	salary INT,
	branch_id VARCHAR(20)

);

--Creating Books Table
DROP TABLE IF EXISTS books;

CREATE TABLE books(
	isbn VARCHAR(25) PRIMARY KEY,
	book_title VARCHAR(50),
	category VARCHAR(10),
	rental_price FLOAT,
	status VARCHAR(10),
	author VARCHAR(25),
	publisher VARCHAR(35)
);

--Creating Members Table
DROP TABLE IF EXISTS members;

CREATE TABLE memebers(
member_id VARCHAR(25) PRIMARY KEY,
member_name	VARCHAR(30),
member_address VARCHAR(40),
reg_date DATE
);

--Creating Issued Table
DROP TABLE IF EXISTS issued_table;

CREATE TABLE issued_table(
	issued_id VARCHAR(25) PRIMARY KEY,
	issued_member_id VARCHAR(20),
	issued_book_name VARCHAR(25),
	issued_date	 DATE,
	issued_book_isbn VARCHAR(30),
	issued_emp_id VARCHAR(20)
);
--Creating return_status Table
CREATE TABLE return_status(
	return_id VARCHAR(20),
	issued_id VARCHAR(25),
	return_book_name VARCHAR(75),
	return_date DATE,
	return_book_isbn VARCHAR(40)
);

--Alter table name
ALTER TABLE memebers RENAME TO members;
--FOREIGN KEY CONSTRAINT ON return_status

ALTER TABLE return_status
ADD CONSTRAINT fk_issued_id
FOREIGN KEY (issued_id)
REFERENCES issued_table(issued_id)

--FOREIGN KEY CONSTRAINT ON issued_table

ALTER TABLE issued_table
ADD CONSTRAINT fk_members
FOREIGN KEY (issued_member_id)
REFERENCES members(member_id);

ALTER TABLE issued_table
ADD CONSTRAINT fk_employees
FOREIGN KEY (issued_emp_id)
REFERENCES employees(emp_id);

ALTER TABLE issued_table
ADD CONSTRAINT fk_books
FOREIGN KEY (issued_book_isbn)
REFERENCES books(isbn);

--Foreign Constraint on Employees Table

ALTER TABLE employees
ADD CONSTRAINT fk_branch
FOREIGN KEY (branch_id)
REFERENCES branch(branch_id);