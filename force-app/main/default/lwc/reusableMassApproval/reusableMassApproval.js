import { LightningElement ,track,wire} from 'lwc';
import findAccounts from '@salesforce/apex/AccountController.findAccounts';
import getFieldSetMember from '@salesforce/apex/AccountController.getFieldSetMember';
import submitRecordsApproval from '@salesforce/apex/AccountController.submitRecordsApproval';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


var totalSelectedRecordids =[];
var totalSelectedRecords = [];
export default class ReusableMassApproval extends LightningElement {
  
    @track columns= new Array();
    @track error;
    @track data ;
    @track rowOffset =0;
    //totalSelectedRecords = new Array();
    @track fields;
    @track messageOnSubmit='';

    //getFieldSetMember
    @wire(getFieldSetMember) wireColumnsNamesFromFieldset({error,data}){
        if(data){
            var jsonData = JSON.parse(data);
            var columnsName = [];
            for (var i = 0; i < jsonData.length; i++) {
                var counter = jsonData[i];
                var columnsValue = {};
                columnsValue.label = counter.fieldLabel;
                columnsValue.fieldName = counter.fieldAPIName;
                columnsValue.type = counter.fieldType;
                columnsValue.editable = true;
                
                columnsName.push(columnsValue);
            }
            this.columns = columnsName;
        }else if(error){
            this.error = error;
            
        }
    }

    @wire(findAccounts) wireReusable({error,data}){
        if(data){
           
            this.data = data;
            //console.log(data);
            //console.log(JSON.stringify(data, null, '\t'));
        }else if(error){
            this.error = error;
        }
    }


    


    getSelectedRecord=(event)=>{
        const selectedRows = event.detail.selectedRows;
 
        for (let i = 0; i < selectedRows.length; i++){

            totalSelectedRecordids.push(selectedRows[i].Id);//totalSelectedRecords
            totalSelectedRecords.push(selectedRows[i]);
        }
        console.log('totalSelectedRecordids '+totalSelectedRecordids);
    }
   
    
    wireSubmitRecordsForApproval(){
        submitRecordsApproval({recIdList:totalSelectedRecordids,submitComment:'Records Submitted'})
            .then(result => {
                console.log('data for table1 '+this.data.length);
                /*for (let i = 0; i < totalSelectedRecords.length; i++){

                    this.data.pop(totalSelectedRecords[i]);
        
                }
                console.log('data for table2 '+this.data.length);*/
                this.messageOnSubmit = result;
                alert("Success");
                /*const event = new ShowToastEvent({
                    title: 'Success',
                    message: this.messageOnSubmit+'',
                });
                this.dispatchEvent(event);*/
            })
            .catch(error => {
                this.messageOnSubmit = error;
                alert("Fail");
                /*console.log(JSON.stringify(error));
                const event = new ShowToastEvent({
                    title: 'Error',
                    message: this.messageOnSubmit+'',
                });
                this.dispatchEvent(event);*/
            });
  
    }

}