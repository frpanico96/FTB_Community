/**@frpanico 2022-02-15
 * FTB
 * Wrapper for the
 * Player Response
 */
public with sharing class FTB_WRP_Players 
{
    public League league;
    public class League
    {
        public List<Standard> standard;
    }
    public class Standard
    {
        public String firstName;
        public String lastName;
        public String temporaryDisplayName;
        public String personId;
        public String teamId;
        public Integer jersey;
        public Boolean isActive;
        public String pos;
        public Integer heightFeet;
        public Integer heightInches;
        public Decimal heightMeters;
        public Decimal weightPounds;
        public Decimal weightKilograms;
        public Date dateOfBirthUTC;
        public TeamSitesOnly teamSitesOnly;
        public List<Team> teams;
        public Draft draft;
        public Integer nbaDebutYear;
        public Integer yearsPro;
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
        public Integer seasonStart;
        public Integer seasonEnd;
    }
    public class Draft
    {
        public String teamId;
        public Integer pickNum;
        public Integer roundNum;
        public Integer seasonYear;
    }
}
