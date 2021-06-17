-- either load CSCL subaddresses directly into this table
-- or insert from some other temporary source 
-- (see insert_source.sql, assumes load to table named subaddress)
-- in testing we will populate this from the repo
create table subaddress_src (
    sub_address_id      number(10,0)
   ,melissa_suite       varchar2(255)
   ,ap_id               number(10,0)
   ,usps_hnum           number -- this is varchar in cscl I dont know why
   ,constraint subaddress_srcpkc primary key (sub_address_id)
);
-- insert from some other temporary source (see insert_source.sql)
-- this is limited to the columns we use
-- in testing we will populate this from the repo
-- 
create table melissa_geocoded_src (
     addresspointid     number
    ,suite              varchar2(256)
    ,hnum               number
    ,constraint melissa_geocoded_srcuqc unique (addresspointid,suite,hnum)
);
-- geocoded but no suite, probably not going to use these
-- these are either base addresses for each set of units
-- or errors, missing units in melissa (only about 2k of these)
create table melissa_geocoded_src_nos (
    addresspointid      number 
   ,constraint melissa_geocoded_src_nospkc primary key (addresspointid)
);
-- the next two are outputs
-- though subaddress delete can be prepopulated to force replacements
create table subaddress_delete (
    sub_address_id number(10,0)
   ,constraint subaddress_deletepkc primary key (sub_address_id)
);
create table subaddress_add (
    id                  number generated always as identity
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
   ,constraint subaddress_addpkc primary key (id)
   ,constraint subaddress_adduqc unique (ap_id, melissa_suite, usps_hnum) 
);
-- cscl team would like to receive output that is identical (except globalid)
-- create a view with all of the columns dummified
create or replace view subaddress_add_vw
as 
select 
    cast(null as number) as objectid
   ,cast(null as number(10,0)) as sub_address_id
   ,cast(melissa_suite as nvarchar2(255)) as melissa_suite
   ,cast(ap_id as number(10,0)) as ap_id
   ,cast(additional_loc_info as nvarchar2(80)) as additional_loc_info
   ,cast(building as nvarchar2(50)) as building
   ,cast(floor as nvarchar2(50)) as floor
   ,cast(unit as nvarchar2(50)) as unit
   ,cast(room as nvarchar2(50)) as room
   ,cast(seat as nvarchar2(50)) as seat
   ,cast(null as nvarchar2(50)) as created_by
   ,cast(null as date) as created_date
   ,cast(null as nvarchar2(50)) as modified_by
   ,cast(null as date) as modified_date
   ,cast(null as nvarchar2(1)) as boroughcode
   ,cast(null as timestamp(6)) as validation_date
   ,cast('USPS Melissa data' as nvarchar2(50)) as update_source
   ,cast(usps_hnum as nvarchar2(15)) as usps_num
from subaddress_add;

