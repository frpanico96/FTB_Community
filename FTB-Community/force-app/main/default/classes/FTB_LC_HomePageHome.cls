public with sharing class FTB_LC_HomePageHome extends FTB_UTL_Utils
{
    @AuraEnabled
    public static String fetchData(String sessionId)
    {
      FTB_UTL_Utils utlClass = new FTB_UTL_Utils();
      List<FTB_Queue__c> queue = new List<FTB_Queue__c>
      {
        new FTB_Queue__c(FTB_Operation__c = String.valueOf(FTB_ENM_Service.FETCH_HOME),FTB_Payload__c = JSON.serialize(new Map<String, String>{'sessionId' => sessionId}))
      };

      utlClass.insertSObject(queue);

      return queue[0].Id;
    }
}
