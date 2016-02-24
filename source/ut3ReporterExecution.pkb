CREATE OR REPLACE PACKAGE BODY ut3ReporterExecution
AS

PROCEDURE begin_suite (aReporter IN ut3Types.TestSuiteReporter, aSuite IN ut3Types.TestSuite)
AS
  stmt VARCHAR2(100);
BEGIN
    IF ut3MetaData.PackageValid(aReporter.PackageName) and ut3MetaData.MethodExists(aReporter.PackageName,aReporter.begin_suite_method) THEN
         stmt := 'BEGIN '  || trim(aReporter.PackageName) || '.' || trim(aReporter.begin_suite_method) || '(:suite); END;'; 
        EXECUTE IMMEDIATE stmt USING aSuite;
    END IF;
END;

PROCEDURE end_suite (aReporter IN ut3Types.TestSuiteReporter, aSuite IN ut3Types.TestSuite, aResults IN ut3Types.TestSuiteResults)
AS
  stmt VARCHAR2(100);
BEGIN
    IF ut3MetaData.PackageValid(aReporter.PackageName) and ut3MetaData.MethodExists(aReporter.PackageName,aReporter.end_suite_method) THEN
        stmt := 'BEGIN '  || trim(aReporter.PackageName) || '.' || trim(aReporter.end_suite_method) || '(:suite,:results); END;'; 
        EXECUTE IMMEDIATE stmt USING aSuite,aResults;
    END IF;
END;
PROCEDURE begin_test(aReporter IN ut3Types.TestSuiteReporter, aTest IN ut3Types.SingleTest,aInSuite in boolean)
AS
  stmt VARCHAR2(100);
BEGIN
    IF ut3MetaData.PackageValid(aReporter.PackageName) and ut3MetaData.MethodExists(aReporter.PackageName,aReporter.begin_test_method) THEN
        stmt := 'BEGIN '  || trim(aReporter.PackageName) || '.' || trim(aReporter.begin_test_method) || '(:test,:insuite); END;'; 
        EXECUTE IMMEDIATE stmt USING aTest, aInSuite;
    END IF;
END;
PROCEDURE end_test(aReporter IN ut3Types.TestSuiteReporter, aTest IN ut3Types.SingleTest, aResult UT3TYPES.TestExecution_Result,aInSuite in boolean)
AS
  stmt VARCHAR2(100);
BEGIN
    IF ut3MetaData.PackageValid(aReporter.PackageName) and ut3MetaData.MethodExists(aReporter.PackageName,aReporter.end_test_method) THEN
        stmt := 'BEGIN '  || trim(aReporter.PackageName) || '.' || trim(aReporter.end_test_method) || '(:test,:result,:insuite); END;'; 
        EXECUTE IMMEDIATE stmt USING aTest,aResult,aInSuite;
    END IF;    
END;

  
PROCEDURE begin_suite (aReporters IN ut3Types.TestSuiteReporters, aSuite IN ut3Types.TestSuite)
AS
BEGIN
    IF aReporters is NOT NULL THEN
        FOR i in aReporters.FIRST .. aReporters.LAST
        LOOP
            begin_suite(aReporters(i),aSuite); 
        END LOOP;
    END IF;
END;
PROCEDURE end_suite (aReporters IN ut3Types.TestSuiteReporters, aSuite IN ut3Types.TestSuite, aResults IN ut3Types.TestSuiteResults)
AS
BEGIN
    IF aReporters is NOT NULL THEN
        FOR i in aReporters.FIRST .. aReporters.LAST
        LOOP
            end_suite(aReporters(i),aSuite,aResults); 
        END LOOP;
    END IF;      
END;
PROCEDURE begin_test(aReporters IN ut3Types.TestSuiteReporters, aTest IN ut3Types.SingleTest,aInSuite in boolean)
AS
BEGIN
    IF aReporters is NOT NULL THEN
        FOR i in aReporters.FIRST .. aReporters.LAST
        LOOP
            begin_Test(aReporters(i),aTest,aInSuite); 
        END LOOP;
    END IF;
      
END;
PROCEDURE end_test(aReporters IN ut3Types.TestSuiteReporters, aTest IN ut3Types.SingleTest, aResult UT3TYPES.TestExecution_Result,aInSuite in boolean)  
AS
BEGIN  
    IF aReporters is NOT NULL THEN
        FOR i in aReporters.FIRST .. aReporters.LAST
        LOOP
        end_test(aReporters(i),aTest,aResult,aInSuite); 
        END LOOP;
    END IF;
END;

END;
