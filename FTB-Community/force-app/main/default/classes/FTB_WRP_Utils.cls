/**@frpanic 2022-02-06
 * FTB
 * Utils Wrapper
 */
public with sharing class FTB_WRP_Utils 
{
    /* Configuration Wrapper */
    public class ConfigurationWrapper
    {
        /* Member Variables */
        public ConfigurationHeader header;
        public ConfigurationTile tile;
        /* Constructor */
        public ConfigurationWrapper()
        {
            this.header = new ConfigurationHeader();
            this.tile = new ConfigurationTile();
        }
    }
    /* Configuration Header */
    public class ConfigurationHeader
    {
        /* Member Variables */
        public String message;
        public String position;
        public String textStyle;
        public String additionalStyling;
        /* Constructor */
        public ConfigurationHeader()
        {
            this.message = '';
            this.position = '';
            this.textStyle = '';
            this.additionalStyling = '';
        }
    }
    /* Configuration Tile */
    public class ConfigurationTile
    {
        /* Member Variables */
        public String message;
        public String button;
        public String spinner;
        /* Constructor */
        public ConfigurationTile()
        {
            this.message = '';
            this.button = '';
            this.spinner = '';
        }
    }
    /* Generic Wrapper for ftbStartPage */
    public class StartPageWrp
    {
        /* Member Variables */
        public Boolean check;
        public String message;
        /* Constructor */
        public StartPageWrp()
        {
            this.check = false;
            this.message = '';
        }
    }
    public class TokenResponse
    {
        public String access_token;
        public String instance_url;
        public String id;
        public String token_type;
        public String issued_at;
        public String signature;
    }
    public class ColumnHeaderWrp
    {
        public String label;
        public String fieldName;
    }
    public class HomePageHomeWrp
    {
        public List<ColumnHeaderWrp> teamColumns;
        public List<ColumnHeaderWrp> championshipColumns;
        public List<HomePageHomeTeam> teamsData;
        public List<HomePageHomeChampionship> championshipData;
        public List<HomePageHomeCalendar> nextMatchPayload;
    }
    public class HomePageHomeTeam
    {
        public String id;
        public String team;
        public String championshipId;
        public List<HomePageHomePlayer> children;
    }
    public class HomePageHomePlayer
    {
        public String position;
        public String player;
        public String score;
    }
    public class HomePageHomeChampionship
    {
        public String id;
        public String championshipName;
        public List<HomePageHomeChampionshipRank> championshipRank;
    }
    public class HomePageHomeChampionshipRank
    {
        public String rank;
        public String team;
        public String win;
        public String loss;
    }
    public class HomePageHomeCalendar
    {
        public String championshipId;
        public String homeAway;
        public String nextOpponent;
    }
    public class CalendarObj
    {
        public String homeId;
        public String awayId;
        public String home;
        public String away;
    }
}
