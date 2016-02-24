#Proposal#

I spent time evaluating unit testing solutions such as TOAD, PL/SQL developer, plunit, pluto and of course utplsql.      Before selecting utPlSql.    As I have used it I have desired to write an Open Source IDE for unit tests that may be similar to old ounit product that does not seem to exist anymore.

In investigating the code base I found that utPlSQL has a LOT of legacy code.
So I spent a few hours over a  couple of days I started writing what I would like it to look like.    It was not long till I realized that what I started may be more than a small proposal.    So I have decided to create a separate repository for it show what I have written and stop until I get some feedback.

As of right now I have not used any code from utPlSql the current proposal is significant redesign/write from scratch. I believe we can keep it clean then we can use a license that is more friendly than GPL.   utPlSql was written first and each commercial entity ended up rewriting there own solution.   Instead of solution friendly to commercial products may allow tests written product x to be usable with product y.  Granted then there may be an argument that this is not utPlSql at all.    Really need feedback on this.     

#Key Areas
 
 * [Installation](#install)
 * [How to Use](#how-to-use)
 * [Core Engine](#core-engine) - Test Execution and calling of registered reporters.
 * [Reporters](#reporters) - Reporting results of tests
 * [Suite Management](#suite-management) - Test Suite registration and detection.
 * [Documentation](#documentation) 
 * [Oracle Version](#oracle-version)
 * [What I dislike about my proposal](#dislike)

#Installation

Right now you have manually run each of the scripts in the source directory excluding uninstall.sql.

#How to Use

There are some sample tests written in the examples directory that can be loaded into the same schema as the test engine (don't have grants, etc... setup to cross schemas yet.)


**devscripts/ut3RunExampleTestThroughBaseClass.sql**

* This runs the core engine test execution package.

**ut3RunExampleTestSuite.sql**

* This runs the ut3TestRunner with a suite built from code.


#Core Engine
 
###Features Currently implemented
 * Checks for existence and validity of code being tested.
 * Test can have 3 results
	 * Pass - Assertion Passes
	 * Fail - Asssertion fails
	 * Error - Exception raised or test code was invalid or not found.
 * Test can be written as PL/SQL package
 * A single package could contain multiple setup,teardown, and test methods.
 * Setup, Teardown, and method names are not Hardcoded.
 * Does no DBMS_OUTPUT unless Developer Trace compiler define flag is enabled.
 * Definition of the reporter interface. 
 * Will call one or more reporters.
 * Output is optionally returned as parameters, making external callers easy.
 
###Proposed Features  
 * Support both packages and object tests where test would descend from a common  ut3BaseTestObject
 * Complete Assertion Package right now I have on method on assertion package.
   * Needs to match the current asserts specifications otherwise everyone has to rewrite tests and even I don't want to do that, my employer has apx 500 tests.

#Reporters

Reporters are responsible for reporting the results of the test via any number of various methods.   

### Existing Reporters

* ut3DBMSOutputReporter - Output via DBMS_OUTPUT 

### Proposed Reporters

* Writes results to set of tables.
* Writes results to XML File that looks like NUNIT output so it can be easily imported by build/ci servers to display results.
* Writes results to an HTML file. 

#Suite Management

Nothing has been written here yet, but since this separate from the core engine, the core engine could be used to unit test all of the Suite management.  

### Proposed features

* Suites have a simple name.
* Test Registration into one or more Suites
* Test File Compilation (Optional Features I don't use this in the current utplsql)
* Ability to run one or suites by name.
* Suites can contain Suites, so you can have a master suite that runs all the smaller suites.
* Suites can be registered in code or via table entries.


#Documentation

 * Markdown seems to be a good option for github online documentation and it's converted to HTML easily and is very version control friendly.  
 * API reference generated through [pldoc](http://pldoc.sourceforge.net/maven-site/)

#Oracle Version

Conditional Defines were introduced in 9 so that is the bare minimum.  As we could use defines for newer versions.  

I have only access to Oracle 11.2 and 12.1 I can't test with anything else.
My code was written in 12.1 and I have not tried this with 11.2 yet.

According to the [Lifetime Support policy](http://www.oracle.com/us/support/library/lifetime-support-technology-069183.pdf) 11.2 is the oldest version covered under the extended support.    I believe that makes it easy to only support that version or later.   
 
#Dislike

* Names should not have a version number in it as that not very future proof.   I did it this way to not have to initially worry about conflicts with current utplsql versions.
* Consistency in formatting and naming would like to follow or establish some rough guidelines for consistency.
  * Sometimes I used "IF THEN END IF" and other times I use "if then end if"
  * Overall case is inconsistent.
  * Parameter names some start with "a" and sometimes not
  * variables naming inconsistent
  * Tabs/space are inconsistent
* Naming things like "Method" may be wrong for PL/SQL since everyone knows them as "procedures" 
* Have not thought about Data driven tests and want to address that in the design.
	* Basically idea is Test methods with parameters and a set of data is passed to those parameters.
* Have not thought about translation to support multiple languages, although I am not 100% sure if anyone will use it.
*DMBS_Output Reporter lacks nice formatting.
