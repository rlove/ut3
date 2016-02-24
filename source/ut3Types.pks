CREATE OR REPLACE PACKAGE ut3Types AS
/** 
* Description: Common types and constants used throughout the system.<br /> 
* Note: Does NOT call reporters.<br /> 
* Usage: internal & external<br /> 
* DB Select: NO <br />  
* DB Insert: NO <br /> 
* DB Update: NO <br /> 
* DB Delete: NO <br /> 
* @headcom
*/

    TR_Success constant number(1) :=1; -- Test Passed
    TR_Failure constant number(1) :=2; -- One or more Asserts Failed
    TR_Error   constant number(1) :=3; -- Exception was raised    
    subtype TestResult is binary_integer range 1..3;

    TT_Package constant number(1) := 1; -- Test is contained in a package
    TT_Object  constant number(1) := 2; -- Test is contained in an object
    subtype TestType is binary_integer range 1..2;


    TYPE AssertResult IS RECORD
    (
        AssertResult TESTRESULT,
        Message VARCHAR2(4000)
    );
    
    TYPE AssertList IS TABLE OF AssertResult;

   
    TYPE SingleTest IS RECORD
    ( -- May have to change if we support Data Driven Tests.
        TypeOfTest TestType, 
        ObjectName VARCHAR2(30),  
        SetupMethod VARCHAR2(30),
        TeardownMethod VARCHAR2(30),
        TestMethod VARCHAR2(30)
    );
    
    TYPE TestExecution_Result IS RECORD
    (
        Test SingleTest,
        StartTime TIMESTAMP,
        EndTime TIMESTAMP,
        Result TestResult,
        AssertResults AssertList 
    );
    
    
    TYPE TestList IS TABLE OF SingleTest;
    
    TYPE TestSuite IS RECORD
    ( 
      SuiteName VARCHAR2(50),
      Tests TestList
    );
    
    -- May want to this be a record that contains this list.
    -- Not really sure yet.
    TYPE TestSuiteResults IS TABLE OF TestExecution_Result;
    
    
    TYPE TestSuiteReporter IS RECORD
    (
      PackageName VARCHAR(30),
      begin_suite_method VARCHAR(30) NOT NULL DEFAULT 'begin_suite',
      end_suite_method  VARCHAR(30) NOT NULL DEFAULT 'end_suite',
      begin_test_method VARCHAR(30) NOT NULL DEFAULT 'begin_test',
      end_test_method VARCHAR(30) NOT NULL DEFAULT 'end_test' 
    );
    
    TYPE TestSuiteReporters IS TABLE OF TestSuiteReporter;
    
END ut3Types;