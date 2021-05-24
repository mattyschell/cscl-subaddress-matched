delete from subaddress_add_test;
commit;
insert into subaddress_add_test
    (melissa_suite,ap_id,usps_hnum)
values
    ('RM 1002',1018320,134);
insert into subaddress_add_test
    (melissa_suite,ap_id,usps_hnum)
values
    ('RM 1008',1018320,134);
commit;