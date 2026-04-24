create database retail_case_study;
use retail_case_study;
select * from sale;


ALTER TABLE sale
CHANGE COLUMN `ï»¿TransactionID` `TransactionID` INT;
select * from sale;

select * from product_inventory;
ALTER TABLE product_inventory
CHANGE COLUMN `ï»¿ProductID` `ProductID` INT;
select * from product_inventory;

select * from customer_profiles;   # ï»¿CustomerID
ALTER TABLE customer_profiles
CHANGE COLUMN `ï»¿CustomerID` `CustomerID` INT;
select * from customer_profiles;

use retail_case_study;

select * from product_inventory;
select * from sale;

## Products are performing well in terms of sales and which are not. 
## This insight is crucial for inventory management and marketing focus.

## ## Products are performing well in terms of sales

## Product ID = 51, Product_Name : Product_51
## Category : Clothing , Sales : 512160
SELECT 
p.productid,
p.productname,
p.category,
round(sum(s.quantitypurchased * s.price ),2) as Sales
from sale as s
join product_inventory as p
on s.productid = p.productid
group by productid,p.productname,
p.category
order by sales desc;

## ## Products are not  performing well in terms of sales :

## Product ID = 139, Product_Name : Product_139
## Category : Beauty & health, Sales : 484.1
SELECT 
p.productid,
p.productname,
p.category,
round(sum(s.quantitypurchased * s.price ),2) as Sales
from sale as s
join product_inventory as p
on s.productid = p.productid
group by productid,p.productname,
p.category
order by sales asc;


# ----> segment customers based on their purchasing behavior for targeted marketing campaigns.
## Customer ID : 664, Count_Of _ Quantity : 39
## Customer Segment : High
with customer_count_quantity as (
select 
s.customerid,
sum(quantitypurchased) as Count_of_Quantity
 From sale as s
 join customer_profiles as c
 on s.customerid = c.customerid
 group by customerid
 order by Count_of_Quantity desc )
 select 
 customerid,
 count_of_quantity,
 case when count_of_quantity = 0 then 'No Order'
 when count_of_quantity between 1 and 10 then 'Low'
 when count_of_quantity between 10 and 30 then 'Mid'
 else 'High_Value' end as Customer_Segment
 from customer_count_quantity
 group by customerid;
 
 
 # ---> Top Customer by Count of Orders
select 
customerid,
count(quantitypurchased) as Count_of_order
from sale
group by customerid
order by count_of_order desc;

# ---> Customer Lifetime Value
# Customer ID : 973, Sale by Customer : 57089.99

select 
c.customerid,
C.gender,
c.age,
round(sum(quantitypurchased * price ),2) as Sale_by_Customer
from Sale as s
join customer_profiles as c
on s.customerid = c.customerid
group by customerid, age, gender
order by sale_by_customer desc;

# ---> Inventory Analysis -
# Product ID : 142, Category : Home & Kitchen
# Stock Level : 185, Sold Quantity : 27
select 
p.productid,
p.category,
p.stocklevel,
sum(s.quantitypurchased) as Sold_Quantity
 from product_inventory as p
 join sale as s
 on p.productid = s.productid
 group by p.productid, p.category,
p.stocklevel
order by Sold_Quantity;
 

