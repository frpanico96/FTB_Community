/**@frpanico 2022-06-07
 * FTB
 * Start Page Component
 */
import { LightningElement, api, track } from 'lwc';
/* Import Utils Component */
import FtbUtils from 'c/ftbUtils';
/* Class import */
import makeLogin from '@salesforce/apex/FTB_LC_Login.makeLogin';
import makeRegister from '@salesforce/apex/FTB_LC_Login.makeRegister';
/* Notification messages constants */
const NOTIFICATION_ERROR_TITLE = 'Error';
const NOTIFICATION_ERROR_VARIANT = 'error';

export default class FtbLogin extends FtbUtils 
{
    /* @api fields */
    /* @track fields */
    /* Header Variables */
    @track headerMessage = '';
    @track headerPosition = '';
    @track headerTextStyle = '';
    @track headerAdditionStyling = '';
    /* connected callback */
    connectedCallback()
    {
        /* get login message from configuration
        * 2022-06-07
        */
        let componentName = this.getComponentName('c-ftb-login');
        console.log('#Component Name >>> ' + componentName);
        this.getConfigurationMessage(componentName)
        .then(result => 
            {
                console.log('#FtbLoginPage Result >>>' + JSON.stringify(result));
                this.headerMessage = result.header.message;
                this.headerPosition = result.header.position;
                this.headerTextStyle = result.header.textStyle;
                this.headerAdditionStyling = result.header.additionalStyling;
                this.messageConfiguration = result.tile.message;
                this.buttonConfiguration = result.tile.button;
                this.spinnerConfiguration = result.tile.spinner;
            }
        )
        .catch(error => 
        {
            this.showMessage(NOTIFICATION_ERROR_TITLE,JSON.stringify(error),NOTIFICATION_ERROR_VARIANT);
        })
    }
    /* Login */
    handleLogin = event => 
    {
        console.log('### start login ###');
        makeLogin({credentials: event.detail})
        .then(result => 
            {
                console.log('### SuccessResult >>> ' + result);
            })
        .catch(error =>
            {
                console.log('### ErrorResult >>> ' + JSON.stringify(error));
            })
    }
    handleRegister = event =>
    {
        console.log('### start register ###');
        makeRegister({credentials: event.detail})
        .then(result => 
            {
                //this.handleLogin(event);
            }
        )
        .catch(error => 
          {
            console.log('### ErrorResult >>> ' + JSON.stringify(error));
          }  
        );
    }
}