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
--
commit;
