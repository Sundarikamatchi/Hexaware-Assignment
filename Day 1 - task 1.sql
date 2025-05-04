-- Create the database named "HMBank"  --
drop database  if exists HMBank;
create database HMBank;
use HMBank;

/* Define the schema for the Customers, Accounts, and Transactions tables based on the provided schema
Create appropriate Primary Key and Foreign Key constraints for referential integrity 
Write SQL scripts to create the mentioned tables with appropriate data types, constraints, 
and relationships.   
• Customers  
• Accounts 
• Transactions */

create table Customers
(
customer_id int primary key,
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
balance decimal(15,2) default 0.00,
foreign key(customer_id) references Customers(customer_id) on delete cascade
);

create table Transactions
(
transaction_id int auto_increment primary key,
account_id int not null,
transaction_type enum('deposit' , 'withdrawal' , 'transfer') not null,
amount decimal(15,2) not null check (amount > 0),
transaction_date datetime,
foreign key(account_id) references Accounts(account_id) on delete cascade
);

