import { LightningElement, api, track, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';

import cometDsubscription from '@salesforce/apex/FTB_LC_Utils.handleCometdSubscription';
import fetchData from '@salesforce/apex/FTB_LC_HomePageHome.fetchData';

/* Import Utils Component */
import FtbUtils from 'c/ftbUtils';

export default class FtbHomePageBody extends FtbUtils 
{
  @api homePage = false;

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

  handleSubscribeEvent(event)
  {
    const componentObj = this.template.querySelector(this.focusObj['home']);
    componentObj.homeConfiguration(event);
  }


}