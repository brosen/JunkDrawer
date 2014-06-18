--All sessions
select * from sys.dm_exec_sessions

select * from sys.dm_os_waiting_tasks order by session_id

--types of waits
select * from sys.dm_os_wait_stats 

/*
Checks from cache before going to disk
*/

--Memory Clercks
select * from sys.dm_os_memory_clerks

--Mem clerk allocation
select type [Memory Clerk],
	SUM (single_pages_kb + multi_pages_kb + virtual_memory_committed_kb +shared_memory_committed_kb) [Total KB]
from sys.dm_os_memory_clerks
group by type
order by  [Total KB] desc

--non buffer pool mem allocation
select type [Memory Clerk],
	SUM (multi_pages_kb + virtual_memory_committed_kb +shared_memory_committed_kb) [OutsideBP KB]
from sys.dm_os_memory_clerks
where type <> 'MEMORYCLERK_SQLBUFFERPOOL'
group by type
order by  [OutsideBP KB] desc

--undocumented
select *
from sys.dm_os_ring_buffers
where ring_buffer_type = 'RING_BUFFER_RESOURCE_MONITOR'


--Pages in data pool
--372767 is db where DMVs are kept
select DB_NAME(database_id) DBNAME, database_id, page_type, COUNT(page_id) number_pages
from sys.dm_os_buffer_descriptors
where database_id != 372767
group by database_id,page_type
order by database_id

--Pages in DB
select DB_NAME(database_id), COUNT(page_id) number_pages
from sys.dm_os_buffer_descriptors
where database_id != 372767
group by database_id
order by 2 desc--database_id



--

sp_who
sp_who2

--
dbcc freeproccache
dbcc freesessioncache 
dbcc dropcleanbuffers