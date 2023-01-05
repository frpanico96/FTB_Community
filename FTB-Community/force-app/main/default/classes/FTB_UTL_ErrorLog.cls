/**@frpanico 2023-01-05
 * Utility Class for the Erorr Log Custom Object
 * It is used to trace runtime server errors
 */
public with sharing class FTB_UTL_ErrorLog extends FTB_UTL_Utils 
{
    public FTB_UTL_ErrorLog(String service, String errorCode, String errorDescription)
    {
        insertSObject(new FTB_ErrorLog__c(FTB_Service__c = service,
            FTB_ErrorCode__c = errorCode, 
            FTB_ErrorDescription__c = errorDescription));
    }
    public FTB_UTL_ErrorLog(String service, String errorCode, String errorDescription, String request, String response)
    {
        insertSObject(new FTB_ErrorLog__c(FTB_Service__c = service, 
            FTB_ErrorCode__c = errorCode, 
            FTB_ErrorDescription__c = errorDescription,
            FTB_Request__c = request,
            FTB_Response__c = response));   
    }

}
