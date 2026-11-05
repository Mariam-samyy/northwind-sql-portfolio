use Northwind
go

--task-4
--4.1
/*Create a CTE named EmpSales that calculates the Total Sales:
• SUM(Quantity * UnitPrice)
per EmployeeID from the [Order Details] and [Orders] tables.
Join this CTE with the [Employees] table to display:
• Employee's FirstName
• Total Sales*/

with EmpSales as 
(
select o.employeeid , sum(od.quantity * od.unitprice) as totalsales  from orders o
join [Order Details] od 
on o.orderid = od.orderid
group by o.employeeid )

select
    e.firstname,
    es.totalsales
from employees e
join EmpSales es
on e.employeeid = es.employeeid


--4.2
select c.CustomerID
from Customers c
where not exists
(
    select *
    from Orders o
    where o.CustomerID = c.CustomerID
)
--outer is null
select c.CustomerID , coalesce (o.CustomerID,'NoOrders') as orders
from Customers c
 left join orders o 
on o.CustomerID = c.CustomerID
where o.CustomerID is null


--4.3
/*Write a correlated subquery that finds products whose UnitPrice is greater than the average UnitPrice of products
in the same category.
The inner query must depend on the current row of the outer query.*/ 

select p.productid , p.productname from products p 
where p.UnitPrice > (
select avg(p2.UnitPrice) from products p2
where p.CategoryID = p2.CategoryID

)

--4.4
create  table #top_product (productid int ,productname varchar(50),unitprice decimal(10,2))
SELECT productID, productName, unitPrice
INTO #top_product
from products
where UnitPrice > 50
--query
select * from #top_product

--4.5
declare  @topcategory table (categoryid int , categoryname varchar(15), Description ntext)
insert into @topcategory
select categoryid, categoryname , [Description] from categories 
--query
select * from @topcategory

--4.6
/* normal temporary tables (#temp) are only available during the current sessions 
but global ones (##temp) can be used in more than one session when they exist 
and different users can access to same tables in a work environment so we should be careful
*/

