CREATE DATABASE Library;
USE Library;
CREATE TABLE Branch (
  Branch_no INT PRIMARY KEY,
  Manager_Id INT,
  Branch_address VARCHAR(255),
  Contact_no VARCHAR(20)
);
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
(1, 1, 'Kochi', '0484-123456'),
(2, 2, 'Trivandrum', '0471-987654'),
(3, 3, 'Kozhikode', '0495-111111');
CREATE TABLE Employee (
  Emp_Id INT PRIMARY KEY,
  Emp_name VARCHAR(255),
  Position VARCHAR(255),
  Salary DECIMAL(10, 2),
  Branch_no INT,
  FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES
(1, 'John Doe', 'Manager', 50000.00, 1),
(2, 'Jane Smith', 'Assistant Manager', 40000.00, 2),
(3, 'Bob Johnson', 'Librarian', 30000.00, 3),
(4, 'Alice Williams', 'Librarian', 30000.00, 1),
(5, 'Mike Davis', 'Librarian', 30000.00, 2);
CREATE TABLE Books (
  ISBN VARCHAR(20) PRIMARY KEY,
  Book_title VARCHAR(255),
  Category VARCHAR(255),
  Rental_Price DECIMAL(10, 2),
  Status VARCHAR(10),
  Author VARCHAR(255),
  Publisher VARCHAR(255)
);
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
('1234567890', 'Book1', 'Fiction', 10.00, 'Yes', 'Author1', 'Publisher1'),
('2345678901', 'Book2', 'Non-Fiction', 20.00, 'Yes', 'Author2', 'Publisher2'),
('3456789012', 'Book3', 'Fiction', 15.00, 'No', 'Author3', 'Publisher3'),
('4567890123', 'Book4', 'Non-Fiction', 25.00, 'Yes', 'Author4', 'Publisher4'),
('5678901234', 'Book5', 'Fiction', 18.00, 'Yes', 'Author5', 'Publisher5');
CREATE TABLE Customer (
  Customer_Id INT PRIMARY KEY,
  Customer_name VARCHAR(255),
  Customer_address VARCHAR(255),
  Reg_date DATE
);
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
(1, 'Customer1', 'Address1', '2022-01-01'),
(2, 'Customer2', 'Address2', '2022-02-01'),
(3, 'Customer3', 'Address3', '2022-03-01');
CREATE TABLE IssueStatus (
  Issue_Id INT PRIMARY KEY,
  Issued_cust INT,
  Issued_book_name VARCHAR(255),
  Issue_date DATE,
  Isbn_book VARCHAR(20),
  FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
(1, 1, 'Book1', '2022-01-05', '1234567890'),
(2, 2, 'Book2', '2022-02-10', '2345678901'),
(3, 3, 'Book3', '2022-03-15', '3456789012');
CREATE TABLE ReturnStatus (
  Return_Id INT PRIMARY KEY,
  Return_cust INT,
  Return_book_name VARCHAR(255),
  Return_date DATE,
  Isbn_book2 VARCHAR(20),
  FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
sELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'Yes';
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;
SELECT B.Book_title, C.Customer_name
FROM Books B
JOIN IssueStatus I ON B.ISBN = I.Isbn_book
JOIN Customer C ON I.Issued_cust = C.Customer_Id;
SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;
SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);
SELECT B.Branch_no, COUNT(*) AS Total_Employees
FROM Branch B
JOIN Employee E ON B.Branch_no = E.Branch_no
GROUP BY B.Branch_no;
SELECT C.Customer_name
FROM Customer C
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
WHERE MONTH(I.Issue_date) = 6 AND YEAR(I.Issue_date) = 2023;
SELECT Book_title
FROM Books
WHERE Category = 'History';
SELECT B.Branch_no, COUNT(*) AS Total_Employees
FROM Branch B
JOIN Employee E ON B.Branch_no = E.Branch_no
GROUP BY B.Branch_no
HAVING COUNT(*) > 5;
SELECT E.Emp_name, B.Branch_address
FROM Employee E
JOIN Branch B ON E.Emp_Id = B.Manager_Id;
SELECT C.Customer_name
FROM Customer C
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
JOIN Books B ON I.Isbn_book = B.ISBN
WHERE B.Rental_Price > 25;