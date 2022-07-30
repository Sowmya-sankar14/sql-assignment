show databases;
SELECT database();
USE examsql;
show tables

"1. Write a SQL query which will sort out the customer and their grade who made an order. Every customer must have a grade and be served by at least one seller, who belongs to a region."
SELECT customer.cust_name AS "Customer", customer.grade AS "Grade"
FROM orders, salesman, customer WHERE orders.customer_id = customer.ï»¿custemor_id
AND orders.salesman_id = salesman.salesman_id AND salesman.city IS NOT NULL
AND customer.grade IS NOT NULL ORDER BY customer.grade DESC;

-- 2. Write a query for extracting the data from the order table for the salesman who earned the maximum commission."-- 
SELECT * FROM orders WHERE salesman_id IN
(SELECT salesman_id FROM salesman WHERE commision = (SELECT MAX(commision) FROM salesman));

-- "3.From orders retrieve only ord_no, purch_amt, ord_date, ord_date, salesman_id where salesman’s city is Nagpur(Note salesman_id of orderstable must be other than the list within the IN operator.)"
SELECT ord_no, purch_amt, ord_date, salesman_id
FROM orders
WHERE salesman_id IN (
SELECT salesman_id
FROM salesman WHERE city='nagpur');


-- "4.Write a query to create a report with the order date in such a way that the latest order date will come last along with the total purchase amount and the total commission for that date is (15 % for all sellers)."
SELECT ord_date, SUM(purch_amt) AS "Total Purchase amount", SUM(purch_amt)*.15 AS "Total Commission"
FROM orders GROUP BY ord_date ORDER BY date_format(ord_date , '%d-%m-%y');

-- "5. Retrieve ord_no, purch_amt, ord_date, ord_date, salesman_id from Orders table and display only those sellers whose purch_amt is greater than average purch_amt"
SELECT ord_no, purch_amt, ord_date, salesman_id FROM orders
WHERE purch_amt >(SELECT  AVG(purch_amt) FROM orders);

-- 6. Write a query to determine the Nth (Say N=5) highest purch_amt from Orders table.
#SELECT purch_amt FROM orders ORDER BY purch_amt DESC LIMIT N-1, 1; if N = 5:
SELECT purch_amt FROM orders ORDER BY purch_amt DESC LIMIT 4, 1;

-- 7. What are Entities and Relationships?

-- ENTITIES :
--     Entities are objects that are contained in Master Data Services models. Each entity contains members, which are the rows of master data that you manage.

-- RELATIONSHIP:
--  Relationships are the established associations between two or more tables. Relationships are based on common fields from more than one table, often involving primary and foreign keys. A primary key is the field (or fields) that is used to uniquely identify each record in a table.

-- 8. Print customer_id, account_number and balance_amount, condition that if balance_amount is nil then assign transaction_amount for account_type = "Credit Card"
Select Customer_id , ba.Account_Number,
Case when ifnull(Balance_amount,0) = 0 then   Transaction_amount else Balance_amount end  as Balance_amount
from bank_account_details ba  
inner join
bank_account_transaction bat
on ba.Account_Number = bat.Account_Number
and Account_type = "Credit Card";

-- 9. Print customer_id, account_number, balance_amount, conPrint account_number, balance_amount, transaction_amount from Bank_Account_Details and bank_account_transaction for all the transactions occurred during march, 2020 and april, 2020.
Select bank_account_details.account_number, balance_amount, transaction_amount
from bank_account_details inner join bank_account_transaction on bank_account_details.account_number = bank_account_transaction.account_number
And (date_format(Transaction_Date , '%Y-%m')  between "2020-03" and "2020-04");

--  10. Print all of the customer id, account number, balance_amount, transaction_amount from bank_cutomer, bank_account_details and bank_account_transactions tables where excluding all of their transactions in march, 2020 month .
SELECT bank_account_details.customer_id, bank_account_details.account_number, balance_amount, transaction_amount
FROM bank_account_details LEFT JOIN bank_account_transaction ON bank_account_details.account_number = bank_account_transaction.account_number
LEFT JOIN bank_customer ON bank_account_details.customer_id = bank_customer.customer_id
AND NOT ( date_format(Transaction_Date , '%Y-%m') = "2020-03" );
