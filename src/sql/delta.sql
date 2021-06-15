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
-- explanation for the where not exists clause:
-- subaddress_src allows NULL house numbers
-- subaddress_add (our output) will disallow NULL house numbers
-- we require subaddress_src records to be uniquely ID'd without hnum
-- cases where this cannot be done (like legacy ranged addresses)
-- must be force deleted and replaced 
commit; 
-- Any remaining unmatched CSCL subaddresses for an address should be deleted
-- (or written in work table form)
-- For any source address point with some additions in subaddress_add
-- From that source, subtract the melissa data to remove fully matched records 
-- any remaining records in the source should be deleted
insert into subaddress_delete (
    sub_address_id
) 
select 
    aa.sub_address_id 
from 
    subaddress_src aa
join (select 
          a.melissa_suite
         ,a.ap_id
      from 
          subaddress_src a
      where 
          a.ap_id in (select 
                          b.ap_id 
                      from 
                          subaddress_add b)
      minus
      select 
          c.suite
         ,c.addresspointid 
      from 
          melissa_geocoded_src c) bb
on (aa.melissa_suite = bb.melissa_suite
    and aa.ap_id = bb.ap_id);
commit;