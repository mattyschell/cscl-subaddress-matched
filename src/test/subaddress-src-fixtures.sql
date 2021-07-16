-- These are fake, testing inputs as if from CSCL
-- They will be added to and deleted from based on testing inputs
delete from subaddress_src;
commit;
-- test1: basic address with no updates
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(415433, 'APT 3', 3006230, NULL);
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(751227, 'APT 1', 3006230, NULL);
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(751228, 'BSMT', 3006230, NULL);
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(1793472, 'APT 2', 3006230, NULL);
-- test 2: force refresh of sub address id 1 and any other subaddresses on the address point
-- sub address 2 on the same address point should also be deleted
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(1, 'RM 1002', 1018320, NULL);
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(2, 'RM 1008', 1018320, NULL);
-- test 3: Add a single missing subaddress
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(3,'APT 3', 3,  100);
-- test 10: 2 subaddreses exist on addresspoint 12, keep APT 1, remove bsmt, add APT 2
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(4,'BSMT', 12, NULL);
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(5,'APT 1', 12, NULL);
-- test 12: ranged address, force delete, sample copied directly from 
-- https://github.com/mattyschell/cscl-subaddress-matched/issues/4
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(6,'APT 1', 999, NULL);
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(7,'APT 2', 999, NULL);
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(8,'APT 1', 999, NULL);
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(9,'APT 2', 999, NULL);
-- test 13: https://github.com/mattyschell/cscl-subaddress-matched/issues/11
-- delete subaddresses when geocoded melissa data indicates none exist
-- test 13 will delete this single subaddress
-- this subaddress should appear in the delete output table
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(10,'APT 1', 13, NULL);
-- test 14: https://github.com/mattyschell/cscl-subaddress-matched/issues/11
-- same as 13 but should delete multiple subaddresses
-- these 3 subaddresses should appear in the delete output table
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(11,'APT 1', 14, NULL);
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(12,'APT 2', 14, NULL);
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(13,'APT 3', 14, NULL);
commit;