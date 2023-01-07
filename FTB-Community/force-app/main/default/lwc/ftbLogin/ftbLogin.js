/**@frpanico 2022-06-07
 * FTB
 * Start Page Component
 */
import { LightningElement, api, track } from 'lwc';
/* Import Utils Component */
import FtbUtils from 'c/ftbUtils';
/* Class import */
import makeRegisterLogin from '@salesforce/apex/FTB_LC_Login.makeRegisterLogin';
import handleCometdSubscription from '@salesforce/apex/FTB_LC_Utils.handleCometdSubscription';
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
    /* State Variables */
    @track username = '';
    @track loadingSpinner = false;
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
    /**@frpanico
     * This method initialize CometD Subscription
     */
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
    /**@frpanico
     * This method start the login/registration
     * Operations
     */
    makeRegisterLogin = event =>
    {
        this.loadingSpinner = true;
        const credentials = event.detail;
        let obj = JSON.parse(credentials);
        this.username = obj["username"];
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

    /* Event Methods */
    handleSubscribeEvent = (event) => 
    {
        console.log('### Subscribe Event => ' + JSON.stringify(event));
        let response = JSON.parse(event.detail.data.payload.FTB_SerializedMessage__c);
        console.log(response.SUCCESS);
        console.log(response.ERROR_MESSAGE);
        console.log(response.ERROR_DESCRIPTION);
        console.log(response.ERROR_CODE);
        console.log(response.IDENTIFICATION_KEY);
        console.log(this.username);
        this.loadingSpinner = false;
        if(this.username !== response.IDENTIFICATION_KEY) return;
        if(response.SUCCESS)
        {
            this.showMessage(NOTIFICATION_SUCCESS_TITLE, response.ERROR_MESSAGE, NOTIFICATION_SUCCESS_VARIANT, NOTIFICATION_SUCCESS_MODE);
            this.handleLogin(response.ERROR_DESCRIPTION);
        }
        else
        {
            this.showMessage(NOTIFICATION_ERROR_TITLE, response.ERROR_MESSAGE, NOTIFICATION_ERROR_VARIANT);
        }
        return;

    }

    /**@frpanico
     * This method redirects to the home page
     */
    handleLogin = sessionId =>
    {
        console.log('Starting Navigation');
        let navigationObj = {type: "comm__namedPage", attributes:{name:"FTB_PreLogin__c"}, state:{payload:sessionId, pageName:'FTB_HomePage__c'}};
        this.handleNavigation(JSON.stringify(navigationObj));
    }



}