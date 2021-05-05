insert into subaddress_source (
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
) select 
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
from subaddress;
commit;
insert into melissa_geocoded_source (
     suite
    ,addresspointid
) select 
     suite
    ,addresspointid
from melissa_geocoded_a
where addresspointid is not null;
commit;    
   
