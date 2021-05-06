# cscl-subaddress-matched

The Citywide Street Centerline (CSCL) database "subaddress" table contains unit addresses associated with an address point.  Emergency response systems, geocoders, and address validators use subaddresses.

The New York City Dept. of City Planning periodically geocodes 
[Melissa](https://www.melissa.com/company/about) address data to CSCL address points.  When Melissa addresses are not matched in CSCL editors slog through the data and make updates.

When Melissa addresses are matched to CSCL addresses we perform a bulk update of CSCL subaddresses using the Melissa unit addresses.  For one matched address, Melissa unit addresses may:

* Match an existing CSCL subaddress record.  Keep these CSCL subaddresses.
* Not match an existing CSCL subaddress record.  Add these unit addresses.

Any remaining unmatched CSCL subaddresses for the address should be deleted. 

    TODO: What does it mean when the suite from melissa is NULL?

Case 1, probably ignore that 6th row:

| ADDRESS       | SUITE  | ADDRESSPOINTID |
| --------------|--------|----------------|
| 10102 95th Ave| Apt 1F |         219181 |
| 10102 95th Ave| Apt 1R |         219181 |
| 10102 95th Ave| Apt 2A |         219181 |
| 10102 95th Ave| Apt 2F |         219181 |
| 10102 95th Ave| Apt 2R |         219181 |
| 10102 95th Ave| NULL   |         219181 |

Case 2, does this mean delete any subaddresses associated with this address, if subaddresses exist?  This is the only record for the address.

| ADDRESS               | SUITE | ADDRESSPOINTID |
|-----------------------|-------|----------------|
| 1506 Commonwealth Ave |       |        2044259 | 


# Steps

## 1. Set up objects in the scratch database schema

```
sqlplus devschema/"iluvesri247"@devdb @src/sql/setup.sql 
```

## 2. Load the cscl.subaddress table into a scratch database schema

This table is registered with the geodatabase but is non-spatial, no archiving, no editor tracking.  There is a versioned view for SQL access.

Script something here later, use ArcCatalog now.

## 3. Load the melissa_geocoded_addresses.csv in the same schema 

Using ArcCatalog (4 million records) takes ~2.5 hours.

## 4. Insert relevant data into subaddress_source and melissa_geocoded_source

```
sqlplus devschema/"iluvesri247"@devdb @src/sql/insert_source.sql 
```

## 5. Execute the subaddress_delta procedure

Outputs:

* subaddress_delete
* subaddress_add

## 6. Load the 2 output tables into CSCL

## 7. Delete and Add TBD


Some notes on target CSCL.subaddress:

1. Though sub_address_id is intended to be unique there is no constraint in the CSCL database. So this must be enforced in the work tables of this repository

2. Though there is intended to be a foreign key relationship between CSCL.subaddress and CSCL.address_point this is not enforced.  This repository should check subaddress_add to ensure valid address point ids before adding records to the unconstrained target CSCL.subaddress table.

3. Users expect the sub_address_id to be the unique, maintained business key for a subaddress record.  However the combination of a subaddress ap_id and melissa_suite uniquely identifies any subaddress.  This unique composite key should also be enforced in this repository.

## Tests

Update the environmentals in testall.bat
```bat
> testall.bat
```



 