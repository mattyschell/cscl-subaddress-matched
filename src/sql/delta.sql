-- prepare subaddress_add.sub_address_id sequence
call cscl_subaddress.INIT_SUBADDRESS_ADDSEQ(cscl_subaddress.SUBADDRESS_NEXT_ID());
-- "Not match an existing CSCL subaddress record. Add these unit addresses" 
insert into subaddress_add (
    sub_address_id
   ,melissa_suite
   ,ap_id
   ,usps_hnum
) select
      subaddress_addseq.nextval
     ,suite
     ,addresspointid
     ,hnum
  from
      melissa_geocoded_src
  where (suite
        ,addresspointid
        ,hnum)
  not in (select
              melissa_suite
             ,ap_id
             ,usps_hnum
          from
             subaddress_src);
commit; 
--Any remaining unmatched CSCL subaddresses for an address should be deleted
insert into subaddress_delete (
    sub_address_id
) select 
      sub_address_id 
  from 
      subaddress_src
  where ap_id in 
      (select 
           ap_id 
       from 
           subaddress_add)
  and (melissa_suite
      ,ap_id
      ,usps_hnum)
  not in (select melissa_suite
                ,ap_id
                ,usps_hnum 
          from 
              subaddress_add);
commit;