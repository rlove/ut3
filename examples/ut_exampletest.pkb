create or replace package body ut_exampletest
AS

 procedure Setup
 as
 begin
   null;
 end;
 
 procedure TearDown
 as
 begin
   null;
 end;
 
 procedure ut_exampletest
 as
 begin
    ut3assert.areEqual('Test 1 Should Pass',1,1);
    ut3assert.areEqual('Test 2 Should Fail',1,2); 
 end;
 
END;