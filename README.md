# cscl-subaddress-matched

The New York City Citywide Street Centerline (CSCL) database "subaddress" table contains unit addresses associated with an address point.  Emergency response systems, geocoders, and address validators use subaddresses.

The New York City Dept. of City Planning periodically geocodes 
[Melissa](https://www.melissa.com/company/about) address data to CSCL address points.  When Melissa addresses are not matched in the database humans slog through the data and make updates to addresses and subaddresses.

When Melissa addresses do match CSCL database addresses we perform a bulk update of CSCL subaddresses using the Melissa unit addresses.  For one matched address, a Melissa unit address may:

* Match an existing CSCL subaddress record.  Keep these CSCL subaddresses.
* Not match an existing CSCL subaddress record.  Add these subaddresses.

Any remaining existing CSCL subaddresses that did not match Melissa subaddresses for the address should be deleted. 


# Steps

## 1. Load the cscl.subaddress table into the same database schema

This source table is registered with the geodatabase but is non-spatial with no archiving, no editor tracking, and no daily editing.  A versioned view exists.

Load as a table named SUBADDRESS.  Arcatalog table to table takes roughly 30 minutes.

## 2. Load the melissa_geocoded_addresses.csv in the same schema 

Using ArcCatalog to load 4 million records may require several hours.

Load as a table named MELISSA_GEOCODED_A.

## 3. (optional) Add any records to subaddress_delete to force their replacement

 Sometimes we force replace existing subaddresses with the latest Melissa data.  An example is older subaddresses without house numbers that can't be uniquely identified.  We can replace all subaddresses on an address point by adding their sub_address_ids to subaddress_delete prior to running the next step.

## 4. Feeling Lucky? Run steps 

Run step 4 using run.bat 

### 4a. Set up objects in a scratch database (Oracle, presently) schema 

```
sqlplus devschema/"iluvesri247"@devdb @src/sql/setup.sql 
```

### 4b. Insert relevant data into subaddress_src and melissa_geocoded_src

```
sqlplus devschema/"iluvesri247"@devdb @src/sql/insert_source.sql 
```

### 4c. Populate the output tables

```
sqlplus devschema/"iluvesri247"@devdb @run.sql 
```

Outputs populated:

* subaddress_delete
* subaddress_add

These output tables are ready to delete and insert records in the target CSCL
environment. Perform the delete first.

## Some notes on target CSCL.subaddress:

1. Though sub_address_id is intended to be unique there is no constraint in the CSCL database. So this must be enforced in the work tables of this repository

2. Though there is intended to be a one-to-many foreign key relationship between CSCL.address_point and CSCL.subaddress this is not enforced. When loading to CSCL we should check subaddress_add to ensure valid address point ids before adding new records to the unconstrained target CSCL.subaddress table.

3. Users expect the sub_address_id to be the unique, maintained business key for a subaddress record.  However the combination of a subaddress ap_id (address point id), melissa_suite, and usps_hnum (house number) uniquely identifies any subaddress and matches it to Melissa records.  This unique composite key must be enforced in this repository.

## Tests

Update the environmentals in test.bat
```bat
> test.bat
```

## Schema

![schema diagram png](https://github.com/mattyschell/cscl-subaddress-matched/blob/main/doc/schema.png?raw=true)

![test schema diagram png](https://github.com/mattyschell/cscl-subaddress-matched/blob/main/doc/test_schema.png?raw=true)






 