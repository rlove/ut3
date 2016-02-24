CREATE OR REPLACE PACKAGE BODY ut3Assert
IS
 
 FUNCTION CurrentAssertTestResult return ut3Types.TestResult
 IS
   v_result ut3Types.TestResult;
 BEGIN
    $IF $$ut3trace $THEN DBMS_OUTPUT.PUT_LINE('ut3Assert.CurrentAssertTestResult'); $END
    v_result := ut3Types.TR_Success; 
    for I in CurrentAssertsCalled.FIRST .. CurrentAssertsCalled.LAST
    LOOP
        IF CurrentAssertsCalled(I).AssertResult = ut3Types.TR_Failure THEN
           v_result := ut3Types.TR_Failure;
        END IF;
        
        IF CurrentAssertsCalled(I).AssertResult = ut3Types.TR_Error THEN
           v_result := ut3Types.TR_Error;
           RETURN v_result;
        END IF;        
    END LOOP;
    RETURN v_result;
 END;
 
 PROCEDURE ClearAsserts
 IS
 BEGIN
    $IF $$ut3trace $THEN DBMS_OUTPUT.PUT_LINE('ut3Assert.ClearAsserts'); $END
    CurrentAssertsCalled.delete;
 END;
  
 PROCEDURE CopyAssertsCalledToNewTable(newTable IN OUT ut3Types.AssertList)
 IS
 BEGIN
    $IF $$ut3trace $THEN DBMS_OUTPUT.PUT_LINE('ut3Assert.CopyAssertsCalledToNewTable'); $END
    newTable.Delete; -- Make sure new table is empty
    newTable.Extend(CurrentAssertsCalled.Last);
    FOR i in CurrentAssertsCalled.First..CurrentAssertsCalled.Last
    LOOP
        $IF $$ut3trace $THEN DBMS_OUTPUT.PUT_LINE(i || '-start'); $END
        NewTable(i) := CurrentAssertsCalled(i);
        $IF $$ut3trace $THEN DBMS_OUTPUT.PUT_LINE(i || '-end'); $END
    END LOOP;
 END;
 
 PROCEDURE report_assert(AssertResult IN ut3Types.TestResult,Message IN VARCHAR2)
 IS
   v_result ut3types.AssertResult;
 BEGIN
   $IF $$ut3trace $THEN DBMS_OUTPUT.PUT_LINE('ut3Assert.report_assert :' || AssertResult || ':' || Message ); $END
   v_result.AssertResult := AssertResult;
   v_result.Message := Message;
   CurrentAssertsCalled.Extend;
   CurrentAssertsCalled(CurrentAssertsCalled.Last) := v_result;
 END;
 
  
 PROCEDURE report_success(Message IN VARCHAR2,Expected IN VARCHAR2,actual IN VARCHAR2)
 IS
 BEGIN
   report_assert(ut3Types.TR_Success,nvl(Message,'') || ' Expected: ' || nvl(Expected,'') || ' Actual: ' || nvl(Actual,''));
 END;
 
PROCEDURE report_failure(Message IN VARCHAR2,Expected IN VARCHAR2,actual IN VARCHAR2)
IS
BEGIN
    report_assert(ut3Types.TR_Failure,nvl(Message,'') || ' Expected: ' || nvl(Expected,'') || ' Actual: ' || nvl(Actual,''));   
END;
 
PROCEDURE report_error(Message IN VARCHAR2)
IS
BEGIN
    report_assert(ut3Types.TR_Error,Message);
END;
 
PROCEDURE AreEqual(expected IN number,actual IN number)
IS
BEGIN
    AreEqual(expected,actual);
END;
 
PROCEDURE AreEqual(msg IN varchar2, expected IN number,actual IN number)
IS
BEGIN
    IF expected = actual THEN
        report_success(msg,expected,actual); 
    ELSE
        report_failure(msg,expected,actual);
    END IF;
END; 
  

end ut3Assert;
