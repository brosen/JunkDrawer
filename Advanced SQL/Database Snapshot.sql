CREATE DATABASE sanofi_br_3_24_17_snap
ON
(
NAME =rave564gold,
FILENAME ='m:\sanofi_br_3_24_17_snap.mdf'
) 
AS SNAPSHOT OF sanofi_br_3_24_17


--------------------------------------------------------------------------------

USE master;  
RESTORE DATABASE sanofi_br_3_24_17 from   
DATABASE_SNAPSHOT = 'sanofi_br_3_24_17_snap';  
GO  