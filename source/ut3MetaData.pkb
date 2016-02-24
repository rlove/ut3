CREATE OR REPLACE PACKAGE BODY ut3MetaData 
AS
  function packagevalid(aPackageName in VARCHAR2) return boolean
  AS
    v_cnt INTEGER;
  begin
    select 
        count(*) into v_cnt
    from
        user_objects
    where
        upper(object_name) = upper(aPackageName)
        and object_type in ('PACKAGE','PACKAGE BODY')
        and STATUS = 'VALID';
    -- Expect both package and body to be valid
    RETURN v_cnt = 2;    
  end;
  
  function methodexists(aPackageName in VARCHAR2,
                        aPackageMethod IN VARCHAR2) return boolean
  as
    v_cnt INTEGER;
  begin
    select 
        count(*) into v_cnt 
    from 
        user_procedures
    where 
        upper(object_name) = upper(aPackageName)
        and upper(procedure_name) = upper(aPackageMethod);
    --Expect one method only for the package with that name.
    return v_cnt = 1;
  end;                      
end;  