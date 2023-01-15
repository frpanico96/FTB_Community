/**@frpanico
 * Test class fot FTB_TRH_Queue
*/
@isTest
public with sharing class FTB_TRH_QueueTest
{
    @isTest
    static void queueInsertTest()
    {
        Test.startTest();
        FTB_Queue__c testQueue = new FTB_Queue__c(FTB_Operation__c = 'FETCH_HOME', 
            FTB_Payload__c = JSON.serialize(new Map<String, String>{'sessionId' => 'test'}));
        insert testQueue;
        Test.stopTest();
        
        List<FTB_Queue__c> result = [SELECT Id FROM FTB_Queue__c];
        System.assertEquals(true, result.isEmpty(), 'Queue still in queue');
    }
}