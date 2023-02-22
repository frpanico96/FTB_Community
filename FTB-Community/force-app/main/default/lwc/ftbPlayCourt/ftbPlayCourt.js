import { LightningElement, track, api } from 'lwc';

import FtbUtils from 'c/ftbUtils';

import courtBackground from '@salesforce/resourceUrl/FTB_CourtBackground';

export default class FtbPlayCourt extends FtbUtils
{

  @track imageUrl = courtBackground;

  @track formation = [
    {role: 'Center', Id: 1, iconName: 'utility:user', class: 'ftb-player ftb-center'},
    {role: 'Center', Id: 2, iconName: 'utility:user', class: 'ftb-player ftb-center'},
    {role: 'Center', Id: 3, iconName: 'utility:user', class: 'ftb-player ftb-center'},
    {role: 'Forward', Id: 4, iconName: 'utility:user', class: 'ftb-player ftb-forward'},
    {role: 'Forward', Id: 5, iconName: 'utility:user', class: 'ftb-player ftb-forward'},
    {role: 'Forward', Id: 6, iconName: 'utility:user', class: 'ftb-player ftb-forward'},
    {role: 'Guard', Id: 7, iconName: 'utility:user', class: 'ftb-player ftb-guard'},
    {role: 'Guard', Id: 8, iconName: 'utility:user', class: 'ftb-player ftb-guard'},
    {role: 'Guard', Id: 9, iconName: 'utility:user', class: 'ftb-player ftb-guard'},  
  ];

  get getBackgroundImage()
  {
    return `background-image:url("${this.imageUrl}")`;
  }

}