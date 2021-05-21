CREATE OR REPLACE PACKAGE CSCL_SUBADDRESS
AUTHID CURRENT_USER
AS

    PROCEDURE INIT_SUBADDRESS_ADDSEQ (
        p_nextval       IN NUMBER
    );

    FUNCTION SUBADDRESS_NEXT_ID
    RETURN NUMBER;    
    
END CSCL_SUBADDRESS;
/

CREATE OR REPLACE PACKAGE BODY CSCL_SUBADDRESS
AS

    PROCEDURE INIT_SUBADDRESS_ADDSEQ (
        p_nextval       IN NUMBER
    ) AS

        psql            VARCHAR2(4000);
        seqval          NUMBER;

    BEGIN

        psql := 'select subaddress_addseq.nextval from dual';
        execute immediate psql into seqval;

        seqval := p_nextval - seqval;

        dbms_output.put_line(seqval);

        psql := 'alter sequence subaddress_addseq increment by ' || seqval;
        execute immediate psql;

        psql := 'select subaddress_addseq.nextval from dual';
        execute immediate psql into seqval;

        psql := 'alter sequence subaddress_addseq increment by 1';
        execute immediate psql;

    END INIT_SUBADDRESS_ADDSEQ;

    FUNCTION SUBADDRESS_NEXT_ID
    RETURN NUMBER
    AS

        output      number;
        psql        varchar2(4000);

    BEGIN

        psql := 'select max(ap_id) + 1 from subaddress_src';
        EXECUTE IMMEDIATE psql INTO OUTPUT;

        RETURN output;

    END;
       

END CSCL_SUBADDRESS;
/
