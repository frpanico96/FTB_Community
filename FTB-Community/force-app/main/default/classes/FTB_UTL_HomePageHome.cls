public with sharing class FTB_UTL_HomePageHome 
{
    private static List<Map<String,String>> teamConfigMap = new List<Map<String,String>>
    {
      new Map<String,String>{'label' => 'Team', 'fieldName' => 'team'},
      new Map<String,String>{'label' => 'Position', 'fieldName' => 'position'},
      new Map<String,String>{'label' => 'Player', 'fieldName' => 'player'},
      new Map<String,String>{'label' => 'Score (AVG)', 'fieldName' => 'score'}
    };

    private static List<Map<String,String>> championshipConfigMap = new List<Map<String,String>>
    {
      new Map<String,String>{'label' => 'Rank', 'fieldName' => 'rank'},
      new Map<String,String>{'label' => 'Team', 'fieldName' => 'team'},
      new Map<String,String>{'label' => 'Win', 'fieldName' => 'win'},
      new Map<String,String>{'label' => 'Loss', 'fieldName' => 'loss'}
    };

    public static String fetchData(String sessionId)
    {
      try
      {
        return getHomeData(sessionId);
      }
      catch(Exception e)
      {
        new FTB_UTL_ErrorLog(String.valueOf(FTB_ENM_Service.FETCH_HOME), 'HOME-0001', e.getMessage() + ' At line: ' + e.getLineNumber());
        return '';
      }
    }

    private static String getHomeData(String sessionId)
    {
        Set<Id> championshipIds = new Set<Id>();
        FTB_WRP_Utils.HomePageHomeWrp result = new FTB_WRP_Utils.HomePageHomeWrp();
  
        List<FTB_Team__c> userTeam  = FTB_QR_Team.getTeamWithPlayersByUserSession(sessionId);
        for(FTB_Team__c team : userTeam)
        {
          championshipIds.add(team.FTB_Championship__c);
        }
        List<FTB_Championship__c> championshipList = FTB_QR_Championship.getChampionshipsWithTeamsByIdSet(championshipIds);
  
        result.teamColumns = createHeader(teamConfigMap);
        result.championshipColumns = createHeader(championshipConfigMap);
        result.teamsData = createTeamData(userTeam);
        result.championshipData = createChampionshipData(championshipList);
        result.nextMatchPaylaod = createCalendarData(championshipList, userTeam);
  
        return JSON.serialize(result);
    }

    private static List<FTB_WRP_Utils.ColumnHeaderWrp> createHeader(List<Map<String, String>> configMap)
    {
        List<FTB_WRP_Utils.ColumnHeaderWrp> result = new List<FTB_WRP_Utils.ColumnHeaderWrp>();
        for(Map<String,String> keyValueSet : configMap)
        {
          FTB_WRP_Utils.ColumnHeaderWrp singleCol = new FTB_WRP_Utils.ColumnHeaderWrp();
          singleCol.label = keyValueSet.get('label');
          singleCol.fieldName = keyValueSet.get('fieldName');
          result.add(singleCol);
        }

        return result;
    }
    private static List<FTB_WRP_Utils.HomePageHomeTeam> createTeamData(List<FTB_Team__c> teamList)
    {
        List<FTB_WRP_Utils.HomePageHomeTeam> result = new List<FTB_WRP_Utils.HomePageHomeTeam>();
        for(FTB_Team__c team : teamList)
        {
          FTB_WRP_Utils.HomePageHomeTeam singleData = new FTB_WRP_Utils.HomePageHomeTeam();
          List<FTB_WRP_Utils.HomePageHomePlayer> playersData = new List<FTB_WRP_Utils.HomePageHomePlayer>();
          singleData.id = team.Id;
          singleData.team = team.Name;
          for(FTB_Player__c player : team.FTB_Players__r)
          {
            FTB_WRP_Utils.HomePageHomePlayer singlePlayerData = new FTB_WRP_Utils.HomePageHomePlayer();
            singlePlayerData.player = player.FTB_FullName__c;
            singlePlayerData.position = player.FTB_Position__c;
            singlePlayerData.score = String.valueOf(player.FTB_Score__c);
            playersData.add(singlePlayerData);
          }
          singleData.children = playersData;
          result.add(singleData);
        }

        return result;
    }
    private static List<FTB_WRP_Utils.HomePageHomeChampionship> createChampionshipData(List<FTB_Championship__c> championshipList)
    {
        List<FTB_WRP_Utils.HomePageHomeChampionship> result = new List<FTB_WRP_Utils.HomePageHomeChampionship>();
        for(FTB_Championship__c championship : championshipList)
        {
          FTB_WRP_Utils.HomePageHomeChampionship singleChampionship = new FTB_WRP_Utils.HomePageHomeChampionship();
          singleChampionship.id = championship.Id;
          singleChampionship.championshipName = championship.Name;
          List<FTB_WRP_Utils.HomePageHomeChampionshipRank> ranks = new List<FTB_WRP_Utils.HomePageHomeChampionshipRank>();
          for(FTB_Team__c team : championship.FTB_Teams__r)
          {
            FTB_WRP_Utils.HomePageHomeChampionshipRank singleRank = new FTB_WRP_Utils.HomePageHomeChampionshipRank();
            singleRank.team = team.Name;
            singleRank.rank = String.valueOf(team.FTB_Ranking__c);
            singleRank.win  = String.valueOf(team.FTB_Win__c);
            singleRank.loss = String.valueOf(team.FTB_Loss__c);
            ranks.add(singleRank);
          }
          singleChampionship.championshipRank = ranks;
          result.add(singleChampionship);
        }

        return result;
    }
    private static List<FTB_WRP_Utils.HomePageHomeCalendar> createCalendarData(List<FTB_Championship__c> championshipList, List<FTB_Team__c> teamList)
    {
      List<FTB_WRP_Utils.HomePageHomeCalendar> result = new List<FTB_WRP_Utils.HomePageHomeCalendar>();
      for(FTB_Championship__c championship : championshipList)
      {
        for(FTB_Calendar__c calendar : championship?.FTB_Calendars__r)
        {
          for(FTB_Team__c singleTeam : teamList)
          {
            FTB_WRP_Utils.HomePageHomeCalendar nextOpponent= FTB_UTL_Calendar.getNextOpponent(calendar, singleTeam);
            if(nextOpponent != null)
            {
              result.add(FTB_UTL_Calendar.getNextOpponent(calendar, singleTeam));
            }
          }
        }
      }

      return result;
    }
}