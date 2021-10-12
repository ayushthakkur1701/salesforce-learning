import { LightningElement,track,wire } from 'lwc';
/* eslint-disable no-console */
 /* eslint-disable no-alert */
import getSessionDetails from '@salesforce/apex/mcNetworkSessionsController.getSessionDetails';

export default class McCommunityPage extends LightningElement {
    @track sessionsList = new Array();
    @track sessions;
    @track sessionsListSize=0;
    @track leftOrRight=false;
    @track error;

    constructor() {
        super();
        //do something
        this.handleLoad();
    }

    handleLoad() {

        getSessionDetails()
            .then(result => {
                this.sessions = result;
                console.log(this.sessions);
                
                for(var i =0;i<this.sessions.length;i++){
                    if(i % 2 === 0){
                        var session={};
                        session.align='left:0;';
                        session.sessionRecord=this.sessions[i];
                        console.log('left'+JSON.stringify(this.sessions[i]));
                        this.sessionsList.push(session);
                    }else{
                        var session={};
                        session.align='left:50%;';
                        session.sessionRecord=this.sessions[i];
                        console.log('right'+JSON.stringify(this.sessions[i]));
                        this.sessionsList.push(session);
                    }

                }
                console.log('All Session with Alignment'+JSON.stringify(this.sessionsList));
            })
            .catch(error => {
                this.error = error;
            });

            
    }
    
    
}