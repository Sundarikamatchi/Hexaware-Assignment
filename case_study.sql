create database if not exists Ecommerce;
use Ecommerce;
create table customers
(
customer_id int primary key unique,
name varchar(50) not null,
email varchar(50) unique not null unique,
password varchar(50) not null unique
);
create table products
(
product_id int primary key,
name varchar(100) not null,
price decimal(15,2) not null,
description varchar(500),
stock_quantity int not null
);
create table cart
(
cart_id int primary key unique,
customer_id int not null,
product_id int not null,
quantity int not null,
foreign key(customer_id) references  customers(customer_id),
foreign key(product_id) references products(product_id)
);
create table orders
(
order_id int primary key unique,
customer_id int not null,
order_date datetime,
total_price decimal(15,2) not null,
shipping_address varchar(500) not null,
foreign key(customer_id) references customers(customer_id)
);
create table order_items
(
order_item_id int primary key,
order_id int not null,
product_id int not null,
quantity int not null,
foreign key(order_id) references orders(order_id),
foreign key(product_id) references products(product_id)
);
