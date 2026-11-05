use Northwind
go

--task-6
--6.1
begin try 
begin transaction 
save transaction beforepriceupdate

update products
set unitprice = unitprice + 5
where productid = 1

select 1/0

commit transaction
end try

begin catch
if @@TRANCOUNT > 0
rollback transaction
select ERROR_MESSAGE() as errormessage
end catch

/* 
ACID: 
Amicity: all transactions or none
Consistancy: doesnt affect valid state of database
Isolation: to isolate concurrent transactions
Durability: transaction committed even if the system crashes 

Blpcking:
if a transaction has a lock for another one the other waits untill it is done

DeadLock: more than one transaction are blocking eachothers then sql server rollbacks one so the other is committed */


