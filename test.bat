set SCHEMA=REPLACEWITHSCHEMANAME
set DATABASE=REPLACEWITHDATABASE
set SCHEMAPASS="iluvesri247"
CALL sqlplus %SCHEMA%/%SCHEMAPASS%@%DATABASE% @test.sql