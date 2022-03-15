/**@frpanico 2022-03-15
 * FTB
 * FTB_WS_Integration
 * Test class
 */
@isTest
public with sharing class FTB_WS_IntegrationTest 
{
    @isTest
    static void integrationTest()
    {
        FTB_WS_TestMock.setMock(TestMock.class);
        Test.startTest();
            FTB_WS_Integration integrationClass = new FTB_WS_Integration(FTB_ENM_Service.GET_PLAYERS);
            FTB_WRP_OperationResult opResult = integrationClass.execute();
        Test.stopTest();

        List<FTB_Player__c> players = [Select Id FROM FTB_Player__c];
        System.assertEquals(false, players.isEmpty(), 'Players have not been created');
        System.assertEquals(true, opResult.SUCCESS, 'Operation not successful');

    }
    @isTest
    static void errorTest()
    {
        /* Don't set the mock to make the code enters the catch block */
        Test.startTest();
            FTB_WS_Integration integrationClass = new FTB_WS_Integration(FTB_ENM_Service.GET_PLAYERS);
            FTB_WRP_OperationResult opResult = integrationClass.execute();
        Test.stopTest();
        System.assertEquals(false, opResult.SUCCESS, 'Operation successful');
    }
    @isTest
    static void nullServiceTest()
    {
        Test.startTest();
            FTB_WS_Integration integrationClass = new FTB_WS_Integration(null);
            FTB_WRP_OperationResult opResult = integrationClass.execute();
        Test.stopTest();
        System.assertEquals(false, opResult.SUCCESS, 'Operation successful');
    }
    public class TestMock implements HttpCalloutMock
    {
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            String body = '{"_internal": {"pubDateTime": "2022-03-15 17:10:10.852 EDT",'
            +'"igorPath": "S3,1647378592248,1647378594987|router,1647378594987,1647378594997|domUpdater,'
            +'1647378596279,1647378606526|feedProducer,1647378609527,1647378620632",'
            +'"xslt": "NBA/xsl/league/roster/marty_active_players.xsl","xsltForceRecompile": "true",'
            +'"xsltInCache": "false","xsltCompileTimeMillis": "328","xsltTransformTimeMillis": "7880",'
            +'"consolidatedDomKey": "prod__transform__marty_active_players__1238146183711","endToEndTimeMillis"'
            +': "28384"},"league": {"standard":[{"firstName": "Precious","lastName": "Achiuwa","temporaryDisplayName"'
            +': "Achiuwa, Precious","personId": "1630173","teamId": "1610612761","jersey": "5","isActive": true,'
            +'"pos": "F","heightFeet": "6","heightInches": "8","heightMeters": "2.03","weightPounds": "225",'
            +'"weightKilograms": "102.1","dateOfBirthUTC": "1999-09-19","teamSitesOnly": {"playerCode":'
            +'"precious_achiuwa","posFull": "Forward","displayAffiliation": "Memphis/Nigeria","freeAgentCode": ""},'
            +'"teams": [{"teamId": "1610612748","seasonStart": "2020","seasonEnd": "2020"},{"teamId": "1610612761",'
            +'"seasonStart": "2021","seasonEnd": "2021"}],"draft": {"teamId": "1610612748","pickNum": "20","roundNum"'
            +':"1","seasonYear": "2020"},"nbaDebutYear": "2020","yearsPro": "1","collegeName": "Memphis",'
            +'"lastAffiliation": "Memphis/Nigeria","country": "Nigeria"}],"africa": [],"sacramento": [],"vegas":[],'
            +'"utah": []}}';
            response.setHeader('Content-Type', 'application/json');
            response.setBody(body);
            response.setStatusCode(200);
            return response;
        }
    }

}
