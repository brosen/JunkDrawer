drop table numbers
go
create table numbers (num int)
go
insert into numbers values (1)
insert into numbers values (2)
insert into numbers values(3)
insert into numbers values(4)
insert into numbers values(5)
insert into numbers values(6)
--select * from numbers
GO

with rsfc(iteration, running_fact) as
(
	select num as iteration,
		1 as run
	from numbers where num=1
	union all 
	select r.iteration+1,
		r.running_fact * b.num
	from rsfc r
		join numbers b on (r.iteration+1)=b.num
)
select iteration, running_fact [running factorial] from rsfc