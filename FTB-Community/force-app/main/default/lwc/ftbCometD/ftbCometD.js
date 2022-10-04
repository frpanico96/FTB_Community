import { LightningElement, api, track, wire } from 'lwc';

import { loadScript } from "lightning/platformResourceLoader";
import cometdLwc from '@salesforce/resourceUrl/CometD';
import getSessionId from '@salesforce/apex/FTB_LC_CometD.getSessionId';

export default class FtbCometD extends LightningElement 
{

  @api channel;

  @track libInitialized = false;
  @track sessionId;
  @track error; 


  /*
  @wire(getSessionId)
  wiredSessionId({error, data})
  {
    console.log('Wiring Data' + JSON.stringify(data));
    console.log('Param1 >>> ' +  window.location.protocol + '//' + window.location.hostname + '/cometd/51.0');
    if(data === null) 
    {
      this.sessionId = data;
      this.error = undefined;
      loadScript(this, cometdLwc)
      .then(() => {this.initializeCometD()})
    }
    else if(error)
    {
      console.log('error');
      this.error = error;
      this.sessionId = undefined;
    }
  }
  */
  
  @api
  cometdCallback = (sessionId) =>
  {
    console.log('SessionId => ' + sessionId);
    this.sessionId = sessionId;
    loadScript(this, cometdLwc)
    .then(() => {this.initializeCometD()});
  }

  initializeCometD = () => 
  {
    console.log('Initizalization');
    if(this.libInitialized) return;

    this.libInitialized = true;
    let cometdLib = new window.org.cometd.CometD();
    cometdLib.configure(
      {
        url: window.location.protocol + '//' + window.location.hostname + '/cometd/51.0',
        requestHeaders: {Authorization: 'OAuth ' + this.sessionId},
        appendMessageTypeToUrl: false,
        logLevel: 'debug'
      }
    );
    cometdLib.websocketEnabled = false;
    cometdLib.handshake((status) => 
    {
      console.log('Channel Name   ', this.channel);
      console.log('Status => ' + status.successful);
      if(status.successful)
      {
        cometdLib.subscribe(this.channel, (message) => 
        {
          console.log('### Subscribing')
          console.log('STATUSObj => ' + JSON.stringify(message));
          const selectedEvent = new CustomEvent('subscribemessage', {detail: message});
          this.dispatchEvent(selectedEvent);
        });
      }
      else
      {
        console.error('Error in handshaking');
      }
    })
  }

}