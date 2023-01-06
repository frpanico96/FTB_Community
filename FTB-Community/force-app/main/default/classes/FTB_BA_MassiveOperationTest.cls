/**@frpanico
 * Test class for FTB_BA_MassiveOperation
 */
@isTest
public with sharing class FTB_BA_MassiveOperationTest 
{
    @TestSetup
    static void setup()
    {    
    }

    @isTest
    static void executeTest()
    {
        List<FTB_WRP_Scope> scopeList = new List<FTB_WRP_Scope>();
        FTB_WRP_Scope singleScope = new FTB_WRP_Scope();
        Map<String, String> scopeMap = new Map<String, String>();
        scopeMap.put('firstName', 'Test');
        scopeMap.put('lastName', 'Batch');
        scopeMap.put('personId', '12390');
        scopeMap.put('isActive', 'true');
        scopeMap.put('dateOfBirthUTC', '2022-01-01');
        singleScope.integrationObj = scopeMap;
        scopeList.add(singleScope);
        String service = 'GET_PLAYERS';
        Test.startTest();
            Id batchJobId = Database.executeBatch(new FTB_BA_MassiveOperations(scopeList,service), 100);
        Test.stopTest();
        List<FTB_Player__c> players = [SELECT Id FROM FTB_PLayer__c];
        System.assertEquals(true, !players.isEmpty(), 'execute batch failed');

    }
}
