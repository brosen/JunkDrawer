with folderh as
(
	--Parent/Anchor
	select dbo.fnlocaldefault(foldername) Folder,instanceid,
		cast('' as nvarchar(255)) ParentFolder,
		cast(0 as int) ParentId,i.subjectid,0 as lvl
	from instances i
		join folders f on f.folderid=i.folderid 
	where ParentInstanceID is NULL
	union all
	--Child/iterate
	select dbo.fnlocaldefault(foldername) Folder,i.instanceid,
		cast(h.Folder as nvarchar(255)), 
		cast(h.instanceid as int),i.subjectid,lvl+1
	from folderh h
		join instances i on h.instanceid=i.parentinstanceid
		join folders f on f.folderid=i.folderid 
)
select * 
from folderh
where --instanceid=12920
	--and 
	subjectid=1610
--------------------------------
--Better below
--------------------------------

with folderh as
(
	--Parent/Anchor
	select dbo.fnlocaldefault(foldername) Folder,
		instanceid,
		i.subjectid,
		cast('' as nvarchar(255)) ParentFolder,
		0 as lvl
	from instances i
		join folders f on f.folderid=i.folderid 
	where ParentInstanceID is NULL
		and subjectid=1610
	union all
	--Child/iterate
	select dbo.fnlocaldefault(foldername) Folder,
		i.instanceid,
		i.subjectid,
		cast(h.Folder as nvarchar(255)),
		lvl+1
	from folderh h
		join instances i on h.instanceid=i.parentinstanceid
		join folders f on f.folderid=i.folderid 
)
select * 
from folderh
