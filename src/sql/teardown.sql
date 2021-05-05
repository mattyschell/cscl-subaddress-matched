begin
    execute immediate 'drop table subaddress_source';
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
    execute immediate 'drop table melissa_geocoded_source';
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
    execute immediate 'drop table subaddress_delete';
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
    execute immediate 'drop table subaddress_add';
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