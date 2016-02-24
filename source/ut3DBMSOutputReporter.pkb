CREATE OR REPLACE PACKAGE BODY ut3DBMSOutputReporter
AS
  c_dashedline VARCHAR2(80) := 
'------------------------------------------------------------------------------';

  PROCEDURE begin_suite (aSuite IN ut3Types.TestSuite)
  AS
  BEGIN
    DBMS_Output.PUT_LINE(c_dashedline);
    DBMS_Output.PUT_LINE('Suite "' || nvl(aSuite.suiteName,'') || '" Started.');
  END;
  
  PROCEDURE end_suite (aSuite IN ut3Types.TestSuite, aResults IN ut3Types.TestSuiteResults)
  AS
  BEGIN
    --TODO: Report total suite result here with pretty message
    DBMS_Output.PUT_LINE(c_dashedline);   
    DBMS_Output.PUT_LINE('Suite "' || nvl(aSuite.suiteName,'') || '" Ended.');
    DBMS_Output.PUT_LINE(c_dashedline);      
  END;  
  
  PROCEDURE begin_test(aTest IN ut3Types.SingleTest,aInSuite in boolean)
  AS
  BEGIN
    NULL;
  END;  
  
  PROCEDURE end_test(aTest IN ut3Types.SingleTest, aResult UT3TYPES.TestExecution_Result,aInSuite in boolean)
  AS
  BEGIN
    DBMS_Output.PUT_LINE(c_dashedline);
    DBMS_Output.PUT_LINE('Test  ' || nvl(aResult.test.objectname ,'') || '.' || nvl(aResult.test.testmethod ,''));
    --TODO: Make this friendly instead of an integer.
    DBMS_Output.put_line('Result: ' || aResult.result);
    dbms_output.put_line('Asserts');
   FOR I in aResult.AssertResults.First .. aResult.AssertResults.Last
   LOOP
      -- TODO: make this friendly instead of intege
      dbms_output.put('Assert ' || I || ' ' ||  aResult.AssertResults(I).AssertResult);
      dbms_output.put_line(' Message: ' ||  aResult.AssertResults(I).Message);
   END LOOP;   
  END;  

END;