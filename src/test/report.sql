select 'Tuples (ap_id,melissa_suite,usps_hnum) missing from subaddress_add: ' 
from 
    dual;
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
select 'Tuples (ap_id,melissa_suite,usps_hnum) that should not be in subaddress_add: ' 
from 
    dual;
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
    subaddress;
-- these existed in legacy data, make sure we dont add more
-- NULL melissa suites or different mixed case versions of No Data
select 'sub_address_ids with null or ''No Data'' melissa_suite:' 
from 
    dual;
select 
    sub_address_id
from 
    subaddress_add
where 
    melissa_suite is null
or  upper(melissa_suite) LIKE '%NO DATA%';
-- these also existed in legacy data. populated melissa_suite but
-- all six NG911 compartmentalized information fields are NULL
select 'sub_address_ids with no NG911 compartmentalized information fields:' 
from 
    dual;
select 
    sub_address_id 
from 
    subaddress_add
where 
    additional_loc_info is null
and building is null
and floor is null
and unit is null
and room is null
and seat is null
and melissa_suite is not null;


