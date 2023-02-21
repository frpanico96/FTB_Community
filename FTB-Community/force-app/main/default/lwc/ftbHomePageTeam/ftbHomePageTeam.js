/* @frpanico
* FTB Component for the Teams Page
*/
import { LightningElement, api, track } from 'lwc';

import FtbUtils from 'c/ftbUtils';

export default class FtbHomePageTeam extends FtbUtils
{

  @track fetchRequest = false;

  @track placeholderCombo = 'Select a Team...';
  @track optionTeams =
  [
    {label: 'Team 1', value: 'team1'},
    {label: 'Team 2', value: 'team2'},
    {label: 'Team 3', value: 'team3'},
  ];
  @track currentTeam = 'team1';
  
  connectedCallback()
  {
    console.log('### Team Connecting...');
    this.dispatchEvent(new CustomEvent('connecting', {detail: this.constantsObj.TEAMS}));
  }
  disconnectedCallback()
  {
    console.log('### Team Disconnecting...');
    this.dispatchEvent(new CustomEvent('disconnecting', {detail: this.constantsObj.TEAMS}));
    
  }
  @api 
  homeInitialization(sessionId)
  {
    if(!sessionId) return;
    if(this.fetchRequest) return;

    this.fetchRequest = true;

    console.log('### Fetching Team...');
  }
  @api
  homeConfiguration(event)
  {
    console.log('### Configurating Team...');
  }

  handleTeamChange(event)
  {
    console.log('### Changing Team...');
  }
}