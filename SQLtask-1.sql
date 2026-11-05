use Northwind
go

--task-1 ddl
-- 1.1
create table Project_AuditLog (

LogID int identity (1,1) Primary Key ,
 TableName varchar (50)  Not Null,
 ActionPerformed varchar (50) not null,
 ActionDate datetime default getdate()

 )

 --1.2
 alter table Project_AuditLog 
 add constraint chk_ActionPerformed
 check (ActionPerformed in ('Added' , 'Updated' , 'Deleted'))
 /*makes sure that values in this columns are only theses statues*/

 --1.3
 /* IN DDL LIFE CYCLE:-
 CREATE TABLE : is used to make a new table 
 ALTER TABLE : is used to edit the table we made
 DROP TABLE : is used to delete that table */
