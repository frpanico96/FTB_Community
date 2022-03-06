/**@frpanico 2022-03-06
 * FTB
 * Query class for utility items
 */
public with sharing class FTB_QR_Utils extends FTB_UTL_Utils
{
    public List<FTB_FieldMapper__mdt> getMapper(String service)
    {
        return readSObject([SELECT FTB_IntegrationField__c,
        FTB_ObjectName__c,
        FTB_SfdcField__c,
        FTB_CharacterLink__c,
        FTB_FieldType__c
        FROM FTB_FieldMapper__mdt
        WHERE FTB_Service__c = :service]);
    }
}
