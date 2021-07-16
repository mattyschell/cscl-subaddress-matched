delete from melissa_geocoded_src_nos;
commit;
-- tests 13 and 14
-- https://github.com/mattyschell/cscl-subaddress-matched/issues/11
-- address points where we have suites
-- but melissa says none exist. delete them
insert into melissa_geocoded_src_nos
    (addresspointid)
values
    (13);
insert into melissa_geocoded_src_nos
    (addresspointid)
values
    (14);
commit;