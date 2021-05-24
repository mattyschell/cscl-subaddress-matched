-- we allow force refresh by pre-populating subaddress delete
-- add all associated subaddresses to the delete table
-- then make them disappear from the source
insert into subaddress_delete (
    sub_address_id
) select 
        sub_address_id 
    from 
        subaddress_src
    where ap_id in (select 
                        distinct b.ap_id
                    from 
                        subaddress_delete a
                    join
                        subaddress_src b
                    on a.sub_address_id = b.sub_address_id)
    and
        sub_address_id not in (select 
                                   sub_address_id 
                               from 
                                   subaddress_delete);
delete from 
    subaddress_src 
where
    sub_address_id in (select 
                           sub_address_id 
                       from
                            subaddress_delete);
commit;