
/* @frpanico 2022-08-28
* FTB
* This component is thought to contain a single spinner
* With navigation mixin operation after a default time interval
* In order to redirect between different pages storing only necessary information
*/
import { NavigationMixin, CurrentPageReference } from 'lightning/navigation';
import { LightningElement, track, api, wire } from 'lwc';

/* Import Utils Component */
import FtbUtils from 'c/ftbUtils';

export default class FtbInBetweenOperation extends FtbUtils 
{
  @api payload;

  @track urlpayload;
  @track urlStateParameters;
  @track currentPageReference;
  @track pageName;

  @wire(CurrentPageReference)
  getStateParameters(currentPageReference)
  {
    if(currentPageReference)
    {
      this.urlStateParameters = currentPageReference.state;
      this.urlpayload = this.urlStateParameters['payload'];
      this.pageName = this.urlStateParameters['pageName'];
      if(this.urlpayload) 
      {
        setTimeout(() => {  this.navigateToNextPage() }, 3000);
      }
    }
  }

  navigateToNextPage()
  {
    console.log('In Between Starting Navigation');
    let navigationObj = {type: "comm__namedPage", attributes:{name:this.pageName}, state:{payload:this.urlpayload}};
    this.handleNavigation(JSON.stringify(navigationObj));
  }

}