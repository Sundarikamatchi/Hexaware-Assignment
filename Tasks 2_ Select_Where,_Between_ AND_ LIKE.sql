#task 2
use HMBank;
/*Insert at least 10 sample records into each of the following tables.   
• Customers  
• Accounts 
• Transactions */

 set foreign_key_checks = 0; 
truncate table customers;
truncate table accounts;
truncate table transactions;
set foreign_key_checks = 1; 

 insert into Customers(customer_id , first_name , last_name , DOB ,email, phone_number , address)
 values (123, 'kamatchi', 'sundari', '2003-11-09', 'sundari@gmail.com', '9150405435', 'southstreet,dindigul - 624801'),
(133, 'divya', 'bharathi', '2003-11-12', 'bharathi@gmail.com', '9086427547', 'southstreet,chennai - 600201'),
(143, 'Devi', 'lakshmi', '2004-09-09', 'devi@gmail.com', '9854673643', 'southstreet,vedasandur,dindigul - 624807'),
(153, 'Banu', 'mathi', '2001-11-21', 'mathi@gmail.com', '8764527876', 'southstreet,sirkazhi,cuddalur - 613801'),
(163, 'neela', 'veni', '2004-11-11', 'veni@gmail.com', '9836426734', 'southstreet,coimbatore - 602801'),
(173, 'sopana', 'sundari', '2003-04-09', 'sundari6@gmail.com', '8754367264', 'southstreet,madurai - 625801'),
(183, 'loges', 'waran', '2001-11-03', 'logi@gmail.com', '9854672476', 'southstreet,dindigul - 624801'),
(124, 'lithika', 'sri', '2003-07-19', 'lithika@gmail.com', '8653472754', 'southstreet,kulathur,chennai - 600801'),
(127, 'hari', 'haran', '2003-12-19', 'hari@gmail.com', '8765177657', 'southstreet,gudaloor,nilgiri - 625801'),
(223, 'sai', 'sujan', '2003-05-03', 'sujan@gmail.com', '7635826536', 'southstreet,adyar,chennai - 600025');
 
 insert into Accounts(customer_id,account_id,account_type,balance) values (123,22, 'savings', 1500.00),
(133, 23, 'current', 2500.00),
(143, 24 ,'savings', 1200.00),
(153, 25, 'current', 3000.00),
(163, 26, 'zero_balance', 0.00),
(173, 27, 'savings', 1000.00),
(183, 33, 'current', 500.00),
(124, 34, 'savings', 700.00),
(127, 35, 'zero_balance', 0.00),
(223, 36, 'savings', 2000.00);

insert into Transactions(account_id,transaction_type,amount,transaction_date) values 
(22, 'deposit', 500.00, '2025-04-01 10:00:00'),
(23, 'withdrawal', 300.00, '2025-04-02 11:30:00'),
(24, 'deposit', 400.00, '2025-04-03 09:45:00'),
(25, 'transfer', 250.00, '2025-04-04 15:20:00'),
(26, 'deposit', 1000.00, '2025-04-05 12:10:00'),
(27, 'withdrawal', 200.00, '2025-04-06 13:00:00'),
(33, 'deposit', 350.00, '2025-04-07 14:30:00'),
(34, 'withdrawal', 100.00, '2025-04-08 10:15:00'),
(35, 'transfer', 50.00, '2025-04-09 16:00:00'),
(36, 'deposit', 800.00, '2025-04-10 09:00:00'); 

select*from Customers;
select*from Accounts;
select*from Transactions;

-- 1. a SQL query to retrieve the name, account type and email of all customers --
select concat(c.first_name,'',c.last_name) as full_name,a.account_type,c.email from Customers c,Accounts a
where c.customer_id = a.customer_id;

-- 2. a SQL query to list all transaction corresponding customers --
select concat(c.first_name,'',c.last_name) as full_name, t.transaction_id,t.transaction_type,t.amount,t.transaction_date
from Transactions t,Accounts a,customers c
where t.account_id = a.account_id and a.customer_id = c.customer_id and c.customer_id = 123;

-- 3.a SQL query to increase the balance of a specific account by a certain amount --
update Accounts set balance = balance + 1000 where account_id = 23;

-- 4. a SQL query to Combine first and last names of customers as a full_name --
select concat(first_name,' ',last_name) as full_name from Customers;

-- 5. a SQL query to remove accounts with a balance of zero where the account type is savings --
delete from Accounts where balance = 0 and account_type = 'savings' and account_id is not null;
select*from accounts;

-- 6. a SQL query to Find customers living in a specific city --
select*from Customers where address like '%chennai%';

-- 7. a SQL query to Get the account balance for a specific account--
select balance from Accounts where account_id = 26;

-- 8. a SQL query to List all current accounts with a balance greater than $1,000.--
select*from Accounts where account_type = 'current' and balance > 1000;

-- 9. a SQL query to Retrieve all transactions for a specific account. --
select*from Transactions where account_id = 23;

-- 10. a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate --
select account_id,balance * 0.4 as interest from Accounts where account_type = 'savings'; 

-- 11. a SQL query to Identify accounts where the balance is less than a specified overdraft limit --
select*from Accounts where balance < 1000;

-- 12. a SQL query to Find customers not living in a specific city --
select*from Customers where address not like "%chennai%"; 