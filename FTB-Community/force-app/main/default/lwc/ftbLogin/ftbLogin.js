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
                //this.registerErrorListener();
                //this.handleSubscribe();
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

    /* Event Methods */

    handleSubscribeEvent = (event) => 
    {
        console.log('### Subscribe Event => ' + JSON.stringify(event));
        let response = JSON.parse(event.detail.data.payload.FTB_SerializedMessage__c);
        console.log(response.SUCCESS);
        console.log(response.ERROR_MESSAGE);
        console.log(response.ERROR_DESCRIPTION);
        console.log(response.ERROR_CODE);
    }

    registerErrorListener()
    {
        onError((error) => {console.log('#FTBStartPage_ErorrListener >>> ' + JSON.stringify(error))});
    }
    handleSubscribe()
    {
        console.log('### Starting Event Attachment');
        /* Callback definition */
        const messageCallback = (response) => 
        {
            console.log('#FTBStartPage_SubscriptionCallBack >>> ' + JSON.stringify(response));
            /* Structure: {"data" : "schema":"", "payload":{platform event record} } */
            console.log('#FTBStartPage_SerializedResult >>> ' + response["data"]["payload"]["FTB_SerializedMessage__c"]);
            let serializedResult = response["data"]["payload"]["FTB_SerializedMessage__c"];
            let resultObj = JSON.parse(serializedResult);
            this.spinnerVisible = false;
            if(resultObj["SUCCESS"] === true)
            {
                this.showMessage(NOTIFICATION_SUCCESS_TITLE,resultObj["ERROR_MESSAGE"],NOTIFICATION_SUCCESS_VARIANT,NOTIFICATION_SUCCESS_MODE);
                this.handleLogin();
            }
            else
            {
                this.showMessage(NOTIFICATION_ERROR_TITLE,resultObj["ERROR_MESSAGE"],NOTIFICATION_ERROR_VARIANT);
                console.log('Enable Button Again');
                
            }
            this.handleUnsubscribe();
        }
        console.log('### Starting Subscription');
        subscribe(PEV_CHANNEL, -1, messageCallback)
        .then(response => 
            {
                console.log('#FTBStartPage_SubscriptionSent >>> ' +JSON.stringify(response.channel));
                this.subscription = response;
            }
        )
        .catch(error => 
            {
                console.log('#FTBStartPage_SubscriptionError >>> ' + JSON.stringify(error));
            }
        )
    }
    handleUnsubscribe()
    {
        unsubscribe(this.subscription, (response) => { console.log('#FTBStartPage_Unsubscription >>> ' + JSON.stringify(response))});
    }


}