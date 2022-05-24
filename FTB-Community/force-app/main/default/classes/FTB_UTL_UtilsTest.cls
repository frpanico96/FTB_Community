/**@frpanico 2022-03-15
 * FTB
 * FTB_UTL_Utils
 * Test class
 */
@isTest
public with sharing class FTB_UTL_UtilsTest 
{
    private static FTB_UTL_Utils utilClass = new FTB_UTL_Utils();

    @TestSetup
    static void setup()
    {
        List<FTB_Player__c> players = FTB_UTL_DataFactory.createPlayers(true, 3);
    }

    @isTest
    static void updateListTest()
    {
        Test.startTest();
            List<FTB_Player__c> players = [SELECT Id, Name FROM FTB_Player__c];
            for(FTB_Player__c player : players)
            {
                player.FTB_Assists__c = 2.0;
            }
            utilClass.updateSObject(players);
        Test.stopTest();
        List<FTB_Player__c> playersUpdated = [SELECT Id FROM FTB_Player__c WHERE FTB_Assists__c = 2.0];
        System.assertEquals(3, playersUpdated.size(), 'Update failed');
    }
    @isTest
    static void updateTest()
    {
        Test.startTest();
            List<FTB_Player__c> players = [SELECT Id, Name FROM FTB_Player__c];
            players[0].FTB_Assists__c = 2.0;
            utilClass.updateSObject(players[0]);
        Test.stopTest();
        List<FTB_Player__c> playersUpdated = [SELECT Id FROM FTB_Player__c WHERE FTB_Assists__c = 2.0];
        System.assertEquals(1, playersUpdated.size(), 'Update failed');
    }
    @isTest
    static void insertTest()
    {
        String playerName = 'Test Player';
        Test.startTest();
            FTB_Player__c player = new FTB_Player__c();
            player.Name = playerName;
            utilClass.insertSObject(player);
        Test.stopTest();
        List<FTB_Player__c> playersUpdated = [SELECT Id FROM FTB_Player__c WHERE Name = :playerName];
        System.assertEquals(1, playersUpdated.size(), 'Insert failed');
    }
    @isTest
    static void deleteTest()
    {
        Test.startTest();
            List<FTB_Player__c> players = [SELECT Id, Name FROM FTB_Player__c];
            utilClass.deleteSObject(players[0]);
        Test.stopTest();
        List<FTB_Player__c> playersUpdated = [SELECT Id FROM FTB_Player__c];
        System.assertEquals(2, playersUpdated.size(), 'Delete failed');
    }
    @isTest
    static void readTest()
    {
        FTB_Player__c player = [SELECT Id FROM FTB_Player__c LIMIT 1];
        Test.startTest();
            List<FTB_Player__c> players = utilClass.readSObject(player);
        Test.stopTest();
        System.assertEquals(1, players.size(), 'Read failed');
    }
    @isTest
    static void tryParseTest()
    {
        Date dateTest;
        Date dateFailTest;
        Integer integerTest;
        Double doubleTest;
        String stringTest;
        Boolean booleanTest;
        Time timeTest;
        Test.startTest();
            dateTest = (Date)utilClass.tryParse('2022-05-24', Schema.SoapType.DATE);
            dateFailTest = (Date)utilClass.tryParse('example', Schema.SoapType.DATE);
            integerTest = (Integer)utilClass.tryParse('2', Schema.SoapType.INTEGER);
            doubleTest = (Double) utilClass.tryParse('2.0', Schema.SoapType.DOUBLE);
            stringTest = (String) utilClass.tryParse('example', Schema.SoapType.STRING);
            booleanTest = (Boolean) utilClass.tryParse('true', Schema.SoapType.BOOLEAN);
            timeTest = (Time) utilClass.tryParse(Time.newInstance(1, 0, 0, 0), Schema.SoapType.TIME);
        Test.stopTest();
        System.assertEquals(Date.newInstance(2022, 5, 24), dateTest , 'Date failed');
        System.assertEquals(2, integerTest , 'Integer failed');
        System.assertEquals(2.0, doubleTest , 'Double failed');
        System.assertEquals('example', stringTest, 'String failed');
        System.assertEquals(true, booleanTest, 'Boolean failed');
        System.assertEquals(null, timeTest, 'Time failed');

    }


}
