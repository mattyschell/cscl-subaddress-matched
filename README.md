# cscl-subaddress-matched

The Citywide Street Centerline (CSCL) database "subaddress" table contains
unit addresses associated with an address point.  Emergency response systems, 
geocoders, and address validators use subaddresses.

The New York City Dept. of City Planning periodically geocodes 
[Melissa](https://www.melissa.com/company/about) address data to CSCL address
points.  When Melissa addresses are not matched in CSCL editors slog through the data and make updates.

When Melissa addresses are matched to CSCL addresses we perform a bulk update of CSCL subaddresses using the Melissa unit addresses.  For one matched address, Melissa unit addresses may:

* Match an existing CSCL subaddress record.  Keep these CSCL subaddresses.
* Not match an existing CSCL subaddress record.  Add these unit addresses.

Any remaining unmatched CSCL subaddresses for the address should be deleted. 


# Steps

## 1. Load the cscl.subaddress table into a scratch database schema

## 2. Load the melissa_geocoded_addresses.csv in the same schema 

Using ArcCatalog (4 million records) takes ~2.5 hours.

## 3. Execute the subaddress_delta procedure

Outputs:

* subaddress_delete
* subaddress_add

## 4. Load the outputs into CSCL

## 5. Delete and Add TBD


Some notes on target CSCL.subaddress:

    * Though sub_address_id is intended to be unique there is no constraint in the CSCL database. So this must be enforced in the work tables of this repository

    * Though there is intended to be a foreign key relationship between CSCL.subaddress and CSCL.address_point this is not enforced.  This repository 
    should check subaddress_add to ensure valid address point ids before adding records to the unconstrained target CSCL.subaddress table.

    * Users expect the sub_address_id to be the unique, maintained business key for a subaddress record.  However the combination of a subaddress ap_id and melissa_suite uniquely identifies any subaddress.  This unique composite key should also be enforced in this repository.

## Tests

Update the environmentals in testall.bat
```bat
> testall.bat
```



 