CREATE OR REPLACE PACKAGE ut3TestRunner
AS
/** 
* Description: Executes a single test, used <strong>internally</strong> by ut3TestRunner. <br /> 
* Note: Does NOT call reporters.<br /> 
* Usage: Internal & External by those running unit test that may have not registered<br /> 
* DB Select: YES - Metadata through ut3MetaData <br />  
* DB Insert: NO <br /> 
* DB Update: NO <br /> 
* DB Delete: NO <br /> 
* DB Note: The DB Impact can be impacted by usage of Reporters.
* @headcom
*/

/**
* Default Test Reporters 
* used if not specified in ExecuteTests or ExecuteTest Call
*/
    --TODO: decide what the default reporter should be.
    DefaultReporters ut3Types.TestSuiteReporters;
    
    Procedure SetupDefaultReporters; 
    
    PROCEDURE ExecuteTests(aSuite in ut3Types.TestSuite, aReporters in ut3Types.TestSuiteReporters, aResults out ut3types.TestSuiteResults);
    PROCEDURE ExecuteTests(aSuite in ut3Types.TestSuite, aResults out ut3types.TestSuiteResults);
    PROCEDURE ExecuteTests(aSuite in ut3Types.TestSuite);

    PROCEDURE ExecuteTest(aTest in ut3Types.SingleTest, aReporters in ut3Types.TestSuiteReporters, aResults out ut3types.TestExecution_Result,aInSuite in boolean default false);
    PROCEDURE ExecuteTest(aTest in ut3Types.SingleTest, aResults out ut3types.TestExecution_Result,aInSuite in boolean default false);
    PROCEDURE ExecuteTest(aTest in ut3Types.SingleTest,aInSuite in boolean default false);



END; 