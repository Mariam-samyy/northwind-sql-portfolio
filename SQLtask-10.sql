use Northwind
go

--task-10
--10.1
create nonclustered index IX_Orders_CustomerID on orders (customerid)
include ( OrderDate, Freight )

--10.2
select Orderid
from orders
where OrderDate >= '1997-01-01'
  and OrderDate < '1998-01-01'

--10.3
-- query 1
select orderid
from orders
where year(orderdate) = 1997

-- query 2
select orderid
from orders
where orderdate >= '1997-01-01'
  and orderdate < '1998-01-01'

/* The second query is more efficient because it filters
   OrderDate directly without using a function.
   This allows SQL Server to use an index more efficiently
   
    also after displaying execution plan we find that the second
    query has lower execution cost*/

--10.4
UPDATE STATISTICS Orders;
/*Statistics help Optimizer to estimate the number
of rows we get by a query and decide hoe it will be executed*/

--10.5
/*
B-Tree:
a data structure used by indexes to organize data
and make searching faster

selectivity:
how unique the values in a column are
high selectivity means fewer rows have the same value

clustered index:
an index that determines the physical order of data
in a table. A table can have only one clustered index

non-clustered index:
A separate structure that stores indexed values
and pointers to the actual table rows

composite index:
an index created on two or more columns
to improve queries that search using these columns
*/

--10.6
/*
partitioning:
 suitable column for partitioning Orders table is orderdate

partitioning by date divides the table into smaller sections
based on date ranges such as yearly or monthly partitions

this helps in partition elimination as SQL server can
read only the partitions that contain the required dates
instead of scanning the whole table
*/