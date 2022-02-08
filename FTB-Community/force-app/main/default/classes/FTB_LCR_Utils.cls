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
        List<FTB_CMT_Configurations__mdt> configurations = FTB_CMT_Configurations__mdt.getAll().values();
        for(FTB_CMT_Configurations__mdt	configuration : configurations)
        {
            if(configuration.FTB_Component__c.equalsIgnoreCase(componentName))
            {
                wrpConfig.message = configuration.FTB_Message__c;
                break;
            }
        }
        /* Utility log */
        System.debug(loggingLevel.DEBUG,'Wrapped configuration: ' + JSON.serialize(wrpConfig));
        /* A string is returned since the wrapped object
        * Since the wrapped object is not recognized
        * by the client
        */
        return JSON.serialize(wrpConfig);
    }


}
