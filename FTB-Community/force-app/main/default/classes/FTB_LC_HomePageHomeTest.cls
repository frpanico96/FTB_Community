/**@frpanico
 * Test class for FTB_LC_HomePageHomeTest
 */
@isTest
public with sharing class FTB_LC_HomePageHomeTest 
{
    @TestSetup
    static void setup()
    {
        
    }
    @isTest
    static void fetchDataTest()
    {
        String sessionIdTst = 'test';
        Test.startTest();
            String result = FTB_LC_HomePageHome.fetchData(sessionIdTst);
        Test.stopTest();
        List<FTB_Queue__c> queueTst = [SELECT Id FROM FTB_Queue__c];
        System.assertEquals(true, !queueTst.isEmpty(),'Data not fetch correclty');
    }
}
