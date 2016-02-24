--This is only typically needed by developers of utplsql
--Running this script recompiles the packages with tracing turned on.

alter session set PLSQL_Warnings = 'enable:all';
alter session set PLSQL_CCFlags = 'ut3trace:true';

ALTER PACKAGE ut3Types COMPILE  DEBUG PACKAGE;
ALTER PACKAGE ut3Assert COMPILE  DEBUG PACKAGE;
ALTER PACKAGE ut3TestExecute COMPILE  DEBUG PACKAGE;
ALTER PACKAGE ut_exampletest COMPILE  DEBUG PACKAGE;
