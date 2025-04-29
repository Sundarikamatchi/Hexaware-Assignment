create database HMBank;
use HMBank;
create table Customers
(
customer_id int primary key,
first_name varchar(100) not null,
last_name varchar(100) not null,
DOB date ,
email varchar(100) unique not null,
phone_number int unique not null,
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
transaction_id int primary key,
account_id int not null,
transaction_type enum('deposit' , 'withdrawal' , 'transfer') not null,
amount decimal(15,2),
transaction_date date,
foreign key(account_id) references Accounts(account_id)
);
