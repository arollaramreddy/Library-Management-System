# Library Management System

**Course:** IFT 530 – Advanced Database Management System  
**Group:** 51  
**Team Members:** Ramreddy Arolla, Arya Jinan Panicker  
**SQL Server:** Microsoft SQL Server 2022  

---


## Project Overview

This project implements a Library Management System using Microsoft SQL Server.  
It manages books, authors, publishers, members, borrowing transactions, fines, and payments.

The system demonstrates relational database design, constraints, views, triggers, stored procedures, functions, and cursors.

---

## Database Features

### Tables
- Authors  
- Publishers  
- Books  
- Members  
- Staff  
- Borrowing  
- Fines  
- Payments  

All tables are connected using primary keys and foreign key constraints to maintain referential integrity.

---

## Views

1. **vw_CurrentBorrowedBooks**  
   Displays all books currently borrowed with member names and due dates.

2. **vw_PaidFinesWithPayments**  
   Shows paid fines along with payment details and member information.

3. **vw_LowStockBooksWithAuthors**  
   Lists books with low availability (2 or fewer copies).

---

## Stored Procedure

**sp_GetBorrowingHistory**  
Returns the borrowing history of a specific member.

Example:
```sql
EXEC sp_GetBorrowingHistory @MemberID = 1;
