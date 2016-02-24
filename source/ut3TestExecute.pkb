CREATE OR REPLACE PACKAGE BODY ut3TestExecute 
AS

  
  procedure ExecutePackageMethod(aPackageName IN VARCHAR2,
                                 aPackageMethod IN VARCHAR2)
  AS
    obj_data user_objects%ROWTYPE;
    stmt VARCHAR2(73);
    execute_stmt boolean := true; 
  BEGIN
    $IF $$ut3trace $THEN DBMS_OUTPUT.PUT_LINE('ut3Execute.ExecutePackageMethod'); $END
  
    IF execute_stmt THEN 
        stmt := 'BEGIN '  || trim(aPackageName) || '.' || trim(aPackageMethod) || '; END;';
        $IF $$ut3trace $THEN DBMS_OUTPUT.PUT_LINE('ExecutePackageMethod Stmt:' || Stmt); $END
        EXECUTE IMMEDIATE stmt;
    END IF;    
  END;
   
  procedure ExecutePackageTest(aTestToExecute IN ut3Types.SingleTest)
  AS
  BEGIN
    $IF $$ut3trace $THEN DBMS_OUTPUT.PUT_LINE('ExecutePackageTest ' || aTestToExecute.ObjectName || '.' || aTestToExecute.TestMethod); $END
    
    IF NOT ut3MetaData.packagevalid(aTestToExecute.ObjectName) THEN
       ut3Assert.report_error('Package does not exist or is Invalid: ' || nvl(aTestToExecute.ObjectName,'<Missing Package Name>'));
       return;
    END IF;
    
    IF NOT ut3MetaData.methodexists(aTestToExecute.ObjectName,aTestToExecute.SetupMethod) THEN
       ut3Assert.report_error('Package missing Setup method ' || aTestToExecute.ObjectName || '.' || nvl(aTestToExecute.SetupMethod,'<Missing Procedure Name>'));
       return;
    END IF;     

    IF NOT ut3MetaData.methodexists(aTestToExecute.ObjectName,aTestToExecute.TestMethod) THEN
       ut3Assert.report_error('Package missing Test method ' || aTestToExecute.ObjectName || '.' || nvl(aTestToExecute.TestMethod,'<Missing Procedure Name>'));
       return;
    END IF;     

    IF NOT ut3MetaData.methodexists(aTestToExecute.ObjectName,aTestToExecute.TeardownMethod) THEN
       ut3Assert.report_error('Package missing TearDown method ' || aTestToExecute.ObjectName || '.' || nvl(aTestToExecute.TeardownMethod,'<Missing Procedure Name>'));
       return;
    END IF;     


        
    ExecutePackageMethod(aTestToExecute.ObjectName,aTestToExecute.SetupMethod);
    BEGIN
       ExecutePackageMethod(aTestToExecute.ObjectName,aTestToExecute.TestMethod);
    EXCEPTION
      WHEN OTHERS THEN
        -- DBMS_UTILITY.FORMAT_ERROR_BACKTRACE is 10g or later
        -- UTL_CALL_STACK Package may be better but it's 12c but still need to investigate
        -- article with details: http://www.oracle.com/technetwork/issue-archive/2014/14-jan/o14plsql-2045346.html
       $IF $$ut3trace $THEN DBMS_OUTPUT.PUT_LINE('TestMethod Failed-' ||SQLERRM(SQLCODE) || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE); $END        
       ut3assert.report_error(SQLERRM(SQLCODE) || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
    END;
    ExecutePackageMethod(aTestToExecute.ObjectName,aTestToExecute.TearDownMethod);
  END ExecutePackageTest;
  
  
  procedure ExecuteObjectTest(aTestToExecute IN ut3Types.SingleTest)
  AS
  BEGIN

   -- Concept here is have a type that can be inherited from that allows test to be object types in addition to packages.
    NULL;
  END ExecuteObjectTest;                                                           
    
  
  PROCEDURE ExecuteTest (aTestToExecute IN ut3Types.SingleTest,
                         aTestResult    OUT ut3Types.TestExecution_Result)
  AS
  BEGIN     
     $IF $$ut3trace $THEN DBMS_OUTPUT.PUT_LINE('ut3Execute.ExecuteTest'); $END         
     aTestResult.Test := aTestToExecute;
     aTestResult.StartTime := CURRENT_TIMESTAMP;
     CASE aTestToExecute.TypeOfTest 
        WHEN ut3Types.TT_Package THEN ExecutePackageTest(aTestToExecute);
        WHEN ut3Types.TT_Object THEN ExecuteObjectTest(aTestToExecute);
     end case;
    aTestResult.EndTime := CURRENT_TIMESTAMP;
    aTestResult.AssertResults := ut3Types.AssertList();
    ut3assert.CopyAssertsCalledToNewTable(aTestResult.AssertResults);
    aTestResult.RESULT := ut3assert.CurrentAssertTestResult;
    ut3assert.ClearAsserts;    
            
  EXCEPTION
     WHEN OTHERS THEN
     BEGIN
        $IF $$ut3trace $THEN DBMS_OUTPUT.PUT_LINE('ExecuteTest Failed-' ||SQLERRM(SQLCODE) || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE); $END
        -- Most likely occured in setup or teardown if here.
        ut3assert.report_error(SQLERRM(SQLCODE) || ' ' || DBMS_UTILITY.FORMAT_ERROR_STACK); 
        ut3assert.report_error(SQLERRM(SQLCODE) || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE); 
        ut3assert.CopyAssertsCalledToNewTable(aTestResult.AssertResults);
        ut3assert.ClearAsserts;
        aTestResult.Result := ut3Types.TR_Error;
     END;   
        
  END ExecuteTest;
END ut3TestExecute;
/