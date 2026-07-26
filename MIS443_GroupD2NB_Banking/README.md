# MIS443 - Assignment 2: PostgreSQL Database Development and SQL Practice

**Course:** MIS 443 - Business Data Management 
**Lecturer:** Mr. Dang Thai Doan 
**Selected Schema:** Banking 
**Group:** D2NB

## Project Description

This project recreates the **Banking** schema from [SQL Practice Online](https://www.sqlpractice.com/) in PostgreSQL. The database models a simplified bank consisting of five related tables (`branches`, `customers`, `accounts`, `transactions`, `loans`) and includes complete solutions for all 30 SQL practice questions provided for this schema.

## Team Members & Contributions

This project was developed collaboratively. Below are the members of Group D2NB and our respective focus areas:

## Team Members & Contributions

This project was developed collaboratively. Below are the members of Group D2NB and our respective focus areas:

| No. | Student Name | Student ID | Task |
| --- | --- | --- | --- | 
| 1 | Vu Dong Duong | 2032300044 | Tested and captured screenshots for SQL Qs 3, 7, 11, 15, 19, 23, 27. Part 1 (Introduction to the selected database) and Part 2 (Table description) | 
| 2 | Than Que Ngoc | 2232300060 | Tested and captured screenshots for SQL Qs 4, 8, 12, 16, 20, 24, 28. Assigned project tasks to all members. Aggregated, checked and edited the report. Part 3 (ERD Diagram) and Part 8 (Responsibility) | 
| 3 | Van Vu Quynh Nhu | 2232300079 | Tested and captured screenshots for SQL Qs 2, 6, 10, 14, 18, 22, 26, 30. Part 5 (Summary table of SQL questions) and Part 7 (Challenges) | 
| 4 | Do Hoang Bao | 2232300071 | Tested and captured screenshots for SQL Qs 1, 5, 9, 13, 17, 21, 25, 29. Part 4 (Summary of database implementation) and Part 9 (Conclusion) |


## Tools Used

* **PostgreSQL:** Core database engine.
* **pgAdmin 4:** Database creation, management, and query execution.
* **SQL Practice Online:** Source schema and question set.
* **Microsoft Word:** Group report documentation.
* **CSV:** Data storage and import format.
* **GitHub:** Version control and project publication.

## Folder Structure

```text
MIS443_GroupD2NB_Banking/
│
├── codes/
│   ├── 01_create_database.sql
│   ├── 02_create_tables_relationships.sql
│   ├── 03_insert_data.sql
│   └── 04_questions_01_30.sql
│
├── data/
│   ├── branches.csv
│   ├── customers.csv
│   ├── accounts.csv
│   ├── transactions.csv
│   └── loans.csv
│
├── report/
│   └── MIS443_GroupD2NB_Banking_Report.docx
│
└── README.md
```


## How to Run

1. Open **pgAdmin 4** and connect to your local PostgreSQL server.
2. Open the Query Tool on the default `postgres` database and run `codes/01_create_database.sql` to create the banking database.
3. Reconnect the Query Tool to the newly created `banking` database.
4. Run `codes/02_create_tables_relationships.sql` to create all tables, primary/foreign keys, and constraints.
5. Run `codes/03_insert_data.sql` to populate the tables (the raw data is also available as CSV files in the `data/` folder).
6. Run `codes/04_questions_01_30.sql` to execute all 30 SQL practice questions and review the output results.

## Source

* Schema and question set provided by: [SQL Practice Online - Banking](https://www.sqlpractice.com/)

## Acknowledgement

This repository showcases the database implementation and SQL problem-solving completed collaboratively by Group D2NB for the MIS 443 course. All members contributed significantly to the successful delivery of the final report and database structure.

