use Northwind
go

--9.2
select customerid , orderid , orderdate , 
lag (orderdate)
over ( partition by customerid order by orderdate , orderid) as previous
from orders 
order by customerid , orderdate

--9.3
with latestorders as
(
select * , row_number () 
over ( partition by customerid  order by orderdate desc, orderid desc) as rn
from orders )

select *
from latestorders
where rn = 1

--9.4
select
    productid , productname , unitprice,
    ntile(4) over
    (
        order by unitprice desc
    ) as pricequartile
from products
order by unitprice desc

--9.5
select 
orderid , orderdate , [Freight] ,
sum(Freight) over (
order by orderid , orderdate
rows between unbounded preceding and current row 
) as runningtotal
from orders 
/*money type column is the most suitable for this operation*/
