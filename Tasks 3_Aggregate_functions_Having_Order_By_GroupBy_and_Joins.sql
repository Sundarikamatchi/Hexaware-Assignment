#task 3
use HMBank;

-- 1.Write a SQL query to Find the average account balance for all customers--
select round(avg(balance)) as avg_balance from Accounts;

-- 2. Write a SQL query to Retrieve the top 10 highest account balances --
select*from Accounts order by balance desc limit 10;

-- 3.Write a SQL query to Calculate Total Deposits for All Customers in specific date --
select sum(amount) as total_deposits,date(transaction_date) as transaction_date from Transactions 
where transaction_type = 'deposit' and date(transaction_date) = '2025-04-03' group by date(transaction_date);

-- 4.Write a SQL query to Find the Oldest and Newest Customers --
select*from Customers order by customer_id asc limit 1; 
select*from Customers order by customer_id desc limit 1;

--  5.Write a SQL query to Retrieve transaction details along with the account type--
select t.* ,a.account_type from Transactions t join Accounts a on t.account_id = a.account_id;

-- 6.Write a SQL query to Get a list of customers along with their account details--
select c.* , a.* from Customers c inner join Accounts a on c.customer_id = a.customer_id;

-- 7.Write a SQL query to Retrieve transaction details along with customer information for a specific account --
select concat(c.first_name , ' ' , c.last_name) as customer_name,c.* , t.* from Customers c inner join Accounts a on c.customer_id = a.customer_id
inner join Transactions t on t.account_id = a.account_id where t.account_id = 24;

-- 8.Write a SQL query to Identify customers who have more than one account --
select c.customer_id,concat(c.first_name , ' ' , c.last_name) as customer_name, count(a.account_id) as no_of_accounts from customers c
inner join Accounts a on c.customer_id = a.customer_id group by c.customer_id having no_of_accounts > 1;

-- 9.Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals --
select sum(case when transaction_type = 'deposit' then amount else 0 end) as total_deposit, 
sum(case when transaction_type = 'withdrawal' then amount else 0 end) as total_withdrawal,
sum(case when transaction_type = 'deposit' then amount else 0 end) - 
sum(case when transaction_type = 'withdrawal' then amount else 0 end) as difference from Transactions;

--  10.Write a SQL query to Calculate the average daily balance for each account over a specified period --
select t.account_id,round(sum(t.amount) / count(distinct date(t.transaction_date)), 2) as avg_daily_deposit,date(t.transaction_date) as transaction_date
from transactions t where t.transaction_type = 'deposit'and t.transaction_date between '2025-04-01' and '2025-04-07'
group by t.account_id,date(t.transaction_date) having avg_daily_deposit > 0 order by avg_daily_deposit desc;

-- 11.Calculate the total balance for each account type --
select account_type ,sum(balance) as total_balance from accounts group by account_type;

--  12.Identify accounts with the highest number of transactions order by descending order --
select account_id ,count(transaction_id) as no_of_transactions from transactions group by account_id order by no_of_transactions desc;
 
--  13.List customers with high aggregate account balances, along with their account types -- 
select a.account_type,a.balance,concat(c.first_name,' ',c.last_name) as full_name,c.customer_id from accounts a 
inner join customers c on c.customer_id = a.customer_id
group by c.customer_id,a.account_type,a.balance having a.balance > 500;  

--  14.Identify and list duplicate transactions based on transaction amount, date, and account --
select account_id,amount,transaction_date, count(*) as duplicate from transactions
group by account_id,amount,transaction_date having duplicate > 1;



