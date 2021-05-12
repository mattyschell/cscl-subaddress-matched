# cscl-subaddress-matched

The Citywide Street Centerline (CSCL) database "subaddress" table contains unit addresses associated with an address point.  Emergency response systems, geocoders, and address validators use subaddresses.

The New York City Dept. of City Planning periodically geocodes 
[Melissa](https://www.melissa.com/company/about) address data to CSCL address points.  When Melissa addresses are not matched in the database humans slog through the data and make updates to addresses and subaddresses.

When Melissa addresses are matched to CSCL database addresses we perform a bulk update of CSCL subaddresses using the Melissa unit addresses.  For one matched address, Melissa unit addresses may:

* Match an existing CSCL subaddress record.  Keep these CSCL subaddresses.
* Not match an existing CSCL subaddress record.  Add these unit addresses.

Any remaining unmatched CSCL subaddresses for the address should be deleted. 


# Steps

## 1. Set up objects in the scratch database schema

```
sqlplus devschema/"iluvesri247"@devdb @src/sql/setup.sql 
```

## 2. Load the cscl.subaddress table into the same database schema

This source table is registered with the geodatabase but is non-spatial, no archiving, no editor tracking.  There is a versioned view for SQL access.

Script something here later, use ArcCatalog now.

## 3. Load the melissa_geocoded_addresses.csv in the same schema 

Using ArcCatalog (4 million records) takes ~2.5 hours.

## 4. Insert relevant data into subaddress_src and melissa_geocoded_src

```
sqlplus devschema/"iluvesri247"@devdb @src/sql/insert_source.sql 
```

## 5. Execute the subaddress_delta procedure

Outputs populated:

* subaddress_delete
* subaddress_add

## 6. Load the 2 output tables into CSCL

## 7. Delete and Add TBD


Some notes on target CSCL.subaddress:

1. Though sub_address_id is intended to be unique there is no constraint in the CSCL database. So this must be enforced in the work tables of this repository

2. Though there is intended to be a foreign key relationship between CSCL.subaddress and CSCL.address_point this is not enforced.  This repository should check subaddress_add to ensure valid address point ids before adding records to the unconstrained target CSCL.subaddress table.

3. Users expect the sub_address_id to be the unique, maintained business key for a subaddress record.  However the combination of a subaddress ap_id and melissa_suite uniquely identifies any subaddress.  This unique composite key should also be enforced in this repository.

## Tests

Update the environmentals in test.bat
```bat
> test.bat
```

## Schema

![schema diagram png](https://github.com/mattyschell/cscl-subaddress-matched/blob/main/doc/schema.png?raw=true)

![test schema diagram png](https://github.com/mattyschell/cscl-subaddress-matched/blob/main/doc/test_schema.png?raw=true)






 