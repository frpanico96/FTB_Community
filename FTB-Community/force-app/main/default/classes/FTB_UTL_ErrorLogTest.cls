/**@frpanico
 * test class for FTB_UTL_ErrorLog
 */
@isTest
public with sharing class FTB_UTL_ErrorLogTest 
{
    @isTest
    static void insertLogTest()
    {
        Test.startTest();
            new FTB_UTL_ErrorLog('test', 'test', 'test');
            new FTB_UTL_ErrorLog('test','test','test','test','test');
        Test.stopTest();
        List<FTB_ErrorLog__c> result = [SELECT Id FROM FTB_ErrorLog__c];
        System.assertEquals(true, !result.isEmpty(), 'Error not logged');
    }
}