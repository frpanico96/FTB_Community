/**@frpanico 2022-02-06
 * Controller for LWC ftbUtils
 */
public with sharing class FTB_LC_Utils extends FTB_UTL_Utils implements FTB_INF_FetchData
{

    @AuraEnabled(cacheable=true)
    public static String getConfiguration(String componentName)
    {
        FTB_WRP_Utils.ConfigurationWrapper wrpConfig = new FTB_WRP_Utils.ConfigurationWrapper();
        List<FTB_CMT_Configurations__mdt> configurations = retrieveConfiguration(componentName);
        /* Only one configurations is expected */
        for(FTB_CMT_Configurations__mdt	configuration : configurations)
        {
            /* Header assignments */
            wrpConfig.header.message = configuration.FTB_HeaderConfigurations__r[0].FTB_Message__c;
            wrpConfig.header.position = configuration.FTB_HeaderConfigurations__r[0].FTB_Position__c;
            wrpConfig.header.textStyle = configuration.FTB_HeaderConfigurations__r[0].FTB_TextStyle__c;
            wrpConfig.header.additionalStyling = configuration.FTB_HeaderConfigurations__r[0].FTB_AdditionalStyling__c;
            /* Tile Assignments */
            if(!configuration.FTB_TileConfigurations__r.isEmpty())
            {
                wrpConfig.tile.message = configuration.FTB_TileConfigurations__r[0].FTB_Message__c;
                wrpConfig.tile.button = configuration.FTB_TileConfigurations__r[0].FTB_Button__c;
                wrpConfig.tile.spinner = configuration.FTB_TileConfigurations__r[0].FTB_Spinner__c;
            }
            break;
        }   
        /* Utility log */
        System.debug(loggingLevel.DEBUG,'Wrapped configuration: ' + JSON.serialize(wrpConfig));
        /* A string is returned
        * Since the wrapped object is not recognized
        * by the client
        */
        return JSON.serialize(wrpConfig);
    }
    /**@frpanico 2022-02-08
     * FTB
     * Added query to retrieve child
     * CMDT
     */
    private static List<FTB_CMT_Configurations__mdt> retrieveConfiguration(String componentName)
    {
        return [SELECT Id,
        (SELECT FTB_Message__c,
        FTB_Position__c,
        FTB_TextStyle__c,
        FTB_AdditionalStyling__c
        FROM FTB_HeaderConfigurations__r
        WHERE FTB_Active__c = true),
        (SELECT FTB_Button__c,
        FTB_Message__c,
        FTB_Spinner__c
        FROM FTB_TileConfigurations__r
        WHERE FTB_Active__c = true)
        FROM FTB_CMT_Configurations__mdt
        WHERE FTB_Component__c = :componentName
        AND FTB_Active__c = true];
    }
    /**@frpanico
     * This method allows CometD to subscribe to a certain platform event
     * It makes a callout to SFDC requesting the access_token logging via a Platform Integration User
     */
    @AuraEnabled
    public static string handleCometdSubscription()
    {
        try
        {
            FTB_WS_Integration integration = new FTB_WS_Integration(FTB_ENM_Service.LOG_SFDC, true, true);
            
            // /* Make API call to connect to salesforce */
            // Http http = new Http();
            // FTB_WS_Utils calloutUtils = new FTB_WS_Utils('https://login.salesforce.com/services/oauth2/token','POST',12000,body);
            // HttpResponse response = calloutUtils.makeCallout();
            FTB_WRP_Utils.TokenResponse responseBody = getAccessToken(integration.execute()); //(FTB_WRP_Utils.TokenResponse) JSON.deserialize(response.getBody(), FTB_WRP_Utils.TokenResponse.class);

            return responseBody.access_token;
        }
        catch(Exception e)
        {
            throw new AuraHandledException('Unable to communicate with cloud. Please contact your administrator.');
        }
    }


    /*Interface methods*/
    public String setEndpoint(String endpoint)
    {
        return endpoint;
    }
    public String setBody()
    {
        FTB_CMT_IntegrationConfiguration__mdt integrationConfigurations = FTB_CMT_IntegrationConfiguration__mdt.getInstance('FTB_CometDSubscription');

        String CLIENT_ID = integrationConfigurations.FTB_ClassName__c;
        String CLIENT_SEC = integrationConfigurations.FTB_Endpoint__c;
        String USERNAME = integrationConfigurations.FTB_EnumService__c;
        String KEYWORD = integrationConfigurations.FTB_Method__c;

        return 'grant_type=password' + '&' + 'client_id='+CLIENT_ID+'&'+'client_secret='+CLIENT_SEC+'&'+'username='+USERNAME+'&'+'password='+KEYWORD;
    }
    public FTB_WRP_OperationResult handleResponse(String bodyResponse)
    {
        return new FTB_WRP_OperationResult(bodyResponse, '');
    }
    private static FTB_WRP_Utils.TokenResponse getAccessToken(FTB_WRP_OperationResult operationResult)
    {
        return (FTB_WRP_Utils.TokenResponse) JSON.deserialize(operationResult.ERROR_CODE, FTB_WRP_Utils.TokenResponse.class);
    }
    public void operate(List<FTB_WRP_Scope> scope)
    {
        return;
    }

}
