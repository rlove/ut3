CREATE OR REPLACE PACKAGE ut3DBMSOutputReporter
AS

  PROCEDURE begin_suite (aSuite IN ut3Types.TestSuite);
  PROCEDURE end_suite (aSuite IN ut3Types.TestSuite, aResults IN ut3Types.TestSuiteResults);
  
  PROCEDURE begin_test(aTest IN ut3Types.SingleTest,aInSuite in boolean);
  PROCEDURE end_test(aTest IN ut3Types.SingleTest, aResult UT3TYPES.TestExecution_Result,aInSuite in boolean);

END;