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
     ,a.suite
     ,a.addresspointid
     ,a.hnum
  from
      melissa_geocoded_src a
where not exists
    (select 1
     from 
         subaddress_src b
     where a.suite = b.melissa_suite
     and   a.addresspointid = b.ap_id);
commit; 
--Any remaining unmatched CSCL subaddresses for an address should be deleted
insert into subaddress_delete (
    sub_address_id
) select distinct
    a.sub_address_id
from
    subaddress_src a
join 
    subaddress_add b
on 
    a.ap_id = b.ap_id
where not exists
    (select 1
     from 
         subaddress_add c
     where a.melissa_suite = c.melissa_suite
     and   a.ap_id = c.ap_id);
commit;