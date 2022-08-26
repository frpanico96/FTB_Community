/**@frpanico 2022-06-07
 * FTB
 * Start Page Component
 */
import { LightningElement, api, track } from 'lwc';
import { subscribe,unsubscribe,onError,setDebugFlag,isEmpEnabled } from 'lightning/empApi';
/* Import Utils Component */
import FtbUtils from 'c/ftbUtils';
/* Class import */
import makeRegisterLogin from '@salesforce/apex/FTB_LC_Login.makeRegisterLogin';
import handleCometdSubscription from '@salesforce/apex/FTB_LC_Login.handleCometdSubscription';
import StayInTouchSignature from '@salesforce/schema/User.StayInTouchSignature';
/* Notification messages constants */
const NOTIFICATION_ERROR_TITLE = 'Error';
const NOTIFICATION_ERROR_VARIANT = 'error';

const NOTIFICATION_SUCCESS_TITLE = 'Success';
const NOTIFICATION_SUCCESS_VARIANT = 'success';
const NOTIFICATION_SUCCESS_MODE = 'pester';

const PEV_CHANNEL = '/event/FTB_PEV_NotificationMessage__e';

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
                /* Event Attachment */
                this.handleCometdSubscription();


            }
        )
        .catch(error => 
        {
            this.showMessage(NOTIFICATION_ERROR_TITLE,JSON.stringify(error),NOTIFICATION_ERROR_VARIANT);
        })
    }

    handleCometdSubscription = () => 
    {
        handleCometdSubscription()
        .then(data => 
        {
            console.log('LoginResponse => ' + data);
            const cometDInitializer = this.template.querySelector('c-ftb-comet-d');
            cometDInitializer.cometdCallback(data);
        })
        .catch(error => 
            {
                console.log(error);
                this.showMessage('Error!',error,'error');
            }
        )
    }

    makeRegisterLogin = event =>
    {
        const credentials = event.detail;
        makeRegisterLogin({credentials: credentials})
        .then(data => 
        {
            console.log('LoginResponse => ' + data);
        })
        .catch(error => 
            {
                console.log(error);
                this.showMessage('Error!',error,'error');
            }
        )
    }

    handleLogin = sessionId =>
    {
        console.log('Work In Progress');
        console.log('Navigation Mixin');
    }
}