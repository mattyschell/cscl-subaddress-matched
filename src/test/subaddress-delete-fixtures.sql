-- test 2: force replacement of sub_address_id 1
--         also will replace sub_address_id 2 on the same address point
insert into subaddress_delete 
    (sub_address_id)
values
    (1);
commit;