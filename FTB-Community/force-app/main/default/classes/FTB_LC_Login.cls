/**@frpanico 2022-06-23
 * Controller class
 * for the ftbLogin component
 */
public with sharing class FTB_LC_Login extends FTB_UTL_Utils
{
    private static FTB_UTL_Utils ftbUtils = new FTB_UTL_Utils();
    private static final String ERROR_MESSAGE = 'Unable to Login. Please contact the administrator.';
    private static final String CLIENT_ID = '3MVG9SOw8KERNN0.zFuqlJL348k1M6MUu2Nv4iZao0AE3rZvLPufePLMWY.81SzzQ5cs80QKEcqefCpmtKBJa';
    private static final String CLIENT_SEC = 'C4CA019DC255F7DFA96249A56ABCC1DD9D941F6D21E0D17C06912510A009F3CB';
    private static final String USERNAME = 'platuser@ftbstudio.dev.com';
    private static final String KEYWORD = 'ftbstudio00kjgyrnkE44oF4XMtp4z4QtkNd';

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
    @AuraEnabled
    public static string handleCometdSubscription(){
        try {
            /* Make API call to connect to salesforce */
            Http http = new Http();
            String body = 'grant_type=password' + '&' + 'client_id='+CLIENT_ID+'&'+'client_secret='+CLIENT_SEC+'&'+'username='+USERNAME+'&'+'password='+KEYWORD;
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
            req.setMethod('POST');
            req.setBody(body);
            HttpResponse res = http.send(req);

            String bodyResponse = res.getBody();
            TokenResponse response = (TokenResponse) JSON.deserialize(bodyResponse, TokenResponse.class);

            return response.access_token;
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
