set serveroutput on;
-- Loading multi-million record datasets 
--    melissa_geocoded_a
--    subaddress
-- may require many hours, especially if using ESRI tools.
-- This is a quick smoke test that the expected data and types
-- are loading correctly.  ESRI frequently loads data in chunks
-- so best to run this a few minutes in to a tabletotable load
-- instead of discovering tomorrow morning that today was a wash.
declare
    outp varchar2(32);
begin
    select 
        case count(*)
        when 1 then 
            'SUPER' 
        end 
    into outp  from (
    select 
         sub_address_id
        ,trim(upper(melissa_suite))
        ,ap_id
        ,to_number(usps_hnum) --cscl is character
    from subaddress
    where rownum = 1);
    dbms_output.put_line('We are looking: ' || outp);
end;
/
declare
    outp varchar2(32);
begin
    select 
        case count(*)
        when 1 then 
            'SUPER' 
        end into outp
    from (
    select 
        distinct
            addresspointid
           ,trim(upper(to_char(suite)))
           ,to_number(hnum)
    from 
        melissa_geocoded_a
    where 
        addresspointid is not null
    and suite is not null
    and rownum = 1);
    dbms_output.put_line('We are looking: ' || outp);
end;
/
EXIT