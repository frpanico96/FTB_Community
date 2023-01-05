import { LightningElement, api, track } from 'lwc';
/* Import Utils Component */
import FtbUtils from 'c/ftbUtils';

DEFAULT_SPAN_CLASS = 'slds-icon_container slds-icon-utility-warning slds-var-m-right_x-small';
DEFAULT_ASSET_LOCATION = '/assets/icons/utility-sprite/svg/symbols.svg#warning';

export default class FtbAlertBanner extends FtbUtils
{

  @api utilityIcon;
  @api errorDescription= 'Generic error try contacting your Administrator.';

  @track iconSpanClass;
  @track iconAssetLocation;
  
  
  get iconSpanClass()
  {
    return this.utilityIcon ? 'slds-icon_container slds-icon-utility-'+this.utilityIcon+' sld-var-m-right_x-small' : DEFAULT_SPAN_CLASS;
  }
  get iconAssetLocation()
  {
    return this.utilityIcon ? '/assets/icons/utility-sprite/svg/symbols.svg#'+this.utilityIcon : DEFAULT_ASSET_LOCATION;
  }

}