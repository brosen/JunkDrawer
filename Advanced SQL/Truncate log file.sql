--make sure database is not in use by killing processes or restarting the server

use brad20140
ALTER DATABASE brad20140 SET RECOVERY SIMPLE WITH NO_WAIT
DBCC SHRINKFILE(rave564gold_log, 1)
ALTER DATABASE brad20140 SET RECOVERY FULL WITH NO_WAIT