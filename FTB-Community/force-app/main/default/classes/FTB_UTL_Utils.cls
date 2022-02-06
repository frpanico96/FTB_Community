/**@frpanico 2022-02-06 
 * FTB
 * Utility class
 * for common operations
*/
public virtual with sharing class FTB_UTL_Utils {

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
}
