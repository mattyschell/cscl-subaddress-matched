select 'Tuples (ap_id,melissa_suite,usps_hnum) missing from subaddress_add: ' from dual;
select 
    ap_id
   ,UPPER(melissa_suite)
   ,usps_hnum 
from 
    subaddress_add_test
minus
select 
    ap_id
   ,UPPER(melissa_suite) 
   ,usps_hnum
from 
subaddress_add;
select 'Tuples (ap_id,melissa_suite,usps_hnum) that should not be in subaddress_add: ' from dual;
select 
    ap_id
   ,UPPER(melissa_suite) 
   ,usps_hnum
from 
    subaddress_add
minus
select 
    ap_id
   ,UPPER(melissa_suite) 
   ,usps_hnum
from 
subaddress_add_test;
select 'sub_address_ids missing from subaddress_delete: ' from dual;
select 
    sub_address_id 
from 
    subaddress_delete_test
minus
select 
    sub_address_id 
from 
    subaddress_delete;
select 'sub_address_ids that should not be in subaddress_delete: ' from dual;
select 
    sub_address_id 
from 
    subaddress_delete
minus
select 
    sub_address_id 
from 
    subaddress;
select 'Rows in subaddress_add with incorrect attributes: ' from dual;
-- TODO - other derived attributes tests here
