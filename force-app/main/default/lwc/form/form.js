/* eslint-disable no-return-assign */
/* eslint-disable no-alert */
import { LightningElement,track } from 'lwc';

export default class Form extends LightningElement {
    @track firstName;  
    handleFirstName=(event)=>{
        if(event.target.name ==='First Name'){
            this.firstName = event.target.value;
        }
        
        
    }

    handleClick=()=>{
        alert(this.firstName);
        this.firstName ='';
    }
}