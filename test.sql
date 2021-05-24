@src/test/setup.sql
@src/sql/forcerefresh.sql
@src/sql/delta.sql
SET FEEDBACK OFF
SET ECHO OFF
SET PAGESIZE 0
SPOOL report.txt
@src/test/report.sql
SPOOL OFF
@src/test/teardown.sql
EXIT