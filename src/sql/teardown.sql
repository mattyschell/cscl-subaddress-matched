begin
    execute immediate 'drop table subaddress_src';
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
    execute immediate 'drop table melissa_geocoded_src';
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
    execute immediate 'drop table melissa_geocoded_src_nos';
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
    execute immediate 'drop table melissa_geocoded_src_hnum';
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