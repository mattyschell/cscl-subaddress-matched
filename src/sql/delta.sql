-- "Not match an existing CSCL subaddress record. Add these unit addresses" 
insert into subaddress_add (
    melissa_suite
   ,ap_id
) select
      suite
     ,addresspointid
  from
      melissa_geocoded_src
  where (UPPER(suite)
        ,addresspointid)
  not in (select
             melissa_suite
            ,ap_id
          from
             subaddress_src);
commit; 
--Any remaining unmatched CSCL subaddresses for the address should be deleted
insert into subaddress_delete (
    sub_address_id
) select 
      sub_address_id 
  from 
      subaddress_src
  where ap_id in 
      (select ap_id from subaddress_add)
  and (melissa_suite
      ,ap_id)
  not in (select melissa_suite, ap_id from subaddress_add);
commit;
