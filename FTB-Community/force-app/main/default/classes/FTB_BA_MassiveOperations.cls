public with sharing class FTB_BA_MassiveOperations extends FTB_UTL_Utils implements Database.Batchable<Map<String,String>>{
    
    private List<Map<String,String>> integrationObjectList = new List<Map<String,String>>();
    private String service;
    
    public FTB_BA_MassiveOperations(List<Map<String,String>> integrationObjectList, String service) 
    {
        this.integrationObjectList = integrationObjectList;
        this.service = service;
    }

    public Iterable<Map<String,String>> start(Database.BatchableContext BC)
    {
        return this.integrationObjectList;
    }
    public void execute(Database.BatchableContext BC, List<Map<String,String>> scope)
    {
        List<FTB_CMT_FieldMapper__mdt> mapperList = new List<FTB_CMT_FieldMapper__mdt>();
        List<SObject> sobjList = new List<SObject>();
        FTB_QR_Utils utilsQr = new FTB_QR_Utils();

        mapperList = utilsQr.getMapper(this.service);
        for(Map<String,String> integrationObj : scope)
        {
            /* Instance SObject map */
            SObject sobj = Schema.getGlobalDescribe().get(mapperList[0].FTB_ObjectName__c).newSObject();
            for(FTB_CMT_FieldMapper__mdt mapper : mapperList)
            {
                /* Get Schema of the SObject and of all fields to check the type */
                Schema.SObjectType sobjType = Schema.getGlobalDescribe().get(mapper.FTB_ObjectName__c);
                Map<String,Schema.SObjectField> fieldsSchema = sobjType.getDescribe().fields.getMap();
                Schema.SoapType soapType = fieldsSchema.get(mapper.FTB_SfdcField__c).getDescribe().getSoapType();
                /* Populate the map */
                if(String.isNotBlank(mapper.FTB_IntegrationField__c) && String.isNotBlank(mapper.FTB_SfdcField__c))
                {
                    /* Concatenation makes sens only if the field is a String */
                    if(String.isNotBlank(mapper.FTB_CharacterLink__c))
                    {
                        sobj.put(mapper.FTB_SfdcField__c,tryParse(integrationObj.get(mapper.FTB_IntegrationField__c), soapType) + mapper.FTB_CharacterLink__c + ' ');
                    }
                    else
                    {
                        sobj.put(mapper.FTB_SfdcField__c,tryParse(integrationObj.get(mapper.FTB_IntegrationField__c), soapType));
                    }
                }
            }
            sobjList.add(sobj);
        }
        if(!sobjList.isEmpty())
        {
            insertSObject(sobjList);
        }
    }
    public void finish(Database.BatchableContext BC){}

}
