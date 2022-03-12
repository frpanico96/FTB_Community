/**@frpanico 2022-02-06
 * FTB
 * Start Page Component
 */
import { api, track } from 'lwc';
/* Import Utils Component */
import FtbUtils from 'c/ftbUtils';
/* Import lightning-emp-api */
import { subscribe,unsubscribe,onError,setDebugFlag,isEmpEnabled } from 'lightning/empApi';
/* Import Server-side */
import getAllPlayers from '@salesforce/apex/FTB_LC_StartPage.checkExistingPlayer';
import createPlayers from '@salesforce/apex/FTB_LC_StartPage.createPlayers';
import getListView from '@salesforce/apex/FTB_LC_StartPage.getListView';

/* Notification messages constants */
const NOTIFICATION_INFO_TITLE = 'Operation Started';
const NOTIFICATION_INFO_MESSAGE = 'Players are now being generated. At the end of the operation a notification messagge will appear';
const NOTIFICATION_INFO_VARIANT = 'info';
const NOTIFICATION_INFO_MODE = 'pester';

const NOTIFICATION_ERROR_TITLE = 'Error';
const NOTIFICATION_ERROR_VARIANT = 'error';

const NOTIFICATION_SUCCESS_TITLE = 'Success';
const NOTIFICATION_SUCCESS_VARIANT = 'success';
const NOTIFICATION_SUCCESS_MODE = 'pester';

const DEFAULT_BUTTON_MESSAGE = 'Players have already been generated. Start your own championship!';
const ERROR_BUTTON_MESSAGE = 'Players have not been correctly created. Please contact your administrator to start again the operation';

/* Platform event channel */
const PEV_CHANNEL = '/event/FTB_PEV_NotificationMessage__e';

export default class FtbStartPage extends FtbUtils {

    /* Header Variables */
    @track headerMessage = '';
    @track headerPosition = '';
    @track headerTextStyle = '';
    @track headerAdditionStyling = '';
    /* Tile Variables */
    @track messageConfiguration = '';
    @track buttonConfiguration = '';
    @track spinnerConfiguration = '';
    @track headerVisible;
    @track buttonVisible;
    @track buttonDisabled;
    @track buttonMessage;
    @track spinnerVisible;
    /* Subscription variables */
    @track subscription = {};
    /* Instances all the child elements */
    connectedCallback()
    {
        /* Erorr Listner setup */
        this.registerErrorListener();
        /* No logic needed for headerVisible and buttonVisible */
        this.headerVisible = true;
        this.buttonVisible = true;
        this.spinnerVisible = false;
        /* Check if the button need to be enabled */
        getAllPlayers({})
        .then(data => 
            {
                console.log('#FtbStartPage_getAllPlayers >>> ' + data);
                let wrpObj = JSON.parse(data);
                this.buttonDisabled = wrpObj.check;
                this.buttonMessage = wrpObj.message;
            })
        .catch(error => 
            {
                console.log('#FtbStartPage_getAllPlayersError >>> ' + error);
                this.buttonDisabled = true;
                this.buttonMessage = 'Unable to fetch data. Refresh the current page, if the error does not solve contact the product owner';
            });
        let componentName = this.getComponentName('c-ftb-start-page');
        console.log('#Component Name >>> ' + componentName);
        this.getConfigurationMessage(componentName)
        .then(result => 
            {
                console.log('#FtbStartPage Result >>>' + JSON.stringify(result));
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
    /* Button Click Event Handler
     * Make a server-side call
     * that fetch and create players
     */
    generatePlayers(event)
    {
        console.log('#FtbStartPage_generatePlayerStart >>> ' + event.detail);
        this.buttonDisabled = true;
        this.spinnerVisible = true;
        createPlayers({service: "GET_PLAYERS"})
        .then(result => 
            {
                let resultObj = JSON.parse(result);
                console.log('#FtbStartPage_resultObj >>> ' + JSON.stringify(resultObj));
                let success = resultObj["SUCCESS"];
                if(success === true)
                {
                    this.showMessage(NOTIFICATION_INFO_TITLE, NOTIFICATION_INFO_MESSAGE,NOTIFICATION_INFO_VARIANT,NOTIFICATION_INFO_MODE);
                    this.handleSubscribe();
                }
                else
                {
                    let errorMessage = resultObj["ERROR_MESSAGE"];
                    this.showMessage(NOTIFICATION_ERROR_TITLE,errorMessage,NOTIFICATION_ERROR_VARIANT);
                    this.buttonDisabled = false;
                    this.spinnerVisible = false;
                }
            })
        .catch(error => 
            {
                this.showMessage(NOTIFICATION_ERROR_TITLE,JSON.stringify(error),NOTIFICATION_ERROR_VARIANT);
                this.buttonDisabled = true;
                this.spinnerVisible = false;
            })
    }
    /* Subscription Hanlder */
    handleSubscribe()
    {

        /* Callback definition */
        const messageCallback = (response) => 
        {
            console.log('#FTBStartPage_SubscriptionCallBack >>> ' + JSON.stringify(response));
            /* Structure: {"data" : "schema":"", "payload":{platform event record} } */
            console.log('#FTBStartPage_SerializedResult >>> ' + response["data"]["payload"]["FTB_SerializedMessage__c"]);
            let serializedResult = response["data"]["payload"]["FTB_SerializedMessage__c"];
            let resultObj = JSON.parse(serializedResult);
            this.showMessage(NOTIFICATION_SUCCESS_TITLE,resultObj["ERROR_MESSAGE"],NOTIFICATION_SUCCESS_VARIANT,NOTIFICATION_SUCCESS_MODE);
            this.spinnerVisible = false;
            if(resultObj["SUCCESS"] === true)
            {
                this.buttonMessage = DEFAULT_BUTTON_MESSAGE;
                this.callNavigate();
            }
            else
            {
                this.buttonMessage = ERROR_BUTTON_MESSAGE
            }
            this.handleUnsubscribe();
        } 
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
    /* Unsubscription handler */
    handleUnsubscribe()
    {
        unsubscribe(this.subscription, (response) => { console.log('#FTBStartPage_Unsubscription >>> ' + JSON.stringify(response))});
    }
    /* Error register setup */
    registerErrorListener()
    {
        onError((error) => {console.log('#FTBStartPage_ErorrListener >>> ' + JSON.stringify(error))});
    }
    callNavigate()
    {
        console.log('### Testing Navigation ###');
        getListView({objectName: 'FTB_Player__c', developerNameBase: 'FTB'})
        .then(result => 
            { 
                console.log('#FTBStartPage_ListViewId >>> ' + result);
                //let navigationObj = '{"type":"standard__objectPage","attributes":{"objectApiName":"FTB_Player__c","actionName":"list"},"state":{"filterName":"'+result+'"}}';
                let navigationObj = {type: "standard__objectPage", attributes:{objectApiName:"FTB_Player__c",actionName:"list"},state:{filterName:result}};
                this.handleNavigation(JSON.stringify(navigationObj));
            }
        )
        .catch(error => 
            {
                console.log('Navigation Error >>> ' + error);
                this.showMessage(NOTIFICATION_ERROR_TITLE, JSON.stringify(error), NOTIFICATION_ERROR_VARIANT);
            }
        );
    }

}