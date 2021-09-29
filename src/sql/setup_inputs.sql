-- load melissa data columns into this load table
-- this is a good practice because letting your loader (like Arccatalog)
-- choose column type definitions can be bad
-- ArcCatalog tends to load based on the first row, even ignoring
-- columns where nulls are in the first row
create table melissa_geocoded_a (
     addresspointid     number
    ,suite              varchar2(256)
    ,f1_normalized_hn   varchar2(15)
);