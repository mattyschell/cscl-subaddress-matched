# cscl-subaddress-matched

The New York City Citywide Street Centerline (CSCL) database "subaddress" table contains unit addresses associated with an address point.  Emergency response systems, geocoders, and address validators use subaddresses.

The New York City Dept. of City Planning periodically geocodes third party address data to CSCL address points.  When addresses are not matched in the database humans slog through the data and make updates to addresses and subaddresses.

When addresses do match CSCL database addresses we perform a bulk update of CSCL subaddresses using the third party unit addresses.  For one matched address, a third party unit address may:

* Match an existing CSCL subaddress record.  Keep these CSCL subaddresses.
* Not match an existing CSCL subaddress record.  Add these subaddresses.

Any remaining existing CSCL subaddresses that did not match third party subaddresses for the address should be deleted. 


## 1. Load the cscl.subaddress table into a database schema 

Load as a table named SUBADDRESS.  

This source table is registered with the ESRI geodatabase but is non-spatial with no archiving, no editor tracking, and no daily editing.  A versioned view with SQL access exists in some environments.

Arcatalog table-to-table takes anywhere from 30 minutes to multiple hours depending on source and target.

## 2. Load the melissa_geocoded_addresses.csv in the same schema 

Load as a table named MELISSA_GEOCODED_A.

Using ArcCatalog to load 4 million records will likely require many hours. 

## 1. and 2. Check 

Best to check the load steps above to be sure we are getting the expected data and types.  Run this while the load is running for peace of mind.

```
sqlplus devschema/"iluvesri247"@devdb @src/sql/input_check.sql 
```

## 3. Feeling Lucky?  

Run non-optional parts of step 3 with run.bat. 

### 3a. Set up work tables and objects 

```
sqlplus devschema/"iluvesri247"@devdb @src/sql/setup.sql 
```

### 3b. (optional) Add any records to subaddress_delete to force their replacement

 Sometimes we force replacement of existing subaddresses with the latest Melissa data.  A typical motivation is older subaddresses without house numbers that can't be uniquely identified.  We can replace all subaddresses on an address point by adding their sub_address_ids to subaddress_delete prior to running the next step.

### 3c. Insert relevant loaded data into subaddress_src and melissa_geocoded_src

```
sqlplus devschema/"iluvesri247"@devdb @src/sql/insert_source.sql 
```

### 3d. Populate the output tables

Output tracks the [NG911 data model](https://www.nena.org/page/NG911GISDataModel)

```
sqlplus devschema/"iluvesri247"@devdb @src/sql/forcerefresh.sql 
sqlplus devschema/"iluvesri247"@devdb @@src/sql/delta.sql 
```

Database Outputs:

* subaddress_delete
* subaddress_add_vw (view on subaddress_add)

### 3e. Export To File Geodatabase

```
SET SDEFILE=C:\gis\connections\devschema.sde
python.exe .\src\py\export.py
```

* cscl-subaddress-matched.gdb
     * SUBADDRESS_DELETE
     * SUBADDRESS_ADD
     
These outputs are ready to delete and insert records in the target CSCL environment. Perform the delete first.



## Some notes on target CSCL.subaddress:

1. Though sub_address_id is intended to be unique there is no constraint in the CSCL database. This key is maintained externally by CSCL data managers.

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






 