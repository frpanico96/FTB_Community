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
        Database.update(securityDecision.getRecords()); 
    }
    protected void updateSObject(SObject sobj)
    {
        updateSObject(new List<SObject>{sobj});
    }

    /* Insert Methods */
    protected void insertSObject(List<SObject> sobjList)
    {
        SObjectAccessDecision securityDecision = Security.stripInaccessible(AccessType.CREATABLE, sobjList);
        Database.insert(securityDecision.getRecords());
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
            Database.delete(sobjDelete);
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
        return Date.valueOf(String.valueOf(field));
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
