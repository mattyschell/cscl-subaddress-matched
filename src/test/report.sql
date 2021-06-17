select 'Tuples (ap_id,melissa_suite,usps_hnum) missing from subaddress_add: ' 
from 
    dual;
select 
    ap_id
   ,upper(melissa_suite)
   ,usps_hnum 
from 
    subaddress_add_test
minus
select 
    ap_id
   ,upper(to_char(melissa_suite) )
   ,to_char(usps_hnum)
from 
subaddress_add_vw;
select 'Tuples (ap_id,melissa_suite,usps_hnum) that should not be in subaddress_add_vw: ' 
from 
    dual;
select 
    ap_id
   ,upper(TO_CHAR(melissa_suite)) 
   ,to_char(usps_hnum)
from 
    subaddress_add_vw
minus
select 
    ap_id
   ,upper(melissa_suite) 
   ,usps_hnum
from 
subaddress_add_test;
select 'sub_address_ids missing from subaddress_delete: ' 
from 
    dual;
select 
    sub_address_id 
from 
    subaddress_delete_test
minus
select 
    sub_address_id 
from 
    subaddress_delete;
select 'sub_address_ids that should not be in subaddress_delete: ' 
from 
    dual;
select 
    sub_address_id 
from 
    subaddress_delete
minus
select 
    sub_address_id 
from 
    subaddress_delete_test;
-- these existed in legacy data, make sure we dont add more
-- NULL melissa suites or different mixed case versions of No Data
select 'Tuples (ap_id,melissa_suite,usps_hnum) with null or ''No Data'' melissa_suite:' 
from 
    dual;
select 
    ap_id
   ,melissa_suite
   ,usps_hnum
from 
    subaddress_add_vw
where 
    melissa_suite is null
or  upper(to_char(melissa_suite)) LIKE '%NO DATA%';
-- these existed in legacy data. populated melissa_suite but
-- all six NG911 compartmentalized information fields are NULL
select 'Tuples (ap_id,melissa_suite,usps_hnum) with no NG911 compartmentalized information fields:' 
from 
    dual;
select 
    ap_id
   ,melissa_suite
   ,usps_hnum 
from 
    subaddress_add_vw
where 
    additional_loc_info is null
and building is null
and floor is null
and unit is null
and room is null
and seat is null
and melissa_suite is not null;
-- verify ng911 fields in test match expected fixtures
-- this only works on the hand-crafted 1:1 tests (single ap_id on both sides to join)
-- add to the end of the where clause (or rewrite this!)
select 'Tuples (ap_id,melissa_suite,usps_hnum) with unexpected NG911 compartmentalized information fields:' 
from 
    dual;
select 
    a.ap_id
   ,a.melissa_suite
   ,a.usps_hnum
from 
    subaddress_add_vw a
join 
    subaddress_add_test b
on 
    a.ap_id = b.ap_id
where (
    NVL(a.additional_loc_info,'NA') <> NVL(b.additional_loc_info,'NA')
or  NVL(a.building,'NA') <> NVL(b.building,'NA')
or  NVL(a.floor,'NA') <> NVL(b.floor,'NA')
or  NVL(a.unit,'NA') <> NVL(b.unit,'NA') 
or  NVL(a.room,'NA') <> NVL(b.room,'NA') 
or  NVL(a.seat, 'NA') <> NVL(b.seat,'NA')
)
and a.ap_id in (4,5,6,7,8,9,10,11);


