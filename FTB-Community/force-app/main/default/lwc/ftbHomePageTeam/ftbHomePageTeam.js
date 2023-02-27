/* @frpanico
* FTB Component for the Teams Page
*/
import { LightningElement, api, track } from 'lwc';

import FtbUtils from 'c/ftbUtils';

export default class FtbHomePageTeam extends FtbUtils
{

  @track loadingSpinner = true;

  @track fetchRequest = false;

  @track placeholderCombo = 'Select a Team...';
  @track optionTeams =
  [
    {label: 'Team 1', value: 'team1'},
    {label: 'Team 2', value: 'team2'},
    {label: 'Team 3', value: 'team3'},
  ];
  @track currentTeam = 'team1';
  
  @track placeHolderFormation = 'Pick a formation...';
  @track optionFormation =
  [
    {label: '2-2-1', value: 1},
    {label: '2-1-2', value: 2},
    {label: '1-2-2', value: 3},
    {label: '3-1-1', value: 4},
    {label: '1-3-1', value: 5},
    {label: '1-1-3', value: 6},
  ];
  @track currentFormation;

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
    this.loadingSpinner = false;
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
  handleFormationChange(event)
  {
    console.log('### Changing Formation...');

    let selectedValue =Number(event.detail.value);
    this.currentFormation = selectedValue;
    
    const playCourt = this.template.querySelector('c-ftb-play-court');
    playCourt.changeFormation(this.optionFormation[this.optionFormation.findIndex(el => el.value === selectedValue)].label);

    console.log('### Formation Changed');
  }
}