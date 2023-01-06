/**@frpanico 2022-05-25
 * Test class for FTB_QR_Utils
 */
@isTest
public with sharing class FTB_QR_UtilsTest 
{
    private static FTB_QR_Utils utilsQr = new FTB_QR_Utils();

    @TestSetup
    static void setup()
    {
        
    }
    @isTest
    static void getMapperTest()
    {
        String service = 'GET_PLAYERS';
        Test.startTest();
            List<FTB_CMT_FieldMapper__mdt> mapper = utilsQr.getMapper(service);
        Test.stopTest();
        System.assertEquals(true, !mapper.isEmpty(), 'get mapper failed');
    }
    @isTest
    static void getListViewTest()
    {
        String objectName = 'FTB_Player__c';
        String developerNameBase = 'FTB';
        Test.startTest();
            List<ListView> listViews = utilsQr.getListView(objectName, developerNameBase);
        Test.stopTest();
        System.assertEquals(true, !listViews.isEmpty(), 'get list view failed');
    }
}
