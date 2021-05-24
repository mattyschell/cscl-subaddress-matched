delete from subaddress_add_test;
commit;
-- test 2: force refresh
insert into subaddress_add_test
    (melissa_suite,ap_id,usps_hnum)
values
    ('RM 1002',1018320,134);
insert into subaddress_add_test
    (melissa_suite,ap_id,usps_hnum)
values
    ('RM 1008',1018320,134);
-- test 3: Add a missing subaddress
insert into subaddress_add_test
    (melissa_suite,ap_id,usps_hnum)
values
    ('APT 3A',3,3);
commit;