use Northwind
go

--task-2
 --2.1
 select upper(ProductName) as PRODUCTNAME ,
 case when unitprice > 50 then 'premium' else 'standard'
 end as pricecategory 
 from Products 

 --2.2
 /*products that are more than 30 and there are more than 30 pieces in stock*/
 select productid , productname , unitsinstock , cast (UnitPrice as decimal (10,2)) as price
 from products
 where UnitPrice > 20 and unitsinstock > 30
 order by UnitPrice desc  

 --2.3
 -- finding which columns have null values
 /*select customerid from customers where  [Region] is null*/

 select customerid, region, coalesce (region,'unknown') as missingregions
 from customers 

 --or
 select customerid, region, case when region is null then 'unknown' else 'known' end as missingregions
 from customers
