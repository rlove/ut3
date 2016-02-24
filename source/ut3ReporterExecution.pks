CREATE OR REPLACE PACKAGE ut3ReporterExecution
AS
  -- These are in spec to make testing a reporter easier
  PROCEDURE begin_suite (aReporter IN ut3Types.TestSuiteReporter, aSuite IN ut3Types.TestSuite);
  PROCEDURE end_suite (aReporter IN ut3Types.TestSuiteReporter, aSuite IN ut3Types.TestSuite, aResults IN ut3Types.TestSuiteResults);
  PROCEDURE begin_test(aReporter IN ut3Types.TestSuiteReporter, aTest IN ut3Types.SingleTest,aInSuite in boolean);
  PROCEDURE end_test(aReporter IN ut3Types.TestSuiteReporter, aTest IN ut3Types.SingleTest, aResult UT3TYPES.TestExecution_Result,aInSuite in boolean);
  
  -- These are the ones called when a test/suite is run.
  PROCEDURE begin_suite (aReporters IN ut3Types.TestSuiteReporters, aSuite IN ut3Types.TestSuite);
  PROCEDURE end_suite (aReporters IN ut3Types.TestSuiteReporters, aSuite IN ut3Types.TestSuite, aResults IN ut3Types.TestSuiteResults);
  PROCEDURE begin_test(aReporters IN ut3Types.TestSuiteReporters, aTest IN ut3Types.SingleTest,aInSuite in boolean);
  PROCEDURE end_test(aReporters IN ut3Types.TestSuiteReporters, aTest IN ut3Types.SingleTest, aResult UT3TYPES.TestExecution_Result,aInSuite in boolean);  
END;
