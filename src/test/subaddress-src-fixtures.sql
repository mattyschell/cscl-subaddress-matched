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
VALUES(3,'Apt 3', 3,  100);
-- test 10: 2 subaddreses exist on addresspoint 12, keep APT 1, remove bsmt, add APT 2
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(4,'BSMT', 12, 100);
INSERT INTO subaddress_src
(SUB_ADDRESS_ID, MELISSA_SUITE, AP_ID, USPS_HNUM)
VALUES(5,'APT 1', 12, 100);
--
commit;