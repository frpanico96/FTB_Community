/**@frpanico 2022-02-15
 * FTB
 * Wrapper for the
 * Player Response
 */
public with sharing class FTB_WRP_Players extends FTB_WRP_Response
{
    public Internal internal;
    public League league;

    public class Internal
    {
        public String pubDateTime;
        public String igorPath;
        public String xslt;
        public String xsltForceRecompile;
        public String xsltInCache;
        public String xsltCompileTimeMillis;
        public String xsltTransformTimeMillis;
        public String consolidatedDomKey;
        public String endToEndTimeMillis;
        
    }
    public class League
    {
        public List<Player> standard;
        public List<Player> africa;
        public List<Player> sacramento;
        public List<Player> vegas;
        public List<Player> utah;

    }
    public class Player
    {
        public String firstName;
        public String lastName;
        public String temporaryDisplayName;
        public String personId;
        public String teamId;
        public String jersey;
        public Boolean isActive;
        public String pos;
        public String heightFeet;
        public String heightInches;
        public String heightMeters;
        public String weightPounds;
        public String weightKilograms;
        public String dateOfBirthUTC;
        public TeamSitesOnly teamSitesOnly;
        public List<Team> teams;
        public Draft draft;
        public String nbaDebutYear;
        public String yearsPro;
        public String collegeName;
        public String lastAffiliation;
        public String country;
    }
    public class TeamSitesOnly
    {
        public String playerCode;
        public String posFull;
        public String displayAffiliation;
        public String freeAgentCode;
    }
    public class Team 
    {
        public String teamId;
        public String seasonStart;
        public String seasonEnd;
    }
    public class Draft
    {
        public String teamId;
        public String pickNum;
        public String roundNum;
        public String seasonYear;
    }
}
