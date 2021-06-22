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
    execute immediate 'drop view subaddress_add_vw';
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
begin
    execute immediate 'drop sequence subaddress_addseq';
exception 
    when others then
    if sqlcode = -2289
    then
        null;
    else
        raise;
    end if;
end;
/