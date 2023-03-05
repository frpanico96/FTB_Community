import { LightningElement, api, track } from 'lwc';

import FtbUtils from 'c/ftbUtils';

export default class FtbPlayerBox extends FtbUtils 
{
  @api playerOpts =
  [
    {label: 'Player Name 1', value: 'playerValue1', role: 'G', status: 'normal', iscpt: false},
    {label: 'Player Name 2', value: 'playerValue2', role: 'G', status: 'normal', iscpt: false},
    {label: 'Player Name 3', value: 'playerValue3', role: 'F', status: 'normal', iscpt: false},
    {label: 'Player Name 4', value: 'playerValue4', role: 'F', status: 'normal', iscpt: false},
    {label: 'Player Name 5', value: 'playerValue5', role: 'C', status: 'normal', iscpt: false},
  ]

  @track currentPlayer;
  @track role;

  handlePlayerChange(event)
  {
    console.log('#Event Datil: ' + JSON.stringify(event.detail));
    let currentIdx =  this.playerOpts.findIndex(el => el.value === event.detail.value);

    this.currentPlayer = event.detail.value;
    this.role = this.playerOpts[currentIdx].role;
  }
}