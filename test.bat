REM set SCHEMA=SCHEMAGOESHERE
REM set DATABASE=DATABASEGOESHERE
REM set SCHEMAPASS=iluvoracle247
CALL sqlplus %SCHEMA%/%SCHEMAPASS%@%DATABASE% @src/test/setup.sql
REM delta procedure here
REM CALL python .\src\test\test_cx_sde.py 
REM CALL sqlplus %SCHEMA%/%SCHEMAPASS%@%DATABASE% @src/test/teardown.sql
