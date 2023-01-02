import { LightningElement, api, track, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';

import cometDsubscription from '@salesforce/apex/FTB_LC_Utils.handleCometdSubscription';
import fetchData from '@salesforce/apex/FTB_LC_HomePageHome.fetchData';

/* Import Utils Component */
import FtbUtils from 'c/ftbUtils';

export default class FtbHomePageBody extends FtbUtils 
{
  @api homePage = false;

  // @track championshipColumn = [];
  // @track championshipData = [];
  // @track teamColumns = [];
  // @track teamData = [];

  @track focusObj = {home: 'c-ftb-home-page-home'};

  @wire(CurrentPageReference)
  currentPageParameters(currentPageReference)
  {
    if(currentPageReference)
    {
      console.log(currentPageReference);
      if(!currentPageReference.state) return;
      setTimeout(() => {
        const componentObj = this.template.querySelector(this.focusObj['home']);
        componentObj.homeInitialization(currentPageReference.state['payload']);
      }, 3000);
    }
  }

  connectedCallback()
  {
    console.log('@@@ Starting Connection');
    this.handleCometDSubscription();

  }

  handleCometDSubscription()
  {
    cometDsubscription()
    .then(data => 
      {
        console.log('@@@ Connection Succeded >>> ' + data);
        const cometDInitializer = this.template.querySelector('c-ftb-comet-d');
        cometDInitializer.cometdCallback(data);
      })
    .catch(error => 
      {
        console.log('@@@ Connection Error >>> ' + JSON.stringify(error));
        this.showMessage('Error',error, 'error');
      })
  }

  // handleDataFetch(sessionId)
  // {
  //   console.log('@@@ SessionId >>> ' + sessionId);
  //   fetchData({ sessionId: sessionId})
  //   .then(() => 
  //   {
  //     console.log('@@@ Start Fetching');
  //   })
  //   .catch(error => 
  //   {
  //       console.log('@@@ Error Fetching >>> ' + JSON.stringify(error));
  //       this.showMessage('Error', error, 'error');
  //   });
  // }

  handleSubscribeEvent(event)
  {
    const componentObj = this.template.querySelector(this.focusObj['home']);
    componentObj.homeConfiguration(event);
    // console.log('@@@ Home Subscribed >>> ' + JSON.stringify(event));
    // let response = JSON.parse(event.detail.data.payload.FTB_SerializedMessage__c);
    // console.log(response.SUCCESS);
    // console.log(response.ERROR_MESSAGE);
    // console.log(response.ERROR_DESCRIPTION);
    // console.log(response.ERROR_CODE);
    // console.log(response.IDENTIFICATION_KEY);
    // if(response.SUCCESS)
    // {
    //   let payload = JSON.parse(response.ERROR_DESCRIPTION);
    //   this.championshipColumn = payload.championshipColumns;
    //   this.teamColumns = payload.teamColumns;

    //   const teamObj = payload.teamsData;
    //   for(let singleTeam of teamObj)
    //   {
    //     Object.defineProperty(singleTeam, '_children', Object.getOwnPropertyDescriptor(singleTeam, 'children'));
    //   }
    //   console.log('@@@ After Renaming >>> ' + JSON.stringify(teamObj));
    //   this.championshipTable = payload.championshipData[0];
    // }
  }


}