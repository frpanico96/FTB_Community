/**@frpanico 2022-06-23
 * Controller class
 * for the ftbLogin component
 */
public with sharing class FTB_LC_Login extends FTB_UTL_Utils
{
    private static FTB_UTL_Utils ftbUtils = new FTB_UTL_Utils();
    private static final String ERROR_MESSAGE = 'Unable to Login. Please contact the administrator.';

    /* Api method called from client */
    @AuraEnabled
    public static string makeRegisterLogin(String credentials){
        try {
            return makeRegisterLoginOperations(credentials);            
        } catch (Exception e) {
            System.debug(LoggingLevel.DEBUG, e.getMessage() + ' At line ' + e.getLineNumber());
            throw new AuraHandledException(ERROR_MESSAGE);
        }
    }

    private static String makeRegisterLoginOperations(String credentials)
    {
        Map<String, String> credentialsMap = (Map<String,String>) JSON.deserialize(credentials, Map<String,String>.class);
        FTB_Queue__c que = new FTB_Queue__c();

        que.FTB_Payload__c = credentials;
        que.FTB_Operation__c = String.valueOf(FTB_ENM_Service.SIGN);

        ftbUtils.insertSObject(que);

        return que.Id;
    }

    class TokenResponse 
    {
        String access_token;
        String instance_url;
        String id;
        String token_type;
        String issued_at;
        String signature;
    }
}
