/* Question 2 – Customer and Account Overview (10 marks)

(a) The Customer Service Manager needs a contact list of customers living in New York. 
Display customer_id, the customer’s full name as full_name, and city. Sort by customer_id. (5 marks)
*/ 

select c.customer_id, c.first_name, c.last_name, c.city
from customers c 
where c.city = 'New York'
order by c.customer_id ; 

/* Question 2 – Customer and Account Overview (10 marks)

(b) Management needs to confirm the size of the account portfolio. 
Calculate the total number of accounts and name the result total_accounts. (5 marks)
*/ 

select count(a.account_id) as total_accounts 
from accounts a; 

/* Question 3 – Account Balance Analysis (20 marks)
(a) The Finance Manager wants to monitor funds held in Checking accounts. 
Calculate their total balance and name the result total_checking_balance. (10 marks)
*/ 

select sum(a.balance) as total_checking_balance 
from accounts a 
where a.account_type = 'Checking';

/* Question 3 – Account Balance Analysis (20 marks)
For each customer living in Los Angeles, display customer_id, full_name, and total_balance across all account types. 
Sort by total_balance from highest to lowest. (10 marks)
*/ 

select c.customer_id, 
	   c.first_name || ' ' || c.last_name as full_name,
	   sum(a.balance) as total_balance 
from customers c
inner join accounts a on a.customer_id = c.customer_id 
where c.city = 'Los Angeles'
group by c.customer_id, 
	     full_name
order by total_balance desc
; 

/* 
Question 4 – Branch and Customer Portfolio Analysis (20 marks)
(a) Identify the branch with the highest average account balance. 
Display branch_id, branch_name, city, and average_balance. Round to two decimal places and include ties. (10 marks)
*/ 

select b.branch_id, 
	   b.branch_name, 
	   b.city, 
	   round(avg(a.balance),2) as average_account_balance 
from branches b 
inner join accounts a on a.branch_id = b.branch_id 
group by b.branch_id, b.branch_name, b.city
order by average_account_balance desc ; 


/* 
Question 4 – Branch and Customer Portfolio Analysis (20 marks)
(b) Identify the customer who owns the single account with the highest current balance. 
Display customer_id, full_name, account_id, account_type, and balance. Include ties. (10 marks)
*/ 

select c.customer_id, 
	   c.first_name || ' ' || c.last_name as full_name,
	   a.account_id, 
	   a.account_type, 
	   a.balance 
from customers c 
inner join accounts a on a.customer_id = c.customer_id 
group by c.customer_id, full_name, a.account_id, a.account_type, a.balance 
order by a.balance desc ; 

/* 
Question 5 – Customer Value and Activity (20 marks)
(a) Identify the most active customers based on the total number of transactions across all their accounts. 
Display customer_id, full_name, and total_transactions. Include ties. (10 marks)
*/ 

select c.customer_id, 
	   c.first_name || ' ' || c.last_name as full_name,
	   count(t.transaction_id) as total_transactions 
from customers c 
inner join accounts a on a.customer_id = c.customer_id 
inner join transactions t on a.account_id = t.account_id 
group by c.customer_id, full_name
order by total_transactions desc; 


/* 
Question 5 – Customer Value and Activity (20 marks)
b) Identify the customer with the highest combined balance across Checking and Savings accounts. 
Exclude Credit Card accounts. Display customer_id, full_name, and total_deposit_balance. Include ties. (10 marks)
*/ 

select c.customer_id, 
	   c.first_name || ' ' || c.last_name as full_name,
	   sum(a.balance) as total_deposit_balance 
from customers c
inner join accounts a on a.customer_id = c.customer_id 
where a.account_type = 'Checking'  
	  or a.account_type = 'Savings'
group by c.customer_id, full_name 
order by total_deposit_balance desc; 

/* 
Question 6 – Advanced Finance Analysis (20 marks)
(a) Identify the branch with the highest total balance across all account types. 
Display branch_id, branch_name, and total_balance. Include ties. (10 marks)
*/ 

select b.branch_id, b.branch_name, sum(balance) as total_balance 
from branches b
inner join accounts a on a.branch_id = b.branch_id 
group by b.branch_id, b.branch_name 
order by total_balance desc; 

/* 
Question 6 – Advanced Finance Analysis (20 marks)
(b) Rank all customers by total balance across all account types. 
Equal totals must receive the same rank without gaps. Display customer_id, full_name, total_balance, and balance_rank. 
Do not use a CTE. (5 marks)
*/ 

select c.customer_id, 
	   c.first_name || ' ' || c.last_name as full_name,
	   sum(a.balance) as total_balance, 
	   dense_rank() over (
					order by sum(a.balance) desc 
	   ) as balance_rank 
from customers c 
inner join accounts a on a.customer_id = c.customer_id
group by c.customer_id, full_name 
order by balance_rank, c.customer_id; 

/* 
Question 6 – Advanced Finance Analysis (20 marks)
(c) Use a CTE to calculate the total number of transactions for every branch, including branches with no transactions. 
Return the branch or branches with the highest total. Display branch_id, branch_name, and total_transactions. (5 marks)
*/ 

with branch_transaction as (
      select b.branch_id, b.branch_name, count(t.transaction_id) as total_transactions
	  from branches b 
	  inner join accounts a on a.branch_id = b.branch_id 
	  inner join transactions t on t.account_id = a.account_id
	  group by b.branch_id, b.branch_name 
	  )
	  
select branch_id, branch_name, total_transactions
from branch_transaction
order by total_transactions desc 
; 
