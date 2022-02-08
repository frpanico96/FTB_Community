/**@frpanico 2022-02-06
 * FTB
 * Controller for
 * LWC ftbUtils
 */
public with sharing class FTB_LCR_Utils extends FTB_UTL_Utils
{

    @AuraEnabled
    public static String getConfiguration(String componentName)
    {
        FTB_WRP_Utils.ConfigurationWrapper wrpConfig = new FTB_WRP_Utils.ConfigurationWrapper();
        List<FTB_CMT_Configurations__mdt> configurations = retrieveConfiguration(componentName);
        /* Only one configurations is expected */
        for(FTB_CMT_Configurations__mdt	configuration : configurations)
        {
            wrpConfig.header.message = configuration.FTB_HeaderConfigurations__r[0].FTB_Message__c;
            wrpConfig.header.position = configuration.FTB_HeaderConfigurations__r[0].FTB_Position__c;
            wrpConfig.header.textStyle = configuration.FTB_HeaderConfigurations__r[0].FTB_TextStyle__c;
            wrpConfig.header.additionalStyling = configuration.FTB_HeaderConfigurations__r[0].FTB_AdditionalStyling__c;
            break;
        }   
        /* Utility log */
        System.debug(loggingLevel.DEBUG,'Wrapped configuration: ' + JSON.serialize(wrpConfig));
        /* A string is returned since the wrapped object
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
        WHERE FTB_Active__c = true)
        FROM FTB_CMT_Configurations__mdt
        WHERE FTB_Component__c = :componentName
        AND FTB_Active__c = true];
    }


}
