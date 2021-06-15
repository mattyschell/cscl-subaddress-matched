-- test 2: force replacement of sub_address_id 1
--         also will replace sub_address_id 2 on the same address point
insert into subaddress_delete 
    (sub_address_id)
values
    (1);
-- test 12: ranged address, force delete, sample copied directly from 
-- https://github.com/mattyschell/cscl-subaddress-matched/issues/4
insert into subaddress_delete 
    (sub_address_id)
values
    (6);
insert into subaddress_delete 
    (sub_address_id)
values
    (7);
insert into subaddress_delete 
    (sub_address_id)
values
    (8);
insert into subaddress_delete 
    (sub_address_id)
values
    (9);
commit;