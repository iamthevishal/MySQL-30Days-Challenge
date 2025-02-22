create database online_books_store;
use online_books_store;
create table Books(
Book_ID SERIAL PRIMARY KEY,
Title VARCHAR(60),
Author VARCHAR(30),
Genre VARCHAR(20),
Published_Year INT NOT NULL,
Price FLOAT NOT NULL,
Stock INT NOT NULL
);
select * from Books;
drop table Books;

create table Customers(
Customers_ID SERIAL PRIMARY KEY,
Name VARCHAR(30),
Email VARCHAR(40),
Phone INT NOT NULL,
City VARCHAR(25),
Country VARCHAR(60)
);
select * from Customers;
drop table Customers;

create table Orders(
Order_ID SERIAL PRIMARY KEY,
 Customer_ID INT references Customers(Customers_ID),
 Book_ID INT references Books(Book_ID) ,
 Order_Date	DATE,	
 Quantity INT,
 Total_Amount FLOAT
);

drop table Orders;

select * from Books;
select * from Customers;
select * from Orders;
alter table Orders
change column Customer_ID Customers_ID int not null;

# 1 retrieve all books in the "Fiction" genre
select * from Books where Genre = "Fiction";

# 2 find books published after the year 1950
select * from Books where Published_Year > 1950 order by Published_Year ASC;

# 3 List all customers from the canada
select * from Customers where Country ="Canada";

# 4  Show orders placed in novembers 2023
select * from Orders where Order_Date between "2023-11-01" AND "2023-11-30" order by Order_Date ASC;

# 5 retrieve the total stock of books available
select SUM(Stock) from Books;

# 6 find the details of the most expensive books
select * from Books order by Price DESC LIMIT 1;

# 7 show all customers who ordered more than 1 quantity of a book
SELECT * FROM Orders WHERE Quantity > 1;

# 8 Retrieve all orders  where the total amount exceeds $20
SELECT * FROM Orders WHERE Total_Amount > 20;


# 9 List all the genre available in the books table
SELECT Genre FROM Books GROUP BY Genre;

# 10 Find the books with the lowest stock
SELECT * FROM Books order BY Stock asc;

# 11 Calculate the total revenue generated from all orders
select Sum(Total_Amount) as Revenue from Orders;

#Advance questions
# 1 Retrieve the total number of books sold for each genre
select Genre, Sum(Quantity)
from Books as b
inner join Orders as o
on b.Book_ID = o.Book_ID
group by Genre;

# 2 Find the average price of books in the "Fantasy" genre?
select Genre, AVG(Price) as Average_Price
from Books
where Genre ="Fantasy";

# 3 List customers who have placed atleast two orders?
SELECT c.Customers_ID, c.Name, COUNT(o.Order_ID) AS total_orders
FROM Customers c
INNER JOIN Orders o 
ON c.Customers_ID = o.Customers_ID
GROUP BY c.Customers_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2;

# 4 Find the most frequently ordered book?
select Book_ID, count(Order_ID) as total_orders
from Orders
group by Book_ID
order by total_orders desc limit 1;

# 5 show the three top most expensive books of "Fantasy" genre?
select Genre, Title, Price
from Books
where Genre = "Fantasy"
order by Price desc limit 3;

# 6 retrieve the total quantity of books sold by each author
select * from books;
select * from orders;
select * from customers;
select b.Author, count(o.Quantity)
from Books as b
inner join Orders as o
group by b.Author;

# 7 list the cities where customer spent over 30$ are locaed?
select c.City, o.Total_Amount
From Customers as c
inner join Orders as o
on c.Customers_ID = o.Customers_ID
where Total_Amount>30;

# 8 Find the customers who spent the most on orders?
select Name, Sum(Total_Amount) as TotalSpent
from Customers as c
inner join Orders as o
on c.Customers_ID = o.Customers_ID
group by c.Name
order by TotalSpent Desc limit 1;

# 9 Calculate the stock Remaining after fulfilling all the orders?
Select Sum(Stock), Sum(Quantity)
From Books as b
inner join Orders as o
on b.Book_ID = o.Book_ID
where b.Stock- o.Quantity;
