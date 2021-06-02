delete from subaddress_src;
commit;
-- test1: basic address with no updates
INSERT INTO subaddress_src
(OBJECTID, SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, ADDITIONAL_LOC_INFO, BUILDING, FLOOR, UNIT, ROOM, SEAT, CREATED_BY, CREATED_DATE, MODIFIED_BY, MODIFIED_DATE, GLOBALID, BOROUGHCODE, VALIDATION_DATE, UPDATE_SOURCE, USPS_HNUM)
VALUES(415433, 415433, 'APT 3', 3006230, NULL, NULL, NULL, 'APT 3', NULL, NULL, NULL, NULL, NULL, NULL, '{7C0AC2E2-089F-42F4-871B-EA35233AC142}', '3', NULL, NULL, NULL);
INSERT INTO subaddress_src
(OBJECTID, SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, ADDITIONAL_LOC_INFO, BUILDING, FLOOR, UNIT, ROOM, SEAT, CREATED_BY, CREATED_DATE, MODIFIED_BY, MODIFIED_DATE, GLOBALID, BOROUGHCODE, VALIDATION_DATE, UPDATE_SOURCE, USPS_HNUM)
VALUES(751227, 751227, 'APT 1', 3006230, NULL, NULL, NULL, 'APT 1', NULL, NULL, NULL, NULL, NULL, NULL, '{E6B91B19-94B3-49DD-B821-A8077BC9C96A}', '3', NULL, NULL, NULL);
INSERT INTO subaddress_src
(OBJECTID, SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, ADDITIONAL_LOC_INFO, BUILDING, FLOOR, UNIT, ROOM, SEAT, CREATED_BY, CREATED_DATE, MODIFIED_BY, MODIFIED_DATE, GLOBALID, BOROUGHCODE, VALIDATION_DATE, UPDATE_SOURCE, USPS_HNUM)
VALUES(751228, 751228, 'BSMT', 3006230, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{ABB3A520-AD57-46D6-A31E-FCC0C3A093CB}', '3', NULL, NULL, NULL);
INSERT INTO subaddress_src
(OBJECTID, SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, ADDITIONAL_LOC_INFO, BUILDING, FLOOR, UNIT, ROOM, SEAT, CREATED_BY, CREATED_DATE, MODIFIED_BY, MODIFIED_DATE, GLOBALID, BOROUGHCODE, VALIDATION_DATE, UPDATE_SOURCE, USPS_HNUM)
VALUES(1793472, 1793472, 'APT 2', 3006230, NULL, NULL, NULL, 'APT 2', NULL, NULL, NULL, NULL, NULL, NULL, '{DB13F16F-4A8A-4AD2-8CFB-5F1B436A32C4}', '3', NULL, NULL, NULL);
-- test 2: force refresh of sub address id 1 and any other subaddresses on the address point
-- sub address 2 on the same address point should also be deleted
INSERT INTO subaddress_src
(OBJECTID, SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, ADDITIONAL_LOC_INFO, BUILDING, FLOOR, UNIT, ROOM, SEAT, CREATED_BY, CREATED_DATE, MODIFIED_BY, MODIFIED_DATE, GLOBALID, BOROUGHCODE, VALIDATION_DATE, UPDATE_SOURCE, USPS_HNUM)
VALUES(1742694, 1, 'RM 1002', 1018320, NULL, NULL, NULL, NULL, 'RM 1002', NULL, NULL, NULL, NULL, NULL, '{5EAECFFF-5F35-44A3-8492-3DBB8401FD25}', '1', NULL, NULL, NULL);
INSERT INTO subaddress_src
(OBJECTID, SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, ADDITIONAL_LOC_INFO, BUILDING, FLOOR, UNIT, ROOM, SEAT, CREATED_BY, CREATED_DATE, MODIFIED_BY, MODIFIED_DATE, GLOBALID, BOROUGHCODE, VALIDATION_DATE, UPDATE_SOURCE, USPS_HNUM)
VALUES(1742695, 2, 'RM 1008', 1018320, NULL, NULL, NULL, NULL, 'RM 1008', NULL, NULL, NULL, NULL, NULL, '{1F9132C8-A773-491D-A70B-8DA4B6E764FE}', '1', NULL, NULL, NULL);
-- test 3: Add a single missing subaddress
INSERT INTO subaddress_src
(OBJECTID, SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, ADDITIONAL_LOC_INFO, BUILDING, FLOOR, UNIT, ROOM, SEAT, CREATED_BY, CREATED_DATE, MODIFIED_BY, MODIFIED_DATE, GLOBALID, BOROUGHCODE, VALIDATION_DATE, UPDATE_SOURCE, USPS_HNUM)
VALUES(1,3,'Apt 3', 3, NULL, NULL, NULL, NULL, 'Apt 3', NULL, NULL, NULL, NULL, NULL, '{' || REGEXP_REPLACE(SYS_GUID(), '(.{8})(.{4})(.{4})(.{4})(.{12})', '\1-\2-\3-\4-\5') || '}', NULL, NULL, NULL, 100);
-- test 10: 2 subaddreses exist on addresspoint 12, keep APT 1, remove bsmt, add APT 2
INSERT INTO subaddress_src
(OBJECTID, SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, ADDITIONAL_LOC_INFO, BUILDING, FLOOR, UNIT, ROOM, SEAT, CREATED_BY, CREATED_DATE, MODIFIED_BY, MODIFIED_DATE, GLOBALID, BOROUGHCODE, VALIDATION_DATE, UPDATE_SOURCE, USPS_HNUM)
VALUES(2,4,'BSMT', 12, NULL, NULL, 'BSMT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{' || REGEXP_REPLACE(SYS_GUID(), '(.{8})(.{4})(.{4})(.{4})(.{12})', '\1-\2-\3-\4-\5') || '}', NULL, NULL, NULL, 100);
INSERT INTO subaddress_src
(OBJECTID, SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, ADDITIONAL_LOC_INFO, BUILDING, FLOOR, UNIT, ROOM, SEAT, CREATED_BY, CREATED_DATE, MODIFIED_BY, MODIFIED_DATE, GLOBALID, BOROUGHCODE, VALIDATION_DATE, UPDATE_SOURCE, USPS_HNUM)
VALUES(3,5,'APT 1', 12, NULL, NULL, NULL, 'APT 1', NULL, NULL, NULL, NULL, NULL, NULL, '{' || REGEXP_REPLACE(SYS_GUID(), '(.{8})(.{4})(.{4})(.{4})(.{12})', '\1-\2-\3-\4-\5') || '}', NULL, NULL, NULL, 100);
--
commit;