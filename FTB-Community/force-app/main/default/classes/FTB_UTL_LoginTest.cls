/**@frpanico
 * Test class for FTB_UTL_LoginTest
 */
@isTest
public with sharing class FTB_UTL_LoginTest
{
    @TestSetup
    static void setup()
    {
        FTB_UTL_DataFactory.createUser(true, 1);    
    }
    @isTest
    static void generateUserSessionTest()
    {
        List<FTB_User__c> userList = [SELECT FTB_Username__c FROM FTB_User__c];
        FTB_UTL_Login testClass = new FTB_UTL_Login();
        Test.startTest();
            FTB_Session__c resultOne = testClass.generateUserSession(userList[0].Id, userList[0].FTB_Username__c);
            insert resultOne;
            FTB_Session__c resultTwo = testClass.generateUserSession(userList[0].Id, userList[0].FTB_Username__c);
        Test.stopTest();
        System.assertEquals(true, resultOne.Id == resultTwo.Id, 'Session not generated correctly');
    }
}