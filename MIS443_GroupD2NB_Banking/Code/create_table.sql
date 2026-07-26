CREATE TABLE branches (
    branch_id INTEGER PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(2) NOT NULL
);


CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    branch_id INTEGER,
    account_opened_date DATE NOT NULL,
    CONSTRAINT fk_customers
    FOREIGN KEY (branch_id)
    REFERENCES branches(branch_id)
);


CREATE TABLE accounts (
    account_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    account_type VARCHAR(20) NOT NULL,
    balance REAL NOT NULL,
    opened_date DATE NOT NULL,
    CONSTRAINT fk_accounts
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);


CREATE TABLE transactions (
    transaction_id INTEGER PRIMARY KEY,
    account_id INTEGER NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    amount REAL NOT NULL,
    transaction_date DATE NOT NULL, 
    CONSTRAINT fk_transactions
    FOREIGN KEY (account_id)
    REFERENCES accounts(account_id)
);


à
CREATE TABLE loans (
    loans_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    loan_amount REAL NOT NULL,
    interest_rate REAL NOT NULL,
    status VARCHAR(20) NOT NULL,
    start_date DATE NOT NULL,
    CONSTRAINT fk_loans
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);