use Northwind
go

--task-5
--5.1
/*Create a view named:
vw_CustomerOrderSummary
The view must provide a useful summary containing appropriate customer/order information, such as:
• CustomerID
• CompanyName
• Number of Orders
Use an appropriate join and aggregation.*/
go
create or alter view vw_CustomerOrderSummary as
select c.CustomerID , c.CompanyName , count(o.orderid) as orderscount
from customers c join orders o 
on c.CustomerID = o.CustomerID
group by c.CustomerID , c.CompanyName
go
select * from vw_CustomerOrderSummary

--5.2
/*sp_GetCustomerOrders
It must:
• Accept @CustomerID as NCHAR(5).
• Return all columns from the [Orders] table for that specific customer.
Include an EXEC statement to test it with:*/

go
create or alter proc sp_GetCustomerOrders
@CustomerID nchar(5)
as 
begin
select * from orders 
where customerid = @CustomerID
end
exec sp_GetCustomerOrders 
@CustomerID = 'ALFKI'
go 

--5.3
go
create or alter function dbo.fn_GetCustomerOrderCount
(@CustomerID NCHAR(5))
returns int
as 
begin 
return
(select  count (orderid)  from orders 
where customerid = @CustomerID)
end 
go

select dbo.fn_GetCustomerOrderCount ('ALFKI') as ordercount 

--5.4
/* - normal views store only the query so we neet to execute it each time we need and it is used for small date that is always updated 
 - materialized (indexed) views store the query and the result it is used with bigger data with more complecated operations that is why it needs maintenance   */
