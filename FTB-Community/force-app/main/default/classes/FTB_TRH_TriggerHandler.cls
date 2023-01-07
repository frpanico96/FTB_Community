/**@frpanico
 * Virtual class for trigger handler
 * Expose a public method called run which calls the correct trigger event method
 * Event method can be overriden if custom logic needs to be applied
 */
public virtual class FTB_TRH_TriggerHandler extends FTB_UTL_Utils
{
    public virtual void run()
    {
        if(!Trigger.isExecuting) return;
        if(Trigger.isBefore)
        {
            if(Trigger.isInsert) beforeInsert();
            else if(Trigger.isUpdate) beforeUpdate();
            else if(Trigger.isDelete) beforeDelete();
            else return;
        }
        else if(Trigger.isAfter)
        {
            if(Trigger.isInsert) afterInsert();
            else if(Trigger.isUpdate) afterUpdate();
            else if(Trigger.isDelete) afterDelete();
            else if(Trigger.isUndelete) afterUndelete();
            else return;
        }
    }

    protected virtual void beforeInsert(){}
    protected virtual void beforeDelete(){}
    protected virtual void beforeUpdate(){} 
    protected virtual void afterInsert(){}
    protected virtual void afterUpdate(){}
    protected virtual void afterDelete(){}
    protected virtual void afterUndelete(){}
}
