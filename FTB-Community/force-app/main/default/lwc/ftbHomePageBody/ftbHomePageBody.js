import { LightningElement, api } from 'lwc';

import cometDsubscription from '@salesforce/apex/FTB_LC_Utils.handleCometdSubscription';

/* Import Utils Component */
import FtbUtils from 'c/ftbUtils';

export default class FtbHomePageBody extends FtbUtils 
{
  @api homePage = false;

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

  handleSubscribeEvent()
  {
    console.log('@@@ Home Subscribed');
  }


}