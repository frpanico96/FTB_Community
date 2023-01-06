import { LightningElement, api, track } from 'lwc';
/* Import data fetcher */
import fetchData from '@salesforce/apex/FTB_LC_HomePageHome.fetchData';
/* Import Utils Component */
import FtbUtils from 'c/ftbUtils';

const CHAMPIONSHIP_RANK = 'championshipRank';
const CHAMPIONSHIP_NAME = 'championshipName';

export default class FtbHomePageHome extends FtbUtils
{

  @track championshipColumn = [];
  @track championshipObj = [];
  @track championshipData = [];
  @track championshipName = '';
  @track teamColumns = [];
  @track teamData = [];
  @track selectedTeam = [];
  @track nextMatchObj = [];
  @track nextMatchPayload = {}; 

  @track loadingSpinner = true;
  @track errorMessage;

  @api
  homeInitialization(sessionId)
  {
    if(!sessionId) return;
    fetchData({sessionId: sessionId})
    .then(data =>{
      console.log('@@@ Start Fetching');
    })
    .catch(error => {
      console.log('@@@ Error Fetching >>> ' + JSON.stringify(error));      
      this.showMessage('Error', error, 'error');
      this.loadingSpinner = false;
    });
  }
  @api
  homeConfiguration(event)
  {
    console.log('@@@ Home Subscribed >>> ' + JSON.stringify(event));
    let response = JSON.parse(event.detail.data.payload.FTB_SerializedMessage__c);
    console.log(response.SUCCESS);
    console.log(response.ERROR_MESSAGE);
    console.log(response.ERROR_DESCRIPTION);
    console.log(response.ERROR_CODE);
    console.log(response.IDENTIFICATION_KEY);
    if(response.SUCCESS)
    {
      let payload = JSON.parse(response.ERROR_DESCRIPTION);
      this.championshipColumn = payload.championshipColumns;
      this.teamColumns = payload.teamColumns;
     
      const teamObj = payload.teamsData;
      for(let singleTeam of teamObj)
      {
        Object.defineProperty(singleTeam, '_children', Object.getOwnPropertyDescriptor(singleTeam, 'children'));
      }
      console.log('@@@ After Renaming >>> ' + JSON.stringify(teamObj));
      this.teamData = teamObj;
      console.log(JSON.stringify(payload.championshipData[0]));
      console.log(JSON.stringify(payload.championshipData[0]['championshipRank']));
      console.log(JSON.stringify(payload.championshipData[0]['championshipName']));
      console.log(JSON.stringify(payload.nextMatchPayload[0]));
      this.championshipObj = payload.championshipData;
      this.setChampionshipInfo(payload.championshipData[0]);
      this.selectedTeam = [...this.selectedTeam, this.teamData[0]['id']];
      this.nextMatchObj = payload.nextMatchPayload;
      this.nextMatchPayload = payload.nextMatchPayload[0];
    }
    else
    {
      this.showError = response.ERROR_DESCRIPTION;
    }
    this.loadingSpinner = false;
  }
  setChampionshipInfo(championship)
  {
    this.championshipData = championship[CHAMPIONSHIP_RANK];
    this.championshipName = championship[CHAMPIONSHIP_NAME];
  }
  handleToggleEvent(event)
  {
    // console.log('Toggle Event --> ' + JSON.stringify(event.detail));
    // console.log('Toggle Event --> ' + JSON.stringify(event.detail.isExpanded));
    // console.log('Toggle Event --> ' + JSON.stringify(event.detail.row));
    // console.log('Toggle Event --> ' + JSON.stringify(event.detail.name));
    const eventDetail = event.detail;
    this.loadingSpinner = true;
    if(eventDetail.isExpanded)
    {
      this.selectedTeam = [eventDetail.name];
      let championshipId = eventDetail.row['championshipId'];
      const championship = this.championshipObj.find(el => el.id === championshipId);
      this.setChampionshipInfo(championship);
      this.nextMatchPayload = this.nextMatchObj.find(el => el.championshipId === championshipId);
    }
    this.loadingSpinner = false;
  }
}