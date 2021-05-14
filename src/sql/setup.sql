-- either load CSCL subaddresses directly into this table
-- or insert from some other temporary source 
-- (see insert_source.sql, assumes load to table named subaddress)
-- in testing we will populate this from the repo
create table subaddress_src (
    objectid            number
   ,sub_address_id      number(10,0)
   ,melissa_suite       varchar2(255)
   ,ap_id               number(10,0)
   ,additional_loc_info varchar2(80)
   ,building            varchar2(50)
   ,floor               varchar2(50) 
   ,unit                varchar2(50)
   ,room                varchar2(50)
   ,seat                varchar2(50)
   ,created_by          varchar2(50)
   ,created_date        timestamp (6)
   ,modified_by         varchar2(50)
   ,modified_date       timestamp (6)
   ,globalid            char(38) 
   ,boroughcode         varchar2(1)
   ,validation_date     timestamp(6)
   ,update_source       varchar2(50)
   ,usps_hnum           varchar2(15)
   ,constraint subaddress_srcpkc primary key (sub_address_id)
   ,constraint subaddress_srcuqc unique (sub_address_id, melissa_suite)
);
create index subaddress_srcap_id
   on subaddress_src (ap_id);
-- insert from some other temporary source (see insert_source.sql)
-- this is limited to the columns we use
-- in testing we will populate this from the repo
create table melissa_geocoded_src (
     addresspointid     number
    ,suite              varchar2(256)
    ,constraint melissa_geocoded_srcpkc primary key (addresspointid, suite)
);
-- geocoded but no suite, probably useless
-- these are either base addresses for each set of units
-- or errors, missing units in melissa (only about 2k of these)
create table melissa_geocoded_src_nos (
    addresspointid      number 
   ,constraint melissa_geocoded_src_nospkc primary key (addresspointid)
);
-- we need hnum but it belongs to addresspoints, not units
-- normalized and inserted from melissa here
create table melissa_geocoded_src_hnum (
    addresspointid      number
   ,hnum                number
   ,constraint melissa_geocoded_src_hnumpkc primary key (addresspointid, hnum)
);
--the next two are outputs
create table subaddress_delete (
    sub_address_id number(10,0)
   ,constraint subaddress_deletepkc primary key (sub_address_id)
);
create table subaddress_add (
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
   ,constraint subaddress_addpkc primary key (sub_address_id)
   ,constraint subaddress_adduqc unique (sub_address_id, melissa_suite)
);
    