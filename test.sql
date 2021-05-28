@src/test/setup.sql
@src/sql/forcerefresh.sql
@src/sql/delta.sql
@src/sql/populate911fields.sql
SET HEADING OFF
SET FEEDBACK OFF
SET ECHO OFF
SET TERMOUT ON
SET PAGESIZE 0
set LINESIZE 9999
set TRIMSPOOL ON
SPOOL report.txt
@src/test/report.sql
SPOOL OFF
@src/test/teardown.sql
EXIT