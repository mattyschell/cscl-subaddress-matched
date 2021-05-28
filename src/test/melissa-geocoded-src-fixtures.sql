delete from melissa_geocoded_src;
commit;
-- test 1: simple apt with no changes, nothing will happen
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (3006230, 'Apt 1', 568);
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (3006230, 'Apt 2', 568);
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (3006230, 'Apt 3', 568);
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (3006230, 'Bsmt', 568);
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
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (3, 'Apt 3', 3);
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (3, 'Apt 3a', 3);
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
commit;
