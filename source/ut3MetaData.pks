CREATE OR REPLACE PACKAGE ut3MetaData 
AS
/** 
* Description: Reads Metadata values. <br />
* Usage: Internal not to be consumed by those building unit test<br /> 
* DB Select: YES <br />  
* DB Insert: NO <br /> 
* DB Update: NO <br /> 
* DB Delete: NO <br /> 
* @headcom
*/

function packagevalid(aPackageName in VARCHAR2) return boolean;
  
function methodexists(aPackageName in VARCHAR2, aPackageMethod IN VARCHAR2) return boolean;

END;