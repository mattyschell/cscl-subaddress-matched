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
-- sub_address_id 1 will be force refreshed 
-- should add the house number to output
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (1018320, 'RM 1002', 134);
-- different suite on the same address should be left alone
-- we must ensure it doesnt get caught in 
-- "all other subaddresses not added should be deleted"
insert into melissa_geocoded_src
    (addresspointid, suite, hnum)
values
    (1018320, 'RM 1008', 134);
commit;