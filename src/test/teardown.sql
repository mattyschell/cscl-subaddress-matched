delete from melissa_geocoded_src;
delete from melissa_geocoded_src_nos;
begin
    execute immediate 'drop table subaddress_delete_test';
exception 
    when others then
    if sqlcode = -942
    then
        null;
    else
        raise;
    end if;
end;
/
begin
    execute immediate 'drop table subaddress_add_test';
exception 
    when others then
    if sqlcode = -942
    then
        null;
    else
        raise;
    end if;
end;
/
