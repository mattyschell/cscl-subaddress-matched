insert into subaddress_src (
     objectid
    ,sub_address_id
    ,melissa_suite
    ,ap_id
    ,additional_loc_info
    ,building
    ,floor
    ,unit
    ,room
    ,seat
    ,created_by
    ,created_date
    ,modified_by
    ,modified_date
    ,globalid
    ,boroughcode
    ,validation_date
    ,update_source
    ,usps_hnum
) 
select 
     objectid
    ,sub_address_id
    ,melissa_suite
    ,ap_id
    ,additional_loc_info
    ,building
    ,floor
    ,unit
    ,room
    ,seat
    ,created_by
    ,created_date
    ,modified_by
    ,modified_date
    ,globalid
    ,boroughcode
    ,validation_date
    ,update_source
    ,usps_hnum
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
insert into melissa_geocoded_src (
     suite
    ,addresspointid
    ,hnum
) 
select 
    distinct
         to_char(suite)
        ,addresspointid
        ,hnum
from 
    melissa_geocoded_a
where 
    addresspointid is not null
and suite is not null;
commit;    
--
-- addresses with no suite at all
-- the NOT IN is required because some melissa_geocoded_address records
-- have a null suite but are tucked in among populated suites
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
   
