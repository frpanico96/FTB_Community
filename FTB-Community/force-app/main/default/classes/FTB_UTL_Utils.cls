/**@frpanico 2022-02-06 
 * FTB
 * Utility class
 * for common operations
*/
public virtual with sharing class FTB_UTL_Utils {

    private static FTB_QR_Utils utilsQr = new FTB_QR_Utils();

    /* Update Methods */
    protected void updateSObject(List<SObject> sobjList)
    {
        SObjectAccessDecision securityDecision = Security.stripInaccessible(AccessType.UPDATABLE, sobjList);
        update (securityDecision.getRecords()); 
    }
    protected void updateSObject(SObject sobj)
    {
        updateSObject(new List<SObject>{sobj});
    }

    /* Insert Methods */
    protected void insertSObject(List<SObject> sobjList)
    {
        SObjectAccessDecision securityDecision = Security.stripInaccessible(AccessType.CREATABLE, sobjList);
        insert (securityDecision.getRecords());
    }
    protected void insertSObject(SObject sobj)
    {
        insertSObject(new List<SObject>{sobj});
    }

    /* Delete Methods */
    protected void deleteSObject(List<SObject> sobjList)
    {
        List<SObject> sobjDelete = new List<SObject>();
        for(Sobject sobj : sobjList)
        {
            if(sobj.getSObjectType().getDescribe().isDeletable())
            {
                sobjDelete.add(sobj);
            }
        }
        if(!sobjDelete.isEmpty())
        {
            delete sobjDelete;
        }
    }
    protected void deleteSObject(SObject sobj)
    {
        deleteSObject(new List<SObject>{sobj});
    }

    /* Read Methods */
    protected List<SObject> readSObject(List<SObject> sobjList)
    {
        SObjectAccessDecision securityDecision = Security.stripInaccessible(AccessType.READABLE, sobjList);
        return securityDecision.getRecords();
    }
    protected List<SObject> readSObject(SObject sobj)
    {
        return readSObject(new List<SObject>{sobj});
    }

    /* This method maps field coming from integration to SObject */
    /* It takes in input the service and the response to map */
    /* Queries the custom metadata FTB_FieldMapper__mdt */
    /* Return instances of the SObject to map */
   protected List<SObject> mapFields(String service, List<Map<String,String>> integrationObjList)
    {
        List<FTB_CMT_FieldMapper__mdt> mapperList = new List<FTB_CMT_FieldMapper__mdt>();
        List<SObject> sobjList = new List<SObject>();

        mapperList = utilsQr.getMapper(service);
        for(Map<String,String> integrationObj : integrationObjList)
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
        return sobjList;
    }
    
    protected Object tryParse(Object field, Schema.SoapType soapType)
    {
        Object result; 
        try
        {
            switch on soapType{
                when DATE
                {
                    result =  dateConverter(field);
                }
                when INTEGER
                {
                    result = integerConverter(field);
                }
                when DOUBLE
                {
                    result = doubleConverter(field);
                }
                when STRING
                {
                    result = stringConverted(field);
                }
                when BOOLEAN
                {
                    result = booleanConverter(field);
                }
                when else
                {
                    result = null;
                }
            }
        }
        catch(Exception e)
        {
            //System.debug(LoggingLevel.DEBUG, 'Exception: ' + e.getMessage() + ' during conversion');
        }
        return result;
    }
    private Date dateConverter(Object field)
    {
        return Date.valueOf(field);
    }
    private Integer integerConverter(Object field)
    {
        return Integer.valueOf(field);
    }
    private Double doubleConverter(Object field)
    {
        return Double.valueOf(field);
    }
    private String stringConverted(Object field)
    {
        return String.valueOf(field);
    }
    private Boolean booleanConverter(Object field)
    {
        return Boolean.valueOf(field);
    }

}
