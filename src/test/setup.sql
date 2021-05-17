@src/test/teardown.sql
@src/sql/setup.sql
@src/sql/deploy.sql
-- sidecar tables to hold expected test results
create table subaddress_delete_test (
    sub_address_id number(10,0)
   ,constraint subaddress_delete_testpkc primary key (sub_address_id)
);
create table subaddress_add_test (
    sub_address_id      number(10,0)
   ,melissa_suite       varchar2(255)
   ,ap_id               number(10,0)
   ,additional_loc_info varchar2(80)
   ,building            varchar2(50)
   ,floor               varchar2(50) 
   ,unit                varchar2(50)
   ,room                varchar2(50)
   ,seat                varchar2(50)
   ,boroughcode         varchar2(1)
   ,validation_date     timestamp(6)
   ,update_source       varchar2(50)
   ,usps_hnum           varchar2(15)
   ,constraint subaddress_add_testpkc primary key (sub_address_id)
   ,constraint subaddress_add_testuqc unique (sub_address_id, melissa_suite)
);
-- test data
@src/test/subaddress-src-fixtures.sql
@src/test/melissa-geocoded-src-fixtures.sql
@src/test/melissa-geocoded-src-hnum-fixtures.sql
@src/test/melissa-geocoded-src-nos-fixtures.sql
-- add expected test results to sidecar tables
@src/test/subaddress_delete_fixtures.sql
@src/test/subaddress_add_fixtures.sql
-- done with setup
-- run tests to populate subaddress_delete and subaddress_add
