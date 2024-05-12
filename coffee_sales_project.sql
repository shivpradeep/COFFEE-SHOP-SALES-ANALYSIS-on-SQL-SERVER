

----COFFEE SHOP SALES ANALYSIS-----

create database coffee_shop_sales
use coffee_shop_sales

select * from coffee_sales

--check null --
select * from Coffee_Sales
where transaction_id is null
or transaction_date is null
or transaction_time is null
or qty is null
or store_id is null
or store_location is null
or product_id is null
or unit_price is null 
or product_category is null
or product_type is null
 
---conclusion:-
--data has clean ,no null found in data

EXEC sp_rename 'coffee_sales.transaction_qty','qty'


----change data type
alter table coffee_sales
alter column unit_price decimal (8,2)

select unit_price from Coffee_Sales


-----------------------------ANALYSIS------------------------
 select * from Coffee_Sales

--Total sales
select sum(qty*unit_price) as total_sales_$$ from Coffee_Sales

--total sales - 698812.33 $
---------------------------------------------------------------

--Total quantity sold

select sum(qty) total_quantity_sold from Coffee_Sales


--total quantity sold - 214470
----------------------------------------------------------------

--product category wise sales and quantity

 select product_category,sum(qty*unit_price) total_sales 
 from Coffee_Sales
 group by product_category

--highest sold and revenue product -- coffee  
--qty =89250 ,sales amount =269952.45
--------------------------------------------------------------------

--coffee sales by product type

select product_category,product_type,
sum(qty*unit_price) total_sales_$$_by_product_type,
sum(qty) totat_quantity 
from Coffee_Sales
where product_category like 'coffee'
group by product_category,product_type
order by total_sales_$$_by_product_type desc

--highest coffee sales by product type 
--is (Barista Espresso) sales = 91406.20


-----------------------------------------------------------------------

--list of sales with product category and product type

select product_category,product_type,sum(qty*unit_price) sales_amount 
from Coffee_Sales
group by product_type,product_category
order by product_category,sales_amount desc

-------------------------------------------------------------------

--Total sale and total quantity by Store location with Store ID 

select store_id,store_location,
ROUND(sum(qty*unit_price),0) total_sales,
sum(qty) total_quantity 
from Coffee_Sales
group by store_location,store_id
order by total_sales desc
-------------------------------------------------------------------


--Total sale/highest sales by transaction time-  like hours 

select DATEPART(hour,transaction_time) hours_wise,
sum(qty*unit_price) highest_sales,sum(qty) total_qty 
from Coffee_Sales
group by DATEPART(hour,transaction_time)
order by highest_sales desc

--highest sales time at coffee shop is = 10:00am,
--sales- 88673.39 and qty - 26713
-------------------------------------------------------------------------

--Total sales by months 

select DATENAME(month,transaction_date) month_wise,
sum(qty*unit_price) total_sales 
from Coffee_Sales
group by DATENAME(month,transaction_date) 
order by total_sales desc

--highest sales in - june month sales - 166485.88

-----------------------------------------------------
 
 