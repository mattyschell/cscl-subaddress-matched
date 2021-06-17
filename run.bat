set SCHEMA=REPLACEWITHSCHEMANAME
set DATABASE=REPLACEWITHDATABASE
set SCHEMAPASS="iluvesri247"
set SDEFILE=C:\REPLACEWITHSDE.sde
set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
CALL sqlplus %SCHEMA%/%SCHEMAPASS%@%DATABASE% @src/sql/setup.sql
CALL sqlplus %SCHEMA%/%SCHEMAPASS%@%DATABASE% @src/sql/insert_source.sql
CALL sqlplus %SCHEMA%/%SCHEMAPASS%@%DATABASE% @run.sql
%PROPY% .\src\py\export.py && (
  echo exported file geodatabase from %SDEFILE% on %date% at %time% 
) || ( echo failed to export from %SDEFILE% && EXIT /B 1 )  