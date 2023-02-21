import { LightningElement, track, api } from 'lwc';

import FtbUtils from 'c/ftbUtils';

import courtBackground from '@salesforce/resourceUrl/FTB_CourtBackground';

export default class FtbPlayCourt extends FtbUtils
{

  @track imageUrl = courtBackground;

  @track formation = [
    {role: 'Center', Id: 1},
    {role: 'Center', Id: 2},
    {role: 'Center', Id: 3},
    {role: 'Forward', Id: 4},
    {role: 'Forward', Id: 5},
    {role: 'Forward', Id: 6},
    {role: 'Guard', Id: 7},
    {role: 'Guard', Id: 8},
    {role: 'Guard', Id: 9},  
  ];

  get getBackgroundImage()
  {
    return `background-image:url("${this.imageUrl}")`;
  }

}