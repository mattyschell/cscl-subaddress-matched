delete from subaddress_delete_test;
commit;
-- test 2
-- this is forced delete of sub_address_id 1. 
-- also sub address id 2 on the same address point
-- Should be forced to be deleted
insert into subaddress_delete_test 
    (sub_address_id)
values
    (1);
insert into subaddress_delete_test 
    (sub_address_id)
values
    (2);
-- test 10: 2 subaddresses exist on address point 12, keep APT 1, remove bsmt, add Apt 2
--          address point 10, BSMT unit issub_address_id 4 in subaddress-src-fixtures 
insert into subaddress_delete_test
    (sub_address_id)
values
    (4);
-- test 12: ranged address, force delete, sample copied directly from 
-- https://github.com/mattyschell/cscl-subaddress-matched/issues/4
insert into subaddress_delete_test
    (sub_address_id)
values
    (6);
insert into subaddress_delete_test
    (sub_address_id)
values
    (7);
insert into subaddress_delete_test
    (sub_address_id)
values
    (8);
insert into subaddress_delete_test
    (sub_address_id)
values
    (9);
commit;