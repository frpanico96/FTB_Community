/**@frpanico 2022-03-07
 * FTB
 * Core class linked to the Object
 * FTB_Player__c
 */
public with sharing class FTB_SRV_Player extends FTB_UTL_Utils implements FTB_INF_FetchData
{
    /* Member variables */
    private FTB_ENM_Service service = FTB_ENM_Service.GET_PLAYERS;
    public String setEndpoint(String endpoint)
    {
        return 'Callout:FTB_BasePath'+endpoint;
    }
    public String setBody()
    {
        return '';
    }
    /* The method get mapped data */
    public FTB_WRP_OperationResult handleResponse(String bodyResponse)
    {
        /* Variables Declaration */        
        List<FTB_WRP_Scope> playerInfos = new List<FTB_WRP_Scope>();
        List<SObject> players = new List<SObject>();
    
        /* Deserialize response */
        FTB_WRP_Response response = (FTB_WRP_Players)JSON.deserialize(bodyResponse, FTB_WRP_Players.class);
        /* Only the standard field is taken in consideration
        * since it is the one that holds all the players
        */
        for(FTB_WRP_Players.Player singlePlayer : ((FTB_WRP_Players)response).League.standard)
        {
            Map<String,String> playerInfo = new Map<String,String>();
            FTB_WRP_Scope playerInfoScope = new FTB_WRP_Scope();
            playerInfo.put('firstName',singlePlayer.firstName);
            playerInfo.put('lastName',singlePlayer.lastName);
            playerInfo.put('personId',singlePlayer.personId);
            playerInfo.put('teamId',singlePlayer.teamId);
            playerInfo.put('jersey',singlePlayer.jersey);
            playerInfo.put('isActive',singlePlayer.isActive);
            playerInfo.put('pos',singlePlayer.pos);
            playerInfo.put('heightFeet',singlePlayer.heightFeet);
            playerInfo.put('heightInches',singlePlayer.heightInches);
            playerInfo.put('heightMeters',singlePlayer.heightMeters);
            playerInfo.put('weightPounds',singlePlayer.weightPounds);
            playerInfo.put('weightKilograms',singlePlayer.weightKilograms);
            playerInfo.put('dateOfBirthUTC',singlePlayer.dateOfBirthUTC);
            playerInfoScope.integrationObj = playerInfo;
            playerInfos.add(playerInfoScope);
        }
        
        Id batchJobId = Database.executeBatch(new FTB_BA_MassiveOperations(playerInfos,String.valueOf(this.service)), 100);

        if(batchJobId != null && String.isNotBlank(batchJobId))
        {
            return new FTB_WRP_OperationResult('PLR-0000','SUCCESS');
        }
        else
        {
            return new FTB_WRP_OperationResult('PLR-0001','Failure during operation start');
        }
    }
    /* Method that maps and create
    * instances of Players
    * and insert them
    * This method gets called from the batch
    * MassiveOperations
    */
    public void operate(List<FTB_WRP_Scope> scope)
    {
        List<FTB_CMT_FieldMapper__mdt> mapperList = new List<FTB_CMT_FieldMapper__mdt>();
        List<SObject> sobjList = new List<SObject>();
        FTB_QR_Utils utilsQr = new FTB_QR_Utils();

        mapperList = utilsQr.getMapper(String.valueOf(this.service));
        for(FTB_WRP_Scope singleScope : scope)
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
                    /* Write the field only if the integration field value is no empty */
                    if(String.isNotEmpty(singleScope.integrationObj.get(mapper.FTB_IntegrationField__c))){
                        /* Concatenation makes sens only if the field is a String */
                        if(String.isNotBlank(mapper.FTB_CharacterLink__c))
                        {
                            if(String.isEmpty((String)sobj.get(mapper.FTB_SfdcField__c)))
                            {
                                sobj.put(mapper.FTB_SfdcField__c,tryParse(singleScope.integrationObj.get(mapper.FTB_IntegrationField__c), soapType) + mapper.FTB_CharacterLink__c + ' ');
                            }
                            else
                            {
                                sobj.put(mapper.FTB_SfdcField__c,((String)sobj.get(mapper.FTB_SfdcField__c))+(tryParse(singleScope.integrationObj.get(mapper.FTB_IntegrationField__c), soapType) + mapper.FTB_CharacterLink__c));
                            }
                        }
                        else
                        {
                            sobj.put(mapper.FTB_SfdcField__c,tryParse(singleScope.integrationObj.get(mapper.FTB_IntegrationField__c), soapType));
                        }
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
}
