import pandas 
import os
import sys
import csv


class csvconverter(object):

    def __init__(self
                ,melissa_geocoded_a_csv
                ,usesqlplus='Y'):

        self.usesqlplus = usesqlplus

        if os.path.isfile(melissa_geocoded_a_csv):
            self.csv = melissa_geocoded_a_csv
        else:
            raise ValueError('check {0}'.format(melissa_geocoded_a_csv))

        # column names should not change
        self.column1 = 'addresspointid'
        self.column2 = 'suite'
        self.column3 = 'f1_normalized_hn'

        # tune for performance, this should be fine
        self.commitinterval = 50000
    
    def prunecolumns(self
                    ,melissa_geocoded_a_pruned):

        # writes out a smaller csv with just 3 columns

        if os.path.exists(melissa_geocoded_a_pruned):
            os.remove(melissa_geocoded_a_pruned)

        cols = [self.column1, self.column2, self.column3]

        df_a = pandas.read_csv(self.csv
                              ,usecols=cols)

        df_a.to_csv(melissa_geocoded_a_pruned
                    ,columns=cols
                    ,index=False
                    ,header=False)

        self.prunedcsv = melissa_geocoded_a_pruned

    def writesql(self
                ,melissa_geocoded_a_sql):

        # converts smaller csv to sql insert statements
        # we want everything even nulls
        # what we choose to use after loading to the database is not all of this

        i = 0

        with open(self.prunedcsv, newline='') as prunedcsvfile, \
             open(melissa_geocoded_a_sql, 'w') as sql:
            
            prunedcsvreader = csv.reader(prunedcsvfile, delimiter=',') 

            if self.usesqlplus == 'Y':

                sql.write('SET HEADING OFF {0}'.format('\n'))
                sql.write('SET FEEDBACK OFF {0}'.format('\n'))
                sql.write('SET ECHO OFF {0}'.format('\n'))
                sql.write('SET TERMOUT OFF {0}'.format('\n'))
            
            for row in prunedcsvreader:
                
                i += 1

                if len(row[0]) == 0:
                    addresspointid = 'NULL'
                else:
                    addresspointid = row[0]

                sql.write("""insert into melissa_geocoded_a """ \
                        + """values({0},'{1}','{2}');{3}""".format(addresspointid
                                                                  ,row[1]
                                                                  ,row[2]
                                                                  ,'\n'))    
                if (i%self.commitinterval) == 0:
                    sql.write("""commit;{0}""".format('\n'))    

            sql.write("""commit;{0}""".format('\n'))
            sql.write("""{0}""".format('\n'))
            
if __name__ == '__main__':

    psourcecsv = sys.argv[1]

    addresses = csvconverter(psourcecsv)

    prunedcsv  = os.path.join(os.getcwd(),'pruned.csv')
    try:
        os.remove(prunedcsv)
    except OSError:
        pass

    # write junk pruned csv
    # 3 columns, nulls allowed
    addresses.prunecolumns(prunedcsv)

    melissa_geocoded_a_sql  = os.path.join(os.getcwd(),'melissa_geocoded_a.sql')
    
    try:
        os.remove(melissa_geocoded_a_sql)
    except OSError:
        pass

    addresses.writesql(melissa_geocoded_a_sql)

