use Northwind
go

--task-3
 --3.1
 select distinct city ,  country 
from customers

union

select distinct city, country
from employees

--3.2
/*3.2 Aggregations
INNER JOIN [Categories] and [Products].
Use GROUP BY to display:
• CategoryName
• The COUNT of products in each category.
Use HAVING to show only categories with more than 10 products.*/

select c.categoryname , count(p.productid) as poductspercat
from categories c join products p
on c.CategoryID = p.CategoryID 
group by c.CategoryName
having count (p.categoryid) > 10


--3.3
select e.firstname as employee , m.firstname as manager, coalesce (m.firstname,'nomanager') as managerstatus
from employees e left join employees m 
on e.reportsto = m.employeeid 

--3.4
select city from customers 
intersect 
select city from employees