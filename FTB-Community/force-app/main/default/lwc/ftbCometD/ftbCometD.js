/**@frpanico
 * CometD component
 * this components load the CometD library
 * Which is used to listen from external website (guest page included) 
 * Platform events fired from the Salesforce Platform
 */
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

  /**@frpanico
   * As soon as the sessionId is retrieved (access_token)
   * CometD can be intialized to subscribe to a platform event
   */
  @api
  cometdCallback = (sessionId) =>
  {
    console.log('SessionId => ' + sessionId);
    this.sessionId = sessionId;
    loadScript(this, cometdLwc)
    .then(() => {this.initializeCometD()});
  }
  /**@frpanico
   * This method allows CometD to subscribe
   * To a platform event and listen to it
   * When the event is received a custom event is fired
   */
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