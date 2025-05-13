use geeksforgeeks;
select * from customers;
select * from products;
select * from sales_reprentative;
select * from suppliers;

--  1. Get the full name and contact details of all customers who made a purchase.",

select o.orderID, c.Firstname, c.lastname, phonenumber from order1 o
left join customers c
on o.customerID=c.customerID;

-- 2. List the sales representative's full name and the total sales amount they generated.

select s2.firstName, s2.lastname, sum(s1.TotalAmount) as total_amount
from sales_reprentative s2
inner join sales s1 
on s1.SalesRepID=s2.SalesRepID
group by s2.firstName, s2.lastname
order by total_amount;
        
-- 3. Find all products and their suppliers' contact details.
select p.productID, P.ProductName, su.phoneNumber as supplier_Contact
from products p
left join suppliers su
on p.SupplierID=su.SupplierID;


-- 4. Retrieve the list of customers and the products they have purchased, including the quantity and total amount spent.
select c.customerID, c.firstname, c.lastname, s.ProductID, quantity, s.totalamount
from sales s
left join customers c
on s.CustomerID=c.CustomerID;

--     "5. List all sales representatives along with the number of sales they have made.",
select s.salesrepid, sr.firstname,  sr.lastname, count(*)
from sales s
left join sales_reprentative sr
on s.SalesRepID=sr.SalesRepID
group by salesrepID; 

--     "6. Find the sales representative details for all sales made in a specific store location (e.g., 'New York').",
use geeksforgeeks;
select concat(sr.firstname, sr.lastname) full_name, s.storelocation
from sales_reprentative sr
join sales s
on sr.salesrepid=s.salesrepid
where s.storelocation='mumbai,maharastra';

--     "7. Get the total sales amount for each product along with its category.",
select p.productname, p.category, sum(s.totalamount) total_amount
from sales s
join products p

on s.productid=p.productid
group by p.productname,p.category;

--     "8. List all customers along with the product they have purchased and the total amount spent.",
select concat(c.firstname, " ", c.lastname) full_name, p.productname, s.totalamount
from sales s
join customers c
on s.customerid=c.customerid
join products p
on s.productid=p.productid;
 
--     "9. Retrieve the sales data including customer names and product details for a specific sales representative.",
use geeksforgeeks;
select c.firstname, p.productname, s.totalamount, s.quantity,sr.salesrepid
from sales s
join customers c
on s.customerid=c.customerid
join products p
on s.productid=p.productid
join sales_reprentative sr
on s.salesrepid= sr.salesrepid
where sr.salesrepid=1;

--     "10. Find the sales representative details and the products sold by them in each region.",

select sr.firstname,sr.lastname, p.productname, sr.region
from sales s 
join sales_reprentative sr
on s.salesrepid=sr.salesrepid
join products p
on p.productid=s.productid
group by sr.region,sr.firstname, sr.lastname,p.productname;

--     "11. Get the total number of products sold and their corresponding sales amount for each customer."
SELECT s.customerID, c.firstname,
COUNT(s.productID) AS total_products_sold,
SUM(s.TotalAmount) AS total_sales_amount
FROM sales s
JOIN customers c ON s.customerID = c.customerID
GROUP BY s.customerID, c.firstname;

--     "12. Retrieve the contact details of customers who have bought products from multiple categories.",
select c.customerID, c.firstname, c.lastname, c.email, c.phonenumber
from sales s
join customers c ON s.customerID = c.customerID
join products p ON s.productID = p.productID
group by c.customerID, c.firstname, c.lastname, c.email, c.phonenumber
having count(distinct p.category)>1; 

--     "13. Get the total quantity sold and the sales amount for each product in a specific region.",
select s.productid, p.productname,  sum(s.quantity) as total_quantity, sum(totalAmount) as total_amount
from sales s
join products p ON s.productID = p.productID
join customers c ON s.customerID = c.customerID
where c.state = 'Delhi'
group by s.productid, p.productname; 

--     "14. Find the customers who have bought products from a specific supplier (e.g., 'ABC Corp').",
select c.customerid, c.firstname, c.email, c.phonenumber
from sales s
join customers c on s.customerID = c.customerID
join products p on s.productID = p.productID
join suppliers su on su.supplierid=p.supplierid
where su.suppliername=' AthleticZone Corp.';

--     "15. List all sales made for a specific product category, including customer details and total amount.",
select * from products;
select  s.saleID, c.customerID, concat(c.firstname, c.lastname) as fullname,c.email, p.productid, p.productname, p.category, s.quantity, s.totalamount
from sales s 
join customers c on s.customerid=c.customerid
join products p on s.productID = p.productID
where p.category='running';

--     "16. Find the customers who purchased the highest quantity of a specific product.",
select c.FirstName, c.LastName, p.ProductName, s.Quantity
from sales s
join customers c on s.customerID=c.CustomerID
join products p on p.productID=s.ProductID
where (p.productID, s.Quantity) in(
                                  select ProductID, max(Quantity)
                                  from sales
                                  group by productID);

--     "17. Get the total number of sales made by each sales representative for a specific time period (e.g., last month).",
select sr.SalesRepId, count(s.saleID) as total_sales
from sales s
join sales_reprentative sr on s.SalesRepId=sr.SalesRepId
where s.Date>='2023-01-01' and s.Date<='2023-02-01'
group by sr.SalesRepId
order by total_sales;

--     "18. List all the products purchased by customers from a specific city (e.g., 'Los Angeles').",
	select  s.productID, CONCAT(c.firstname, ' ', c.lastname) AS customer_name, s.storelocation
    from sales s
    join customers c on s.customerid=c.customerid
    where storeLocation='Ahmedabad, Gujarat';
    
--     "19. Retrieve the sales details of customers who made purchases in two or more store locations.",
select s.*
from sales s where customerid in (
select customerID 
from sales
group by customerID
having count(distinct storelocation)>=2);


--  "20. Find the top 5 products that generated the highest sales amount, along with their category.
SELECT p.productname, p.category, SUM(s.totalamount) AS total_sales_amount
FROM sales s
JOIN products p ON s.productid = p.productid
GROUP BY p.productname, p.category
ORDER BY total_sales_amount DESC
LIMIT 5;