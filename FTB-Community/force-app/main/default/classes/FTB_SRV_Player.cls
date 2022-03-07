/**@frpanico 2022-03-07
 * FTB
 * Core class linked to the Object
 * FTB_Player__c
 */
public with sharing class FTB_SRV_Player extends FTB_UTL_Utils implements FTB_INF_FetchData,Queueable 
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
    public Map<String,String> handleResponse(String bodyResponse)
    {
        /* Variables Declaration */
        Map<String,String> integrationResult = new Map<String,String>();
        Map<String,String> playerInfo = new Map<String,String>();
        List<Map<String,String>> playerInfos = new List<Map<String,String>>();
        List<SObject> players = new List<SObject>();
    
        /* Deserialize response */
        FTB_WRP_Response response = (FTB_WRP_Players)JSON.deserialize(bodyResponse, FTB_WRP_Players.class);
        /* Only the standard field is taken in consideration
        * since it is the one that holds all the players
        */
        for(FTB_WRP_Players.Player singlePlayer : ((FTB_WRP_Players)response).League.standard)
        {
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
            playerInfos.add(playerInfo);
        }
        
        try
        {
            players = mapFields(String.valueOf(this.service), playerInfos);
            if(!players.isEmpty())
            {
                insertSObject(players);
                integrationResult.put('error','PLAYER_SUCCESS');
                integrationResult.put('errorcode','PLR-0000');

            }
        }
        catch(Exception e)
        {
            System.debug('Error: ' + e.getMessage() + '. At line: ' + e.getLineNumber() + '. The error occured during execution of: ' + this.service);
            integrationResult.put('error','PLAYERS_ERROR');
            integrationResult.put('errorcode','PLR-0001');
        }

        return integrationResult;
    }
}
