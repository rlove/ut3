--This shows how the interna test engine works to test a single package.
--No tables are used for this and exceptions are handled better.
DECLARE
   TestToExecute ut3Types.SingleTest;
   TestResults ut3Types.TestExecution_Result;
BEGIN
   TestToExecute.TypeOfTest := ut3Types.TT_Package;
   TestToExecute.ObjectName := 'ut_exampletest';
   TestToExecute.SetupMethod := 'Setup';
   TestToExecute.TearDownMethod := 'TearDown';
   TestToExecute.TestMethod := 'ut_exampletest';
   ut3TestExecute.ExecuteTest(TestToExecute,TestResults);
   --For now result is an integer but will need a look upto make pretty later.
   dbms_output.put_line('Result: ' || TestResults.result);
   dbms_output.put_line('Assert Results:');
   FOR I in TestResults.AssertResults.First .. TestResults.AssertResults.Last
   LOOP
      dbms_output.put_line(I || ' - result: ' ||  TestResults.AssertResults(I).AssertResult);
      dbms_output.put_line(I || ' - Message: ' ||  TestResults.AssertResults(I).Message);
   END LOOP;   
END;






