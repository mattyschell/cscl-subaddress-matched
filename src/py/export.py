import os
import arcpy

def main(sourcesdeconn
        ,fgdbdir):


    outgdb = os.path.join(fgdbdir
                         ,"cscl-subaddress-matched.gdb")

    if os.path.isdir(outgdb):

        arcpy.management.Delete(outgdb)

    arcpy.CreateFileGDB_management(fgdbdir, "cscl-subaddress-matched.gdb")

    arcpy.TableToTable_conversion(os.path.join(sourcesdeconn, "SUBADDRESS_DELETE")
                                 ,outgdb
                                 ,"SUBADDRESS_DELETE")

    arcpy.TableToTable_conversion(os.path.join(sourcesdeconn, "SUBADDRESS_ADD_VW")
                                 ,outgdb
                                 ,"SUBADDRESS_ADD")
    
    return 0

if __name__ == '__main__':

    psourcesdeconn = os.environ['SDEFILE']
    cwd = os.getcwd()

    retval = main(psourcesdeconn
                 ,cwd)

    exit(retval)    

