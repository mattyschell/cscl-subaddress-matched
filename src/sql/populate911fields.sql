-- Update the nextgen911 compartmentalized info fields based on suite
-- This update statement is based on spreadsheets and info from colleagues
-- I searched github and could not find anyone else having written this? strange
update 
    subaddress_add a 
set
    a.unit = case
                 when upper(a.melissa_suite) like 'APT%'
                 or   upper(a.melissa_suite) like 'PH%'
                 or   upper(a.melissa_suite) like 'SPC%'
                 or   upper(a.melissa_suite) like 'STE%'
                 or   upper(a.melissa_suite) like 'UNIT%'
                 or   regexp_like(a.melissa_suite, '^[0-9]') -- todo test # + Designator
                 or   (length(a.melissa_suite) = 1 and regexp_like(a.melissa_suite, '^[:alpha:]')) -- todo test "single letter desig"
                 then
                     a.melissa_suite
                 else
                     null
             end
   ,a.floor = case
                  when upper(a.melissa_suite) like 'BSMT%'
                  or   upper(a.melissa_suite) like 'FL%'
                  or   upper(a.melissa_suite) like 'LOWR%'
                  or   upper(a.melissa_suite) like 'UPPR%'
                  then
                      a.melissa_suite
                  else
                      null
              end
   ,a.room = case
                 when upper(a.melissa_suite) like 'FRNT %' --distinguish from 'FRNT'
                 or   upper(a.melissa_suite) like 'LBBY%'
                 or   upper(a.melissa_suite) like 'OFC%'
                 or   upper(a.melissa_suite) like 'RM%'
                 then
                     a.melissa_suite
                 else
                    null
             end  
   ,a.building = case
                     when upper(a.melissa_suite) = 'BLDG'
                     then
                         a.melissa_suite
                     else
                         null
                 end        
   ,a.additional_loc_info =
             case 
                 when upper(a.melissa_suite) = 'FRNT'
                 or   upper(a.melissa_suite) like 'REAR%'
                 or   upper(a.melissa_suite) like 'SIDE%'
                 or   upper(a.melissa_suite) like 'DEPT%'
                 then
                     a.melissa_suite
                 else
                     null
             end;
commit;
                
    
              
  