use Northwind
go

--task-7 
--7.1
/*Write the DDL to CREATE an AFTER UPDATE trigger named:
trg_AuditProducts
on the [Products] table.
Whenever a product is updated, it must automatically INSERT a record into:
Project_AuditLog
with:
• TableName = 'Products'
• ActionPerformed = 'Product Updated'*/
go
create or alter trigger trg_AuditProducts on products 
after update
as 
begin
insert into dbo.Project_AuditLog (TableName  ,
 ActionPerformed )
select 'products' , 'product updated' from inserted
end
go

--7.2
go
create or alter trigger trg_AuditProducts on products 
after delete
as 
begin
insert into dbo.Project_AuditLog (TableName  ,
 ActionPerformed )
select 'products' , 'product deleted' from deleted
end
go