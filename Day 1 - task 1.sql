create database HMBank;
use HMBank;
create table Customers
(
customer_id int primary key,
first_name varchar(100),
last_name varchar(100),
DOB date,
email varchar(100) unique,
phone_number int unique,
address varchar(1000)
);
create table Accounts
(
account_id int primary key,
customer_id int,
account_type enum('savings' , 'current' , 'zero_balance'),
balance decimal(15,2),
foreign key(customer_id) references Customers(customer_id)
);

create table Transactions
(
transaction_id int primary key,
account_id int,
transaction_type enum('deposit' , 'withdrawal' , 'transfer'),
amount decimal(15,2),
transaction_date int,
foreign key(account_id) references Accounts(account_id)
);
