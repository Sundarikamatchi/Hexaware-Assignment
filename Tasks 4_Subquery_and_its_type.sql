
-- task 4 --
use  HMBank;

-- 1.Retrieve the customer(s) with the highest account balance --
select customer_id,account_id from accounts where balance in (select max(balance) from accounts);

-- 2.Calculate the average account balance for customers who have more than one account --
select avg(balance) from accounts where balance in 
(select count(customer_id) as duplicate from accounts group by account_id having duplicate > 1); 

-- 3.Retrieve accounts with transactions whose amounts exceed the average transaction amount --
select account_id from transactions where amount > (select avg(amount) as transaction_amount from transactions );

-- 4.Identify customers who have no recorded transactions --
select customer_id from accounts where account_id in (select distinct account_id from transactions where transaction_id is null);

-- 5.Calculate the total balance of accounts with no recorded transactions --
select balance from accounts where account_id not in(select account_id from transactions);

-- 6.Retrieve transactions for accounts with the lowest balance --
select transaction_id,transaction_type from transactions where account_id in
(select account_id from accounts where balance = (select min(balance) from accounts) ); 

-- 7.Identify customers who have accounts of multiple types --
select distinct*from accounts where account_id in(select distinct account_id from transactions );

-- 8.Calculate the percentage of each account type out of the total number of accounts --
select account_type,count(*) as account_type,round(count(*) * 100.0/(select count(*)  from accounts ) )as percentage 
from accounts group by account_type;

-- 9.Retrieve all transactions for a customer with a given customer_id --
select*from transactions where account_id in(select account_id from accounts where customer_id = 123);

-- 10.Calculate the total balance for each account type, including a subquery within the SELECT clause --
select sum(balance) as total_balance,account_type accounts from accounts where account_type in
(select distinct account_type from accounts) group by account_type;