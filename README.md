# cscl-subaddress-matched

The New York City Citywide Street Centerline (CSCL) database "subaddress" table 
contains unit addresses (aka subaddresses) associated with an address point.  
New York City emergency response systems, geocoders, and address validators use 
subaddresses.  Friends, this is our repository for updating subaddresses, our 
logic, the trick is to never be afraid.

The New York City Dept. of City Planning annually geocodes commercial subaddress 
data to CSCL address points.  When the commercial addresses are not in the CSCL 
database humans slog through the data and make updates to addresses and 
subaddresses as necessary.

When commerical addresses do match CSCL database addresses we perform a bulk 
update of CSCL subaddresses using the commercial subaddresses.  For a matched 
address, an associated commercial subaddress may:

* Match an existing CSCL subaddress record.  Do nothing.
* Not match an existing CSCL subaddress record.  Add this commercial subaddress.

Any remaining existing CSCL subaddresses that did not match commerical 
subaddresses for the matched address should be deleted. 

## 1. Load the cscl.subaddress table into a database schema 

Load as a table named SUBADDRESS.  Using ArcCatalog ensures that database types 
are not changed. Expect this to require between 30 and 60 minutes.

The source table is registered with the ESRI geodatabase but is non-spatial with 
no archiving, no editor tracking, and almost no manual editing.  There is no 
versioned view allowing SQL access.

## 2. Load the enhanced csv in the same schema 

Create an empty MELISSA_GEOCODED_A table. 

```
sqlplus devschema/"iluvesri247"@devdb @src/sql/setup_inputs.sql 
```

Convert the enhanced third party csv file to SQL insert statements.  This code 
assumes column naming conventions and reads and writes to the current working 
directory, it is not fancy.

Beware that the documentation and file names delivered to us may be incorrect. 
Input the csv with duplicate addresses and suite values populated, the big one.

```
C:\Progra~1\ArcGIS\Pro\bin\Python\scripts\propy.bat .\src\py\inputconverter.py C:\Temp\melissadata_geocoding_2020\melissa_geocoded_addresses.csv
```

Load MELISSA_GEOCODED_A.  This should finish in approximately 1 hour.

```
sqlplus devschema/"iluvesri247"@devdb @melissa_geocoded_a.sql 
```

## 1. and 2. Check 

Best to check the load steps above to be sure we are getting the expected data and types.  Execute this while the load is running for peace of mind.

```
sqlplus devschema/"iluvesri247"@devdb @src/sql/input_check.sql 
```

## 3. Feeling Lucky?  

Run non-optional parts of step 3 with run.bat. 

### 3a. Set up work tables and objects 

```
sqlplus devschema/"iluvesri247"@devdb @src/sql/setup.sql 
```

### 3b. (optional) Add IDs to subaddress_delete to force their replacement

 Sometimes we force replacement of existing subaddresses with the latest commerical data.  A typical motivation is legacy subaddresses without house numbers so they can't be uniquely identified.  We can replace all subaddresses on an address point by adding their sub_address_ids to subaddress_delete prior to running the next step.

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
     
These outputs are ready to be deliverd to the CSCL managers to delete and insert records in the target environment. Perform the delete first.


## Some notes on target CSCL.subaddress:

1. Though sub_address_id is intended to be unique there is no constraint in the CSCL database. This key is maintained externally by CSCL data managers.

2. Though there is intended to be a one-to-many foreign key relationship between CSCL.address_point and CSCL.subaddress this is not enforced. When loading to CSCL we ought to check subaddress_add to ensure valid address point ids before adding new records to the unconstrained target CSCL.subaddress table.

3. Users expect the sub_address_id to be the unique, maintained business key for a subaddress record.  However the combination of a subaddress ap_id (address point id), melissa_suite, and usps_hnum (house number) uniquely identifies any subaddress and matches it to commercial records.  This unique composite key will be enforced in outputs from this repository.

## Tests

Update the environmentals in test.bat
```bat
> test.bat
```

## Schema

![schema diagram png](https://github.com/mattyschell/cscl-subaddress-matched/blob/main/doc/schema.png?raw=true)

![test schema diagram png](https://github.com/mattyschell/cscl-subaddress-matched/blob/main/doc/test_schema.png?raw=true)






 