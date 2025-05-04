drop database HMBank;
create database HMBank;
use HMBank;
create table Customers
(
customer_id int primary key unique not null,
first_name varchar(100) not null,
last_name varchar(100) not null,
DOB date ,
email varchar(100) unique not null,
phone_number varchar(15) unique not null,
address varchar(1000) not null
);
create table Accounts
(
account_id int primary key,
customer_id int,
account_type enum('savings' , 'current' , 'zero_balance') not null,
balance decimal(15,2),
foreign key(customer_id) references Customers(customer_id)
);

create table Transactions
(
transaction_id int  primary key not null auto_increment,
account_id int not null,
transaction_type enum('deposit' , 'withdrawal' , 'transfer') not null,
amount decimal(15,2),
transaction_date date,
foreign key(account_id) references Accounts(account_id)
);


#task 2
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

alter table Transactions modify transaction_date datetime;

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

select concat(first_name,'',last_name) as full_name,account_type,email
from Customers
join Accounts on Customers.customer_id = Accounts.customer_id;

select transaction_id,transaction_type,amount,transaction_date
from Transactions
join Accounts on Transactions.account_id = Accounts.account_id
join Customers on Accounts.customer_id = Customers.customer_id
where Customers.customer_id = 123;

update Accounts
set balance = balance + 100
where account_id = 23;

select concat(first_name,' ',last_name) as full_name
from Customers;

delete from Accounts
where account_id in(
  select account_id from(
  select account_id from Accounts 
  where balance = 0 and account_type = 'savings'
  )as temp
  );

select*from Customers 
where address like '%chennai%';

select balance from Accounts 
where account_id = 26;

select*from Accounts
where account_type = 'current' and balance > 1000;

select*from Transactions 
where account_id = 23;

select account_id,balance * 0.4 as interest
from Accounts
where account_type = 'savings'; 

select*from Accounts
where balance < 1000;

select*from Customers
where address not like "%chennai%"; 

#task 3

select avg(balance) as avg_balance from Accounts;

select*from Accounts order by balance desc limit 10;

select sum(amount) as total_deposits 
from Transactions 
where transaction_type = 'deposit' and date(transaction_date) = '2025-04-03';

select*from Customers order by DOB asc limit 1;
select*from Customers order by DOB desc limit 1;

select t.* ,a.account_type
 from Transactions t
join Accounts a on t.account_id = a.account_id;

select c.* , a.* from Customers c inner join Accounts a on c.customer_id = a.customer_id;

select c.* , t.* from Customers c 
inner join Accounts a on c.customer_id = a.customer_id
inner join Transactions t on t.account_id = a.account_id
where t.account_id = 24;

select c.customer_id,c.first_name, count(a.account_id) as no_of_accounts
from customers c
inner join Accounts a on c.customer_id = a.customer_id
group by c.customer_id
having no_of_accounts > 1;

select sum(case when transaction_type = 'deposit' then amount else 0 end) as total_deposit, 
sum(case when transaction_type = 'withdrawal' then amount else 0 end) as total_withdrawal,
sum(case when transaction_type = 'deposit' then amount else 0 end) - 
sum(case when transaction_type = 'withdrawal' then amount else 0 end) as difference
from Transactions;

select account_id, avg(balance) as avg_daily_balance
from accounts 
group by account_id;

select account_type ,sum(balance) as total_balance 
from accounts 
group by account_type;

select account_id ,count(transaction_id) as no_of_transactions
from transactions
group by account_id
order by no_of_transactions desc;
   
select a.account_type,a.balance,concat(c.first_name,' ',c.last_name) as full_name,c.customer_id
 from accounts a 
 inner join customers c on c.customer_id = a.customer_id
group by c.customer_id,a.account_type,a.balance having a.balance > 500;  

select account_id,amount,transaction_date, count(*) as duplicate
from transactions
group by account_id,amount,transaction_date having duplicate > 1;

-- task 4

