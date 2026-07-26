-- Q1: Return the complete customer roster from the customers table.
SELECT * FROM customers c; 

--Q2: Return all branch names and their cities.
SELECT b.branch_name, b.city
FROM branches b ;

--Q3: Return all accounts with account type Savings.
SELECT a.account_id, a.customer_id, a.balance 
FROM accounts a
WHERE a.account_type = 'Savings'; 

--Q4: Return accounts with a balance greater than $10,000.
SELECT a.customer_id, a.account_type, a.balance 
FROM accounts a 
WHERE a.balance > 10000
ORDER BY a.balance ; 

--Q5: Return all transactions of type Deposit.
SELECT t.transaction_id, t.account_id, t.amount, t.transaction_date
FROM transactions t
WHERE t.transaction_type = 'Deposit'
ORDER BY t.transaction_date; 

--Q6: Return all loans with an Active status.
SELECT l.loans_id, l.customer_id, l.loan_amount, l.interest_rate 
FROM loans l
WHERE l.status = 'Active' 
ORDER BY l.loans_id; 

--Q7: Count the total number of accounts.
SELECT COUNT(a.account_id) AS total_accounts
FROM accounts a ; 

--Q8: Sum the total amount across all Deposit transactions.
SELECT SUM (t.amount) AS total_deposits
FROM transactions t
WHERE t.transaction_type = 'Deposit'; 

--Q9: The product team needs a list of all account types offered. 
--Find all unique account types available. Show account_type ordered alphabetically.
SELECT DISTINCT(a.account_type)
FROM accounts a
ORDER BY a.account_type ASC; 

--Q10: The audit team needs to review mid-month activity. 
--Find all transactions where transaction_date is between January 10 and January 20, 2025 (inclusive). Show transaction_id, account_id, amount, and transaction_date. Order by transaction_date.
SELECT t.transaction_id, t.account_id, t.amount, t.transaction_date 
FROM transactions t
WHERE 
t.transaction_date >= '2025-01-10' AND t.transaction_date <= '2025-01-20'
ORDER BY t.transaction_id ASC; 

--Q11: transaction_date is between January 10 and January 20, 2025 (inclusive). Show transaction_id, account_id, amount, and transaction_date. 
--Order by transaction_date.
SELECT c.first_name, c.last_name 
FROM customers c
WHERE c.customer_id NOT IN 
	(SELECT a.customer_id FROM accounts a); 

--Q12: The loans department needs to identify customers who have not taken any loan — potential targets for a new loan campaign. 
--Find all customers who have no loans. Show first name and last name ordered by last name.
SELECT c.first_name, c.last_name
FROM customers c
WHERE c.customer_id NOT IN (SELECT l.customer_id FROM loans l) 
ORDER BY c.last_name; 

--Q13: The relationship management team wants to know how diversified each customer's portfolio is. 
--Show every customer's full name and the number of accounts they hold (including zero). 
--Order by account_count descending, then last name.
SELECT c.first_name, c.last_name, COUNT(a.account_id) AS account_count 
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.first_name, c.last_name, c.customer_id
ORDER BY account_count DESC, c.last_name; 

--Q14: Calculate the total balance for each account type.
SELECT c.account_type, SUM(c.balance) AS  total_balance
FROM accounts c 
GROUP BY c.account_type
ORDER BY c.account_type; 

--Q15: Return each customer's name alongside their branch name.
SELECT c.first_name, c.last_name, b.branch_name
FROM customers c 
LEFT JOIN branches b ON c.branch_id = b.branch_id 
ORDER BY last_name; 

--Q16: Return each transaction with the transaction date, amount, type, and the customer's last name.
SELECT t.transaction_date, t.amount, t.transaction_type, c.last_name
FROM transactions t 
LEFT JOIN accounts a ON t.account_id = a.account_id 
JOIN customers c ON a.customer_id = c.customer_id 
ORDER BY transaction_type; 

--Q17: Return the number of customers assigned to each branch.
SELECT b.branch_name, COUNT(c.customer_id) AS customer_count 
FROM branches b
LEFT JOIN customers c ON b.branch_id = c.branch_id 
GROUP BY b.branch_name, b.branch_id
ORDER BY b.branch_name, b.branch_id; 

--Q18: Return the number of accounts held by each customer.
SELECT a.customer_id, COUNT(a.account_id) AS account_count 
FROM accounts a 
GROUP BY a.customer_id
ORDER BY a.customer_id; 

--Q19: Return each loan with the borrower's first and last name, loan amount, and status.
SELECT c.first_name, c.last_name, l.loan_amount, l.status
FROM loans l
LEFT JOIN customers c ON l.customer_id = c.customer_id 
ORDER BY loan_amount DESC; 

--Q20: Return the total account balance held by customers at each branch.
SELECT b.branch_name, SUM(a.balance) AS total_balance
FROM accounts a 
LEFT JOIN customers c ON a.customer_id = c.customer_id
JOIN branches b ON c.branch_id = b.branch_id 
GROUP BY b.branch_name
ORDER BY total_balance DESC; 

--Q21: The branch operations team wants a portfolio view of every customer's holdings. 
--Show each customer's name, their branch name, account type, and balance. 
--Order by branch name, then customer last name.
SELECT c.first_name, c.last_name, b.branch_name, a.account_type, a.balance
FROM branches b 
LEFT JOIN customers c ON b.branch_id = c.branch_id
JOIN accounts a ON c.customer_id = a.customer_id 
ORDER BY b.branch_name, c.last_name; 

--Q22: For each account that has transactions,  
--show total deposits and total withdrawals side by side using conditional aggregation. Order by account_id.
SELECT t.account_id, 
SUM(CASE WHEN t.transaction_type = 'Deposit' THEN amount ELSE 0 END) AS total_deposits, 
SUM(CASE WHEN t.transaction_type = 'Withdrawal' THEN amount ELSE 0 END) toatl_withdrawal
FROM transactions t 
GROUP BY t.account_id
ORDER BY t.account_id; 

--Q23: Group transactions by year-month (using strftime). 
--Show month, transaction count, and total amount. Order by month ascending.
SELECT TO_CHAR(t.transaction_date, 'YYYY-MM') AS month, 
	COUNT(t.transaction_id) AS transaction_count, 
	SUM(t.amount) AS total_amount 
FROM transactions t 
GROUP BY month
ORDER BY month ASC; 

--Q24: The operations team wants to contact customers who have never used their accounts. 
--Find customers who have no transactions in any of their accounts. 
--Show first name and last name.
SELECT c.first_name, c.last_name
FROM customers c 
WHERE NOT EXISTS (
	SELECT * FROM accounts a 
	JOIN transactions t ON a.account_id = t.account_id 
	WHERE a.customer_id = c.customer_id 
ORDER BY c.first_name
); 

--Q25: Create a cash flow list combining all deposits (labelled 'Income') and all withdrawals (labelled 'Expense') 
-- into one unified report. Show account_id, amount, flow_type, and transaction_date. Order by transaction_date.
SELECT t.account_id, t.amount ,t.transaction_date,
CASE WHEN t.transaction_type ='Deposit' THEN 'Income'
	ELSE 'Expense'
	END AS flow_type
FROM transactions t
ORDER BY t.transaction_date; 

--Q26: Find the customer with the largest total active loan amount. 
--Show first name, last name, and total_loans. Only include Active loans.
SELECT c.first_name,c.last_name,SUM(l.loan_amount)AS total_loans
FROM customers c
INNER JOIN loans l ON c.customer_id=l.customer_id
WHERE l.status='Active'
GROUP BY c.first_name,c.last_name
ORDER BY total_loans DESC
LIMIT 1;

--Q27: The wealth management team wants to identify accounts performing above their peer group. 
--Find accounts with a balance above the average balance for their account_type. 
--Show account_id, account_type, balance, and customer name.
SELECT 
	a.account_id, 
	a.account_type, 
	a.balance, 
	c.first_name, 
	c.last_name 
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.balance > (select AVG(a2.balance) 
	FROM accounts a2 WHERE a2.account_type = a.account_type)
ORDER BY a.account_id;

--Q28: Rank accounts by balance within each account type using a window function. 
--Show account_id, account_type, balance, and balance_rank. 
--Order by account_type, then rank.
SELECT a.account_id, a.account_type, a.balance, 
    RANK() OVER (PARTITION BY account_type ORDER BY balance DESC) AS balance_rank
FROM accounts a
ORDER BY a.account_type, balance_rank;

--Q29: The branch management team wants to identify the top depositor at each location. 
--Find the customer with the highest total account balance in each branch. 
--Show first name, last name, branch name, and total_balance.
WITH customer_balance AS (
    SELECT 
        c.customer_id,
        c.first_name, 
        c.last_name, 
        c.branch_id, 
        SUM(a.balance) AS total_balance 
    FROM customers c 
    JOIN accounts a ON c.customer_id = a.customer_id 
    GROUP BY c.customer_id, c.first_name, c.last_name, c.branch_id
), 
ranked AS (
    SELECT 
        customer_id,
        first_name,
        last_name,
        branch_id,
        total_balance, 
        RANK() OVER (
            PARTITION BY branch_id 
            ORDER BY total_balance DESC
        ) AS rnk 
    FROM customer_balance
)
SELECT 
    r.first_name, 
    r.last_name, 
    b.branch_name, 
    r.total_balance
FROM ranked r 
JOIN branches b ON r.branch_id = b.branch_id 
WHERE r.rnk = 1
ORDER BY b.branch_name;


--Q30: The product team wants a breakdown of account distribution by balance tier. 
--Using a CTE, classify accounts into tiers: High (balance >= 10000), Medium (balance >= 3000), Low (below 3000). 
--Show each tier's account count, average balance, and total balance. 
--Order by avg_balance descending.
WITH account_tiers AS (
    SELECT 
        account_id, 
        account_type, 
        balance, 
        CASE 
            WHEN balance >= 10000 THEN 'High'
            WHEN balance >= 5000 THEN 'Medium' 
            ELSE 'Low'
        END AS tier
    FROM accounts
)
SELECT 
    tier, 
    COUNT(*) AS account_count, 
    AVG(balance) AS avg_balance,  
    SUM(balance) AS total_balance 
FROM account_tiers
GROUP BY tier
ORDER BY avg_balance DESC;