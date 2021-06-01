delete from subaddress_add_test;
commit;
-- test 2: force refresh
insert into subaddress_add_test
    (melissa_suite,ap_id,room,usps_hnum)
values
    ('RM 1002',1018320,'RM 1002',134);
insert into subaddress_add_test
    (melissa_suite,ap_id,room,usps_hnum)
values
    ('RM 1008',1018320,'RM 1008',134);
-- test 3: Add a missing subaddress
insert into subaddress_add_test
    (melissa_suite,ap_id,unit,usps_hnum)
values
    ('APT 3A',3,'APT 3A',3);
-- test 4 "# + Designator" goes to unit
-- does not appear to exist so better add to test suite
insert into subaddress_add_test
    (melissa_suite,ap_id,unit,usps_hnum)
values
    ('1A',4,'1A',4);
-- test 5 a single letter goes to unit
insert into subaddress_add_test
    (melissa_suite,ap_id,unit,usps_hnum)
values
    ('B',5,'B',5);
-- test 6 #s go to unit
insert into subaddress_add_test
    (melissa_suite,ap_id,unit,usps_hnum)
values
    ('# 11S',6,'# 11S',6);
-- test 8 REAR to additional loc vs REAR xx to unit 
insert into subaddress_add_test
    (melissa_suite,ap_id,additional_loc_info,usps_hnum)
values
    ('REAR', 7, 'REAR', 7);
insert into subaddress_add_test
    (melissa_suite,ap_id,unit,usps_hnum)
values
    ('REAR 1', 8, 'REAR 1', 8);
insert into subaddress_add_test
    (melissa_suite,ap_id,building,usps_hnum)
values
    ('BLDG 1', 9, 'BLDG 1', 9);
commit;