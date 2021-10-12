/* eslint-disable no-alert */
/* eslint-disable no-undef */
/* eslint-disable no-console */
import { LightningElement,track,api,wire } from 'lwc';
import findAccounts from '@salesforce/apex/LwcAccountController.findAccounts';
import fetchApprovalProcesses from '@salesforce/apex/LwcAccountController.fetchApprovalProcesses';
const DELAY = 350;
const columns = [
    { label: 'RELATED TO', fieldName: 'RelatedtoName', type: 'Text' },
    { label: 'Approver', fieldName: 'Actor', type: 'Text' },
    { label: 'Status', fieldName: 'Status', type: 'Text' },
    
];
export default class lwcFirstApp extends LightningElement {
    @api recordId;
    @api objectApiName;

    @track accounts;
    @track cbVal;
    @track error;
    @track listOfRecords;
    @track data = [];
    @track columns = columns;

    handleKeyChange(event) {
        // Debouncing this method: Do not actually invoke the Apex call as long as this function is
        // being called within a delay of DELAY. This is to avoid a very large number of Apex method calls.
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        // eslint-disable-next-line @lwc/lwc/no-async-operation
        this.delayTimeout = setTimeout(() => {
            
            findAccounts({ searchKey })
                .then(result => {
                    this.accounts = result;
                    this.error = undefined;
                })
                .catch(error => {
                    this.error = error;
                    this.accounts = undefined;
                });
        }, DELAY);
    }

   
    @wire (fetchApprovalProcesses,{recordId:'$recordId'}) parameters({error,data}){
        if(data){
            this.listOfRecords = data

        }
        if(error){
            this.error=error;
        }
    }
        
  

}