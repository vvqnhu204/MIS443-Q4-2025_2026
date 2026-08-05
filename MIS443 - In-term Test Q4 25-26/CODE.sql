/* 
MIS 443 - In-term Test Q4
DATE 04/08/2026

STUDENT NAME: VAN VU QUYNH NHU 
STUDENT ID: 2232300079 

*/

/* 
Question 1 – Database Setup (10 marks)

Using pgAdmin & PostgreSQL:

(a) Create a database named yourfullname. Then load all Northwind tables into this schema. (5 marks)
Use file "Northwind.sql"

(b) Create a new table called students inside schema exam with the following columns:

Column	Requirement
studentid	5-digit number, Primary Key
fullname	Required
email	Must be unique

Insert your own information into the table. (5 marks)

Then you can check your database before continuing.
*/ 

select table_name, column_name, data_type
from information_schema.columns
where table_schema = 'public'
order by table_name, ordinal_position; 

--(b) Create table students
create table students(
Studentid integer primary key
			check (Studentid between 10000 and 99999), 			
Fullname varchar(100) NOT NULL, 
Email varchar(100) UNIQUE
); 
--(c) Insert your own record
insert into  students (Studentid, Fullname, Email)
values (12345, 'VANVUQUYNHNHU', 'nhu.vanvu.bbs22@eiu.edu.vn'); 

-- (d) Verify the result
SELECT * FROM students;

-- Question 2: Write an SQL query to find the top 5 customers who placed the highest number of orders.

select c.customer_id, count(o.order_id)as total_orders
from customers c
inner join orders o on c.customer_id=o.customer_id
group by c.customer_id
order by total_orders DESC
LIMIT 5;


-- Question 3: Write an SQL query to display a list of orders and the customers who made them. Sort by order date (newest first)

select o.order_id, o.order_date, c.company_name
from orders o 
join customers c on o.customer_id = c.customer_id 
order by o.order_date DESC ;

-- Question 4: Northwind management wants to identify large product movements to better plan inventory and logistics. 
-- Write an SQL query to display orders where a product was purchased in large quantity (more than 99 units in a single order).

select o.order_id, o.order_date, p.product_name, d.quantity
from orders o 
inner join order_details d on o.order_id = d.order_id 
join products p on d.product_id = p.product_id 
where d.quantity > 99 
order by o.order_id; 


/*Question 5: Northwind management wants to evaluate the delivery performance of each shipping partner. 
Write an SQL query to calculate the average delivery time (in days) for each shipper. 
Delivery time = shipped_date – order_date
*/

select s.company_name, 
	   avg(o.shipped_date - o.order_date) as avg_delivery_days
from orders o 
inner join shippers s on s.shipper_id = o.ship_via 
group by s.company_name
order by avg_delivery_days DESC; 

/* Question 6: Northwind wants to identify the most active customers (customers who place orders most frequently) 
to target retention campaigns. Write an SQL query to rank customers based on their total number of orders (highest = rank 1). 
Customers with the same number of orders must have the same rank.
*/ 
select c.customer_id, 
	   c.company_name, 
	   count(o.order_id) as total_orders, 
dense_rank() over(
				order by count(o.order_id)
				DESC) as ranking 
from customers c  
inner join orders o on c.customer_id = o.customer_id 
group by c.customer_id,  c.company_name
order by ranking ASC; 


