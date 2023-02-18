/**@frpanico 2022-06-07
 * FTB
 * Home Page Component
 */
import { LightningElement, api, track } from 'lwc';
/* Import Utils Component */
import FtbUtils from 'c/ftbUtils';
export default class FtbHomePage extends FtbUtils
{
  @track navObj =
  [
    {name: 'main', label: 'Home'},
    {name: 'teams', label: 'Teams'},
    {name: 'standings', label: 'Standings'},
    {name: 'trades', label: 'Trades'},
  ]

  @track homePage = {}

  connectedCallback()
  {
    if(sessionStorage.getItem('state'))
    {
      this.homePage = JSON.parse(sessionStorage.getItem('state'));
      console.log(JSON.stringify(this.homePage));
      return;
    }
    this.homePage.mainpage = true;
    this.homePage.teamspage = false;
    this.homePage.standingpage = false;
    this.homePage.tradepage = false;
    this.homePage.profilepage = false;
    return;
  }


  handleNavigation(event)
  {
    console.log(event.detail);
    switch (event.detail)
    {
      case this.constantsObj.MAIN:
        this.homePage.mainpage = true;
        this.homePage.teamspage = false;
        this.homePage.standingpage = false;
        this.homePage.tradepage = false;
        this.homePage.profilepage = false;
        break;
      case this.constantsObj.TEAMS:
        this.homePage.mainpage = false;
        this.homePage.teamspage = true;
        this.homePage.standingpage = false;
        this.homePage.tradepage = false;
        this.homePage.profilepage = false;    
        break;
      case this.constantsObj.STANDINGS:
        this.homePage.mainpage = false;
        this.homePage.teamspage = false;
        this.homePage.standingpage = true;
        this.homePage.tradepage = false;
        this.homePage.profilepage = false;
        break;
      case this.constantsObj.TRADES:
        this.homePage.mainpage = false;
        this.homePage.teamspage = false;
        this.homePage.standingpage = false;
        this.homePage.tradepage = true;
        this.homePage.profilepage = false;
        break;
      case this.constantsObj.PROFILE:
        this.homePage.mainpage = false;
        this.homePage.teamspage = false;
        this.homePage.standingpage = false;
        this.homePage.tradepage = false;
        this.homePage.profilepage = true;
        break;
    }
    console.log('### HomePage state: ' + JSON.stringify(this.homePage));
    this.setSessionStorage();
  }

  setSessionStorage()
  {
    console.log(JSON.stringify(this.homePage));
    sessionStorage.setItem('state', JSON.stringify(this.homePage));
    console.log(JSON.stringify(sessionStorage.getItem('state')));
  }
}