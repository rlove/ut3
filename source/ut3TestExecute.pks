CREATE OR REPLACE PACKAGE ut3TestExecute AUTHID CURRENT_USER
AS
/** 
* Description: Executes a single test, used <strong>internally</strong> by ut3TestRunner. <br /> 
* Note: Does NOT call reporters.<br /> 
* Usage: Internal not to be consumed by those building unit test<br />
* DB Select: YES - Metadata through ut3MetaData <br />  
* DB Insert: NO <br /> 
* DB Update: NO <br /> 
* DB Delete: NO <br /> 
* @headcom
*/
  PROCEDURE ExecuteTest (aTestToExecute IN ut3Types.SingleTest,
                         aTestResult    OUT ut3Types.TestExecution_Result);
END ut3TestExecute;
/