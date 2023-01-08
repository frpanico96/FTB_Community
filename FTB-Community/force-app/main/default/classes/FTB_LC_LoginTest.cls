/**@frpanico
 * Test class for FTB_LC_Login
 */
@isTest
public with sharing class FTB_LC_LoginTest 
{
    @TestSetup
    static void setup()
    {
    }
    @isTest
    static void makeRegisterLoginErrorTest()
    {
        String credentials = 'credentials';
        String result;
        Test.startTest();
            try
            {
                result = FTB_LC_Login.makeRegisterLogin(credentials);
            }
            catch(Exception e)
            {
                result = '';
            }
        Test.stopTest();
        System.assertEquals(true, String.isBlank(result),'Error not thrown');
    }
    @isTest
    static void makeRegisterLoginTest()
    {
        Map<String,String> credentialMap = new Map<String,String>{'test'=> 'credentials'};
        String result;
        Test.startTest();
            try
            {
                result = FTB_LC_Login.makeRegisterLogin(JSON.serialize(credentialMap));
            }
            catch(Exception e)
            {
                result = '';
            }
        Test.stopTest();
        List<FTB_Queue__c> queueTest = [SELECT Id FROM FTB_Queue__c];
        System.assertEquals(true, !queueTest.isEmpty(),'Incorrect Login');
    }
    
}
