import { LightningElement, api, track } from 'lwc';
/* Import data fetcher */
import fetchData from '@salesforce/apex/FTB_LC_HomePageHome.fetchData';
/* Import Utils Component */
import FtbUtils from 'c/ftbUtils';

export default class FtbHomePageHome extends FtbUtils
{

  @track championshipColumn = [];
  @track championshipData = [];
  @track teamColumns = [];
  @track teamData = [];
  @track nextMatchPaylaod = []; 

  @track loadingSpinner = true;

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
      console.log(JSON.stringify(payload.nextMatchPaylaod[0]))
      this.championshipData = payload.championshipData[0]['championshipRank'];
      this.nextMatchPaylaod = payload.nextMatchPaylaod[0];
    }
    this.loadingSpinner = false;
  }
}