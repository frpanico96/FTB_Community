/**@frpanico
 * Container component for the Home Page Home
 * It contains the cometD component and the HomePageHome component
 */
import { LightningElement, api, track, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';

import cometDsubscription from '@salesforce/apex/FTB_LC_Utils.handleCometdSubscription';
import fetchData from '@salesforce/apex/FTB_LC_HomePageHome.fetchData';

/* Import Utils Component */
import FtbUtils from 'c/ftbUtils';

export default class FtbHomePageBody extends FtbUtils 
{
  @api homePage = false;

  @track sessionId;

  @track connState =
  [
   
  ]


  //@track focusObj = {home: 'c-ftb-home-page-home'};
  /**@frpanico
   * This method is aware of the page being rendered from the page state
   * Calls the main page child component to fetch/initialize data
   * It is used only on the first load, following page reloads are handled by
   * Connecting/Disconnecting events.
   */
  @wire(CurrentPageReference)
  currentPageParameters(currentPageReference)
  {
    if(currentPageReference)
    {
      console.log(currentPageReference);
      if(!currentPageReference.state) return;
      setTimeout(() => {
        console.log('### FocusObj: ' + JSON.stringify(this.focusObj));
        console.log('### MainObj: ' + this.focusObj[this.constantsObj.MAIN]);
        const componentObj = this.template.querySelector(this.focusObj[this.constantsObj.MAIN]);
        this.sessionId = currentPageReference.state['payload'];
        console.log('### SessionId: ' + this.sessionId);
        if(sessionStorage.getItem('state')) return;
        componentObj.homeInitialization(this.sessionId);
      }, 3000);
    }
  }
  /**@frpanico
   * On mount it starts the CometD subscription
   */
  connectedCallback()
  {
    console.log('@@@ Starting Connection');
    this.connState = [
      {name: this.constantsObj.MAIN, cmp: this.focusObj[this.constantsObj.MAIN], status: 0},
      {name: this.constantsObj.TEAMS, cmp: this.focusObj[this.constantsObj.TEAMS], status: 0},
      {name: this.constantsObj.STANDINGS, cmp: this.focusObj[this.constantsObj.STANDINGS], status: 0},
      {name: this.constantsObj.TRADES, cmp: this.focusObj[this.constantsObj.TRADES], status: 0},
      {name: this.constantsObj.PROFILE, cmp: this.focusObj[this.constantsObj.PROFILE], status: 0},
    ]
    this.handleStatusStorage();
    this.handleCometDSubscription();
  }
  /**@frpanico
   * Calls the subscription method for cometD
   */
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
  /**@frpanico
   * Catches the event fired from the Salesforce platform listened by CometD
   */
  handleSubscribeEvent(event)
  {
    const componentObj = this.template.querySelector(this.focusObj[this.constantsObj.MAIN]);
    componentObj.homeConfiguration(event);
  }
  /* This method handles connection and disconnction events
  * From child components
  * On refresh in order to allow the component to set the sessionId
  * The connection event needs to wait for it
  */
  handleConnectionEvent(event)
  {

    if(!sessionStorage.getItem('state')) return;

    console.log('### Connection Event --> ' + JSON.stringify(event));
    console.log('### Connection State --> ' + JSON.stringify(this.connState));

    if(event.type === 'disconnecting')
    {
      this.connState[this.connState.findIndex(el => el.name === event.detail)]['status'] = 0;
    }
    else if(event.type === 'connecting')
    {
      setTimeout( () => 
      {
        const currentCmp = this.connState[this.connState.findIndex(el => el.name === event.detail)];
        console.log(currentCmp);
        if(currentCmp['status'] === 0)
        {
          this.connState[this.connState.findIndex(el => el.name === event.detail)]['status'] = 1;
          const cmp = this.template.querySelector(currentCmp['cmp']);
          console.log(cmp);
          cmp.homeInitialization(this.sessionId);
        }
      }, 3000);
   }
  }
  /* Since on refresh the connectedCallback resets the connState
  * If the currentState is set on the main page its state is set to 0
  * In order to make the component reloads data
  */
  handleStatusStorage()
  {
    if(!sessionStorage.getItem('state')) return;
    let connObj = JSON.parse(sessionStorage.getItem('state'));
    if(connObj.mainpage) this.connState[this.connState.findIndex(el => el.name === this.constantsObj.MAIN)]['status'] = 0;
  }
}