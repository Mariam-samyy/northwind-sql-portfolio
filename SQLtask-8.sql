use Northwind
go

--task-8
--8.1
create table #Staging_Shippers 
( ShipperID  INT, 
CompanyName  NVARCHAR(50))

insert into #Staging_Shippers 
( ShipperID  , CompanyName  )
values 
(1, 'Speedy Express V2'),
(4, 'Global Logistics')

--8.2
/*8.2 MERGE Synchronization
Write a MERGE statement synchronizing [Shippers] as the Target with #Staging_Shippers as the Source.
Match on:
ShipperID
Required behavior:
• WHEN MATCHED: UPDATE the CompanyName.
• WHEN NOT MATCHED BY TARGET: INSERT the new ShipperID and CompanyName.*/
set identity_insert Shippers on
merge shippers as target 
using #Staging_Shippers as  Source

on target.shipperid = source.shipperid

when matched then
update set target.companyname = source.companyname

when not matched by target then
insert (shipperid , companyname)
values (source.shipperid , source.companyname);

set identity_insert Shippers off

select * from shippers

--8.3
declare @watermark datetime
set @watermark = '1996-09-12'
select * from orders
where orderdate > @watermark 
order by orderdate asc

/*incremental extractions only deals with data modified agter the watermark
but repeated processes deals with all data each time */

--8.4
select s.shipperid , s.companyname from shippers s
left join #Staging_Shippers st
on s.shipperid = st.shipperid
where st.shipperid is null

/*soft delete means marking a record as deleted without
physically removing it from the table.

hard delete means permanently removing it from the tavle

Delete handling should be controlled because a missing
record in the staging data does not always mean it should
be deleted from the target table
*/

--8.5
/*because while syncing we update existing data and add data only in unmatched cases*/

