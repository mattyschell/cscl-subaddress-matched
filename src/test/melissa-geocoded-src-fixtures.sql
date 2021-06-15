delete from melissa_geocoded_src;
commit;
-- test 1: simple apt with no changes, nothing will happen
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (3006230, 'APT 1', 568);
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (3006230, 'APT 2', 568);
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (3006230, 'APT 3', 568);
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (3006230, 'BSMT', 568);
-- test 2: 
-- sub_address_id RM 1002 will be force refreshed 
-- should replace all sub address ids on the address point
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (1018320, 'RM 1002', 134);
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (1018320, 'RM 1008', 134);
-- test 3: add a single missing subaddress
-- apt3 is in subaddress_src
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (3, 'APT 3', 100);
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (3, 'APT 3A', 100);
--
-- tests 4 through 9 are single new subaddresses to add
-- (on fake address points 4 through 11)
-- they test the ng911 field updates, not the add/delete logic   
--
-- test 4 "# + Designator" goes to unit
-- does not appear to exist so better add to test suite
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (4, '1A', 4);
-- test 5 a single letter goes to unit
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (5, 'B', 5);
-- test 6 #s go to unit
-- I think this is what test 4 was supposed to be
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (6, '# 11S', 6);
-- test 7 REAR to additional loc vs REAR xx to unit 
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (7, 'REAR', 7);
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (8, 'REAR 1', 8);
-- test 8 BLDGs to Building 
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (9, 'BLDG 1', 9);
-- test 9 FRNT X to room vs FRNT to additional_loc_info 
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (10, 'FRNT', 10);
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (11, 'FRNT 1', 11);
--
-- resume add/remove logic testing
--
-- test 10: 2 subaddreses exist on address point 12, keep APT 1, remove bsmt, add Apt 2
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (12, 'APT 1', 100);
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (12, 'APT 2', 100);
-- test 12: ranged address, force delete, sample copied directly from 
-- https://github.com/mattyschell/cscl-subaddress-matched/issues/4
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (999, 'APT 1', 101);
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (999, 'APT 2', 101);
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (999, 'APT 1', 103);
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (999, 'APT 2', 103);
commit;
