import { LightningElement, track, api } from 'lwc';

import FtbUtils from 'c/ftbUtils';

import courtBackground from '@salesforce/resourceUrl/FTB_CourtBackground';

export default class FtbPlayCourt extends FtbUtils
{

  @track imageUrl = courtBackground;

  @track formation = [
    {role: 'Center', Id: 1, iconName: 'utility:user', class: 'ftb-player ftb-center ftb-hidden'},
    {role: 'Center', Id: 2, iconName: 'utility:user', class: 'ftb-player ftb-center ftb-hidden'},
    {role: 'Center', Id: 3, iconName: 'utility:user', class: 'ftb-player ftb-center ftb-hidden'},
    {role: 'Forward', Id: 4, iconName: 'utility:user', class: 'ftb-player ftb-forward ftb-hidden'},
    {role: 'Forward', Id: 5, iconName: 'utility:user', class: 'ftb-player ftb-forward ftb-hidden'},
    {role: 'Forward', Id: 6, iconName: 'utility:user', class: 'ftb-player ftb-forward ftb-hidden'},
    {role: 'Guard', Id: 7, iconName: 'utility:user', class: 'ftb-player ftb-guard ftb-hidden'},
    {role: 'Guard', Id: 8, iconName: 'utility:user', class: 'ftb-player ftb-guard ftb-hidden'},
    {role: 'Guard', Id: 9, iconName: 'utility:user', class: 'ftb-player ftb-guard ftb-hidden'},  
  ];

  get getBackgroundImage()
  {
    return `background-image:url("${this.imageUrl}")`;
  }

  @api
  changeFormation(formation)
  {
    let parsedFormation = this.parseFormation(formation);
    this.setFormation(parsedFormation);
  }
  parseFormation(formation)
  {
    formation = formation.replaceAll('-','');
    return formation.split("").reverse()
  }
  setFormation(parsedFormation)
  {
    console.log('Start changing formation');
    for(let i = 0; i < parsedFormation.length; ++i)
    {
      if(parsedFormation[i] === '1')
      {
        this.deletePlayer(0 + (i * 3));
        this.spawnPlayer(1 + (i * 3));
        this.deletePlayer(2 + (i * 3));
      }
      else if(parsedFormation[i] === '2')
      {
        this.spawnPlayer(0 + (i * 3));
        this.deletePlayer(1 + (i * 3));
        this.spawnPlayer(2 + (i * 3));
      }
      else
      {
        this.spawnPlayer(0 + (i * 3));
        this.spawnPlayer(1 + (i * 3));
        this.spawnPlayer(2 + (i * 3));
      }
    }
  }
  spawnPlayer(position)
  {
    let obj = this.formation[this.formation.findIndex(el => el.Id === (position + 1))];
    obj.class = obj.class.replace('ftb-hidden', '');
  }
  deletePlayer(position)
  {
    let obj = this.formation[this.formation.findIndex(el => el.Id === (position + 1))];
    if(obj.class.indexOf('ftb-hidden') === -1)
    {
      obj.class += ' ftb-hidden';
    }
  }
}