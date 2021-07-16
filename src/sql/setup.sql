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
-- geocoded addresses with no suite, ( _nos = no suite)
-- we will ignore "base addresses" for each set of units
-- and add address points here that have no subaddresses
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
   ,boroughcode         varchar2(1)
   ,validation_date     timestamp(6)
   ,usps_hnum           varchar2(15)
   ,constraint subaddress_addpkc primary key (id)
   ,constraint subaddress_adduqc unique (ap_id, melissa_suite, usps_hnum) 
);
-- cscl team would like to receive output that is identical (except globalid)
-- leave off objectid too since output is file gdb where it will be created 
-- create a view with all of the columns dummified
create or replace view subaddress_add_vw
as 
select 
    cast(null as number(10,0)) as sub_address_id
   ,cast(a.melissa_suite as nvarchar2(255)) as melissa_suite
   ,cast(a.ap_id as number(10,0)) as ap_id
   ,case
       when upper(a.melissa_suite) like 'DEPT%'
       or   upper(a.melissa_suite) = 'FRNT' -- distinguish from FRNT in room
       or   upper(a.melissa_suite) like 'LOT%'
       or   upper(a.melissa_suite) like 'PIER%'
       or   upper(a.melissa_suite) like 'SIDE%'
       or   upper(a.melissa_suite) like 'STOP%'
       or   upper(a.melissa_suite) = 'REAR' -- distinguish from REAR xx in unit
       then
           cast(a.melissa_suite as nvarchar2(80))
       else
           null
    end as additional_loc_info 
   ,case
       when upper(a.melissa_suite) LIKE 'BLDG%'
       then
           cast(a.melissa_suite as nvarchar2(50))
       else
           null
    end as building 
   ,case
       when upper(a.melissa_suite) like 'BSMT%'
       or   upper(a.melissa_suite) like 'FL%'
       or   upper(a.melissa_suite) like 'LOWR%'
       or   upper(a.melissa_suite) like 'UPPR%'
       then
           cast(a.melissa_suite as nvarchar2(50))
       else
           null
    end as floor 
   ,case
       when upper(a.melissa_suite) like 'APT%'
       or   upper(a.melissa_suite) like 'PH%'
       or   upper(a.melissa_suite) like 'SPC%'
       or   upper(a.melissa_suite) like 'STE%'
       or   upper(a.melissa_suite) like 'UNIT%'
       or   upper(a.melissa_suite) like '#%'
       or   regexp_like(a.melissa_suite, '^[0-9]') 
       or   (length(a.melissa_suite) = 1 and regexp_like(a.melissa_suite, '^[:A-Z:]')) 
       or   upper(a.melissa_suite) like 'REAR %' -- distinguish from 'REAR'
       then
           cast(a.melissa_suite as nvarchar2(50))
       else
           null
    end as unit 
   ,case
       when upper(a.melissa_suite) like 'FRNT %' --distinguish from 'FRNT'
       or   upper(a.melissa_suite) like 'LBBY%'
       or   upper(a.melissa_suite) like 'OFC%'
       or   upper(a.melissa_suite) like 'RM%'
       then
           cast(a.melissa_suite as nvarchar2(50))
       else
           null
    end as room 
   ,cast(null as nvarchar2(50)) as seat
   ,cast(null as nvarchar2(50)) as created_by
   ,cast(null as date) as created_date
   ,cast(null as nvarchar2(50)) as modified_by
   ,cast(null as date) as modified_date
   ,cast(null as nvarchar2(1)) as boroughcode
   ,cast(null as timestamp(6)) as validation_date
   ,cast('USPS Melissa data' as nvarchar2(50)) as update_source
   ,cast(a.usps_hnum as nvarchar2(15)) as usps_hnum
from 
    subaddress_add a;
