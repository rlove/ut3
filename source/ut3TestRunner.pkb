CREATE OR REPLACE PACKAGE BODY ut3TestRunner
AS

Procedure SetupDefaultReporters
AS
 reporter ut3Types.TestSuiteReporter;
BEGIN
  -- If list is initiatized and empty then that's the default that has been choosen
  -- We only initialize the default
  IF DefaultReporters IS NULL THEN
    DefaultReporters := ut3Types.TestSuiteReporters();
    
    reporter.PackageName := 'ut3DBMSOutputReporter';
    
    DefaultReporters.extend;
    DefaultReporters(DefaultReporters.LAST) := reporter;
  END IF;
END;

PROCEDURE ExecuteTests(aSuite in ut3Types.TestSuite, aReporters in ut3Types.TestSuiteReporters, aResults out ut3types.TestSuiteResults)
AS
 test_result ut3types.TestExecution_Result;
BEGIN   
    ut3ReporterExecution.begin_Suite(aReporters,aSuite);     
    aResults := ut3types.TestSuiteResults();
    FOR i in aSuite.Tests.FIRST .. aSuite.Tests.LAST 
    LOOP
        ExecuteTest(aSuite.Tests(i),aReporters,test_result,true);
        aResults.Extend;
        aResults(aResults.LAST) := test_result;      
    END LOOP;
    ut3ReporterExecution.end_Suite(aReporters,aSuite,aResults);
END;

PROCEDURE ExecuteTests(aSuite in ut3Types.TestSuite, aResults out ut3types.TestSuiteResults)
AS
BEGIN
    SetupDefaultReporters;
    ExecuteTests(aSuite,DefaultReporters,aResults);
END;


PROCEDURE ExecuteTests(aSuite in ut3Types.TestSuite)
AS
    results ut3types.TestSuiteResults;
BEGIN
    ExecuteTests(aSuite,results);
END;

PROCEDURE ExecuteTest(aTest in ut3Types.SingleTest, aReporters in ut3Types.TestSuiteReporters, aResults out ut3types.TestExecution_Result,aInSuite in boolean default false)
AS
begin
   ut3ReporterExecution.begin_test(aReporters,aTest,aInSuite);
   ut3TestExecute.ExecuteTest(aTest,aResults);
   ut3ReporterExecution.end_test(aReporters,aTest,aResults,aInSuite);
end;

PROCEDURE ExecuteTest(aTest in ut3Types.SingleTest, aResults out ut3types.TestExecution_Result,aInSuite in boolean default false)
AS
BEGIN
   SetupDefaultReporters;
   ExecuteTest(aTest,DefaultReporters,aResults,aInSuite);
END;

PROCEDURE ExecuteTest(aTest in ut3Types.SingleTest,aInSuite in boolean default false)
AS
    TestResults ut3Types.TestExecution_Result;
BEGIN
    ExecuteTest(aTest,TestResults,aInSuite);
END;

END; 