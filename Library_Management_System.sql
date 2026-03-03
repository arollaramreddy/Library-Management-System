--creating database
create database FinalProject51;
GO

--using the database
use FinalProject51
GO

--Creating the tables

-- Drop and create Authors
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Authors') AND sysstat & 0xf = 3)
    DROP TABLE dbo.Authors;

CREATE TABLE Authors (
    author_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    bio TEXT NULL
);

-- Drop and create Publishers
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Publishers') AND sysstat & 0xf = 3)
    DROP TABLE dbo.Publishers;

CREATE TABLE Publishers (
    publisher_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    contact_info TEXT NULL
);

-- Drop and create Books
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Books') AND sysstat & 0xf = 3)
    DROP TABLE dbo.Books;

CREATE TABLE Books (
    book_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    publisher_id INT FOREIGN KEY REFERENCES Publishers(publisher_id),
    author_id INT FOREIGN KEY REFERENCES Authors(author_id),
    genre VARCHAR(100),
    publication_year INT,
    copies_available INT NOT NULL DEFAULT 0
);

-- Drop and create Members
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Members') AND sysstat & 0xf = 3)
    DROP TABLE dbo.Members;

CREATE TABLE Members (
    member_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    address TEXT,
    registration_date DATE NOT NULL,
    status VARCHAR(10) NOT NULL DEFAULT 'Active'
);

-- Drop and create Staff
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Staff') AND sysstat & 0xf = 3)
    DROP TABLE dbo.Staff;

CREATE TABLE Staff (
    staff_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role VARCHAR(20) NOT NULL,
    password VARCHAR(100) NOT NULL
);

-- Drop and create Borrowing
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Borrowing') AND sysstat & 0xf = 3)
    DROP TABLE dbo.Borrowing;

CREATE TABLE Borrowing (
    borrow_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    member_id INT NOT NULL FOREIGN KEY REFERENCES Members(member_id),
    book_id INT NOT NULL FOREIGN KEY REFERENCES Books(book_id),
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status VARCHAR(20) NOT NULL
);

-- Drop and create Fines
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Fines') AND sysstat & 0xf = 3)
    DROP TABLE dbo.Fines;

CREATE TABLE Fines (
    fine_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    borrow_id INT NOT NULL FOREIGN KEY REFERENCES Borrowing(borrow_id),
    fine_amount DECIMAL(6,2) NOT NULL,
    paid_status VARCHAR(10) NOT NULL DEFAULT 'Unpaid',
    payment_date DATE
);

-- Drop and create Payments
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Payments') AND sysstat & 0xf = 3)
    DROP TABLE dbo.Payments;

CREATE TABLE Payments (
    payment_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    member_id INT NOT NULL FOREIGN KEY REFERENCES Members(member_id),
    amount_paid DECIMAL(8,2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_type VARCHAR(20) NOT NULL
);

--Populating the tables
INSERT INTO Authors (name, bio) VALUES
('George Orwell', 'English novelist, essayist, journalist and critic.'),
('Harper Lee', 'American novelist widely known for To Kill a Mockingbird.'),
('J.D. Salinger', 'American writer best known for his novel The Catcher in the Rye.'),
('Jane Austen', 'English novelist known for her six major novels.'),
('Leo Tolstoy', 'Russian writer, regarded as one of the greatest authors of all time.'),
('F. Scott Fitzgerald', 'American novelist and short-story writer.'),
('Herman Melville', 'American novelist, short story writer, and poet of the American Renaissance period.'),
('William Shakespeare', 'English playwright, poet, and actor.'),
('Homer', 'Ancient Greek author of The Iliad and The Odyssey.'),
('J.R.R. Tolkien', 'English writer, poet, philologist, and academic.');

INSERT INTO Publishers (name, contact_info) VALUES
('Penguin Random House', 'info@penguinrandomhouse.com'),
('HarperCollins', 'info@harpercollins.com'),
('Simon & Schuster', 'info@simonandschuster.com'),
('Macmillan Publishers', 'info@macmillanpublishers.com'),
('Hachette Book Group', 'info@hachettebookgroup.com'),
('Scholastic', 'info@scholastic.com'),
('Oxford University Press', 'info@oxforduniversitypress.com'),
('Cambridge University Press', 'info@cambridgeuniversitypress.com'),
('Bloomsbury', 'info@bloomsbury.com'),
('Vintage Books', 'info@vintagebooks.com');


INSERT INTO Members (name, email, phone, address, registration_date, status) VALUES
('Emily Carter', 'emily.carter@email.com', '4805551234', '456 Cypress Ave', '2023-01-05', 'Active'),
('Liam Johnson', 'liam.johnson@email.com', '6025552345', '789 Oak Street', '2023-01-18', 'Active'),
('Olivia Martinez', 'olivia.martinez@email.com', '4805553456', '321 Pine Lane', '2023-02-10', 'Active'),
('Noah Davis', 'noah.davis@email.com', '5205554567', '654 Maple Blvd', '2023-03-01', 'Active'),
('Ava Smith', 'ava.smith@email.com', '9285555678', '888 Birch Drive', '2023-03-22', 'Inactive'),
('Mason Lee', 'mason.lee@email.com', '4805556789', '951 Cedar Way', '2023-04-14', 'Active'),
('Sophia Brown', 'sophia.brown@email.com', '6235557890', '222 Spruce Ct', '2023-04-29', 'Active'),
('James Wilson', 'james.wilson@email.com', '4805558901', '333 Fir Path', '2023-05-13', 'Inactive'),
('Isabella Moore', 'isabella.moore@email.com', '6025559012', '147 Redwood Rd', '2023-06-01', 'Active'),
('Benjamin Clark', 'benjamin.clark@email.com', '4805550123', '369 Palm Place', '2023-06-18', 'Active');


INSERT INTO Books (title, isbn, publisher_id, author_id, genre, publication_year, copies_available) VALUES
('1984', '9780451524935', 1, 1, 'Dystopian', 1949, 5),
('To Kill a Mockingbird', '9780061120084', 2, 2, 'Classic', 1960, 4),
('The Catcher in the Rye', '9780316769488', 3, 3, 'Fiction', 1951, 3),
('Pride and Prejudice', '9781503290563', 4, 4, 'Romance', 1813, 2),
('War and Peace', '9781427030200', 5, 5, 'Historical', 1869, 2),
('The Great Gatsby', '9780743273565', 6, 6, 'Classic', 1925, 3),
('Moby-Dick', '9781503280786', 7, 7, 'Adventure', 1851, 1),
('Hamlet', '9780743477123', 8, 8, 'Tragedy', 1603, 4),
('The Odyssey', '9780140268867', 9, 9, 'Epic', -800, 2),
('The Hobbit', '9780547928227', 10, 10, 'Fantasy', 1937, 5);


INSERT INTO Staff (name, email, role, password) VALUES
('Linda Park', 'linda.park@library.com', 'Admin', 'adminLinda123'),
('Carlos Rivera', 'carlos.rivera@library.com', 'Librarian', 'libCarlos456'),
('Sarah Chen', 'sarah.chen@library.com', 'Assistant', 'staffSarah789'),
('David Kim', 'david.kim@library.com', 'Admin', 'adminDavid456'),
('Rachel Green', 'rachel.green@library.com', 'Librarian', 'libRachel321'),
('Tom Nguyen', 'tom.nguyen@library.com', 'Assistant', 'staffTom111'),
('Nina Patel', 'nina.patel@library.com', 'Admin', 'adminNina222'),
('Mohamed Ali', 'mohamed.ali@library.com', 'Librarian', 'libMo999'),
('Anna Scott', 'anna.scott@library.com', 'Assistant', 'staffAnna333'),
('Jason Lee', 'jason.lee@library.com', 'Admin', 'adminJason888');


INSERT INTO Borrowing (member_id, book_id, borrow_date, due_date, return_date, status) VALUES
(4, 3, '2023-02-20', '2023-03-06', '2023-03-05', 'Returned'),
(10, 7, '2023-04-15', '2023-04-29', NULL, 'Borrowed'),
(6, 2, '2023-03-10', '2023-03-24', '2023-03-19', 'Returned'),
(9, 5, '2023-01-22', '2023-02-05', NULL, 'Borrowed'),
(3, 6, '2023-03-25', '2023-04-08', '2023-04-05', 'Returned'),
(7, 1, '2023-05-01', '2023-05-15', '2023-05-12', 'Returned'),
(1, 9, '2023-02-11', '2023-02-25', NULL, 'Borrowed'),
(5, 4, '2023-03-16', '2023-03-30', '2023-03-27', 'Returned'),
(2, 8, '2023-04-20', '2023-05-04', NULL, 'Borrowed'),
(8, 10, '2023-01-05', '2023-01-19', '2023-01-15', 'Returned'),
(4, 1, '2023-06-01', '2023-06-15', NULL, 'Borrowed'),
(6, 7, '2023-02-08', '2023-02-22', '2023-02-20', 'Returned'),
(9, 3, '2023-03-03', '2023-03-17', NULL, 'Borrowed'),
(10, 2, '2023-04-09', '2023-04-23', '2023-04-21', 'Returned'),
(1, 6, '2023-01-25', '2023-02-08', NULL, 'Borrowed'),
(7, 5, '2023-02-14', '2023-02-28', '2023-02-26', 'Returned'),
(3, 4, '2023-05-17', '2023-05-31', NULL, 'Borrowed'),
(5, 8, '2023-03-01', '2023-03-15', '2023-03-12', 'Returned'),
(2, 10, '2023-01-30', '2023-02-13', '2023-02-10', 'Returned'),
(8, 9, '2023-04-03', '2023-04-17', NULL, 'Borrowed'),
(6, 1, '2023-02-18', '2023-03-04', '2023-03-01', 'Returned'),
(4, 2, '2023-03-22', '2023-04-05', NULL, 'Borrowed'),
(10, 7, '2023-01-09', '2023-01-23', '2023-01-20', 'Returned'),
(1, 3, '2023-04-25', '2023-05-09', '2023-05-06', 'Returned'),
(9, 6, '2023-03-06', '2023-03-20', NULL, 'Borrowed'),
(2, 5, '2023-05-02', '2023-05-16', NULL, 'Borrowed'),
(3, 10, '2023-01-19', '2023-02-02', '2023-01-30', 'Returned'),
(7, 8, '2023-02-23', '2023-03-09', NULL, 'Borrowed'),
(5, 9, '2023-04-07', '2023-04-21', '2023-04-18', 'Returned'),
(8, 4, '2023-03-14', '2023-03-28', NULL, 'Borrowed');


INSERT INTO Fines (borrow_id, fine_amount, paid_status, payment_date) VALUES
(2, 150, 'Paid', '2024-05-07'),
(7, 100, 'Paid', '2024-05-09'),
(8, 150, 'Unpaid', NULL),
(13, 100, 'Paid', '2024-05-13'),
(15, 70, 'Paid', '2024-05-08'),
(20, 150, 'Paid', '2024-05-01'),
(21, 200, 'Paid', '2024-05-02'),
(23, 70, 'Unpaid', NULL),
(26, 175, 'Unpaid', NULL),
(1, 9.4, 'Unpaid', NULL),
(4, 7.8, 'Unpaid', NULL),
(10, 6.2, 'Unpaid', NULL),
(16, 8.1, 'Unpaid', NULL),
(18, 5.1, 'Unpaid', NULL),
(19, 6.1, 'Unpaid', NULL),
(22, 4.8, 'Unpaid', NULL),
(24, 16.1, 'Unpaid', NULL),
(25, 8.1, 'Unpaid', NULL),
(27, 7.4, 'Unpaid', NULL),
(28, 7.3, 'Unpaid', NULL),
(29, 5.1, 'Unpaid', NULL),
(30, 2.9, 'Unpaid', NULL);


INSERT INTO Payments (member_id, amount_paid, payment_date, payment_type) VALUES
(10, 150, '2024-05-07', 'Fine'),
(6, 100, '2024-05-09', 'Fine'),
(10, 100, '2024-05-13', 'Fine'),
(4, 70, '2024-05-08', 'Fine'),
(4, 150, '2024-05-01', 'Fine'),
(6, 200, '2024-05-02', 'Fine'),
(9, 175, '2024-05-10', 'Membership'),
(1, 125, '2024-05-14', 'Membership'),
(4, 150, '2024-05-07', 'Membership'),
(6, 125, '2024-05-14', 'Membership'),
(10, 200, '2024-05-14', 'Membership'),
(7, 125, '2024-05-05', 'Membership'),
(5, 175, '2024-05-05', 'Membership'),
(5, 175, '2024-05-12', 'Membership'),
(9, 200, '2024-05-17', 'Membership'),
(3, 150, '2024-05-15', 'Membership'),
(1, 175, '2024-05-04', 'Membership'),
(6, 200, '2024-05-05', 'Membership'),
(5, 125, '2024-05-06', 'Membership'),
(2, 100, '2024-05-08', 'Membership'),
(2, 175, '2024-05-09', 'Membership'),
(4, 100, '2024-05-18', 'Membership'),
(7, 175, '2024-05-13', 'Membership'),
(1, 175, '2024-05-20', 'Membership'),
(9, 100, '2024-05-01', 'Membership'),
(6, 100, '2024-05-13', 'Membership'),
(5, 175, '2024-05-17', 'Membership'),
(7, 100, '2024-05-15', 'Membership'),
(3, 150, '2024-05-11', 'Membership');

GO

-- View 1: Borrowed Books with Member Names
-- Purpose: Track all currently borrowed books with member and book titles
-- ============================================
CREATE VIEW vw_CurrentBorrowedBooks AS
SELECT m.name AS member_name, b.title AS book_title, br.borrow_date, br.due_date
FROM Borrowing br
JOIN Members m ON br.member_id = m.member_id
JOIN Books b ON br.book_id = b.book_id
WHERE br.status = 'Borrowed';

GO


select * from vw_CurrentBorrowedBooks;

GO


-- ============================================
-- View 2: Paid Fines with Payment Info
-- Purpose: Show fines that have been paid, useful for finance tracking
-- ============================================
CREATE VIEW vw_PaidFinesWithPayments AS
SELECT f.borrow_id, f.fine_amount, p.amount_paid, p.payment_date, m.name AS member_name
FROM Fines f
JOIN Borrowing br ON f.borrow_id = br.borrow_id
JOIN Members m ON br.member_id = m.member_id
JOIN Payments p ON p.member_id = m.member_id AND p.payment_type = 'Fine'
WHERE f.paid_status = 'Paid';
GO 

select * from vw_PaidFinesWithPayments;
GO


-- ============================================
-- View 3: Books with Low Availability
-- Purpose: Identify books that are about to run out
-- ============================================
CREATE VIEW vw_LowStockBooksWithAuthors AS
SELECT 
    b.title,
    b.copies_available,
    a.name AS author_name
FROM Books b
JOIN Authors a ON b.author_id = a.author_id
WHERE b.copies_available <= 2;
GO

select * from vw_LowStockBooksWithAuthors

-- ============================================
-- Audit Table for Publishers
-- ============================================
-- Step 1: Modify Publishers table
ALTER TABLE Publishers
ALTER COLUMN contact_info VARCHAR(MAX);

-- Step 2: Modify PublisherAudit table 
DROP TABLE IF EXISTS PublisherAudit;

CREATE TABLE PublisherAudit (
    audit_id INT IDENTITY(1,1) PRIMARY KEY,
    action_type VARCHAR(10),
    publisher_id INT,
    name VARCHAR(100),
    contact_info VARCHAR(MAX),
    changed_at DATETIME
);

-- Step 3: Updated Trigger (now works with VARCHAR(MAX))
DROP TRIGGER IF EXISTS trg_AuditPublishers;
GO

CREATE TRIGGER trg_AuditPublishers
ON Publishers
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @current_time DATETIME = GETDATE();

    -- INSERT
    INSERT INTO PublisherAudit (action_type, publisher_id, name, contact_info, changed_at)
    SELECT 'INSERT', i.publisher_id, i.name, i.contact_info, @current_time
    FROM inserted i;

    -- UPDATE
    INSERT INTO PublisherAudit (action_type, publisher_id, name, contact_info, changed_at)
    SELECT 'UPDATE', i.publisher_id, i.name, i.contact_info, @current_time
    FROM inserted i;

    -- DELETE
    INSERT INTO PublisherAudit (action_type, publisher_id, name, contact_info, changed_at)
    SELECT 'DELETE', d.publisher_id, d.name, d.contact_info, @current_time
    FROM deleted d;
END;

INSERT INTO Publishers (name, contact_info) VALUES ('SciTech Media', 'info@scitechmedia.com');
UPDATE Publishers SET name = 'SciTech Publications' WHERE name = 'SciTech Media';
DELETE FROM Publishers WHERE name = 'SciTech Publications';

SELECT * FROM PublisherAudit;
GO


-- ============================================
-- Stored Procedure: Get member borrowing history
-- ============================================
CREATE PROCEDURE sp_GetBorrowingHistory
    @MemberID INT
AS
BEGIN
    SELECT br.borrow_date, br.return_date, b.title
    FROM Borrowing br
    JOIN Books b ON br.book_id = b.book_id
    WHERE br.member_id = @MemberID;
END;

GO

EXEC sp_GetBorrowingHistory @MemberID = 1;

-- ============================================
-- UDF: Calculate late fee (0.1 per day)
-- ============================================
-- ============================================
-- Drop UDF if it already exists
-- ============================================
IF OBJECT_ID('dbo.udf_CalculateLateFee', 'FN') IS NOT NULL
    DROP FUNCTION dbo.udf_CalculateLateFee;
GO

-- ============================================
-- UDF: Calculate late fee (0.1 per day overdue)
-- Returns 0 if returned on time or early
-- ============================================
CREATE FUNCTION dbo.udf_CalculateLateFee (
    @due_date DATE,
    @return_date DATE
)
RETURNS DECIMAL(6,2)
AS
BEGIN
    DECLARE @fee DECIMAL(6,2);

    IF @return_date > @due_date
        SET @fee = DATEDIFF(DAY, @due_date, @return_date) * 0.1;
    ELSE
        SET @fee = 0;

    RETURN @fee;
END;
GO

-- Example: book due on 2024-04-01 and returned on 2024-04-06
SELECT dbo.udf_CalculateLateFee('2024-04-01', '2024-04-06') AS LateFee;
GO


-- ============================================
-- Cursor to list all books and their available copies
-- ============================================
DECLARE @bookTitle VARCHAR(255), @copies INT;

DECLARE book_cursor CURSOR FOR
SELECT title, copies_available FROM Books;

OPEN book_cursor;
FETCH NEXT FROM book_cursor INTO @bookTitle, @copies;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Book: ' + @bookTitle + ' | Copies Available: ' + CAST(@copies AS VARCHAR);
    FETCH NEXT FROM book_cursor INTO @bookTitle, @copies;
END;

CLOSE book_cursor;
DEALLOCATE book_cursor;



