declare subjcur cursor fast_forward for select subjectid,studysiteid from subjects
	
open subjcur
fetch subjcur into @subjectid,@studysiteid

while(@@fetch_status=0)
begin



fetch subjcur into @subjectid,@studysiteid
end

close subjcur
deallocate subjcur
