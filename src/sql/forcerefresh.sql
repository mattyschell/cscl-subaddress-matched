-- we allow force refresh by pre-populating subaddress delete
-- add all associated subaddresses to the delete table
-- then make them disappear from the source
-- we first add all sub addresses associated with the address point
-- just in case some, but not all, sub addresses are in subaddress-delete
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
-- remove them from the source to force refresh
delete from 
    subaddress_src 
where
    sub_address_id in (select 
                           sub_address_id 
                       from
                            subaddress_delete);
commit;
-- do not delete from subaddress_delete here
-- we need these forced ids to be output for deletion at the source
