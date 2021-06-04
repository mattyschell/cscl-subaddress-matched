insert into subaddress_src (
     sub_address_id
    ,melissa_suite
    ,ap_id
    ,usps_hnum
) 
select 
     sub_address_id
    ,trim(upper(melissa_suite))
    ,ap_id
    ,to_number(usps_hnum) --cscl is character
from subaddress;
commit;
--
--this distinct appears to be necessary
--example of duplicates:
--
--ADDRESS      |SUITE |ADDRESSPOINTID
---------------|------|--------------
--1 Audubon Ave|Apt 1A|       1055323
--7 Audubon Ave|Apt 1A|       1055323
--1 Audubon Ave|Apt 1B|       1055323
--7 Audubon Ave|Apt 1B|       1055323
--125 W 147th St    |Apt 10A|       1051686
--101-125 W 147th St|Apt 10A|       1051686
--101 W 147th St    |Apt 10A|       1051686
--
-- hnum can be null
insert into melissa_geocoded_src (
    addresspointid
   ,suite
   ,hnum
) 
select 
    distinct
        addresspointid
       ,trim(upper(to_char(suite)))
       ,to_number(hnum)
from 
    melissa_geocoded_a
where 
    addresspointid is not null
and suite is not null;
commit;    
--
-- addresses with no suite at all, about 2k
-- the NOT IN is required because many melissa_geocoded_address records
-- have a null suite that are tucked in among populated suites
-- for the same address, these are the "base address" for those units
insert into melissa_geocoded_src_nos (
    addresspointid
) 
select
    distinct addresspointid 
from 
    melissa_geocoded_a
where 
    addresspointid is not null
and suite is null
and addresspointid not in (select 
                               addresspointid 
                           from 
                              melissa_geocoded_src);
commit;   
call dbms_stats.gather_schema_stats(USER);

