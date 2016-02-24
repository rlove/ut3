create or replace package ut3Assert AUTHID CURRENT_USER
AS
 CurrentAssertsCalled ut3Types.AssertList := ut3Types.AssertList();
 
 function CurrentAssertTestResult return ut3Types.TestResult;
 procedure ClearAsserts;
 procedure report_error(Message IN VARCHAR2);
 procedure CopyAssertsCalledToNewTable(newTable IN OUT ut3Types.AssertList);
 procedure AreEqual(expected IN number,actual IN number);
 procedure AreEqual(msg IN varchar2, expected IN number,actual IN number); 
  

end ut3Assert;
