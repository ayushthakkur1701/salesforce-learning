({
    handleCreateContact : function(component, event, helper) {
        var accid = component.get('v.recordId');
        var action = component.get('c.createContact');
        var contactDetails = component.get('v.createContact');
        var validcontactFields = component.find('contactFields').reduce(function(validsoFar,inputCmp){
                        	inputCmp.showHelpMessageIfInvalid();
        					inputCmp.set('v.validity',{valid:false,badInput:true});
        					return validsoFar && inputCmp.get('v.validity').valid;
                            },true);
        
        if(validcontactFields){
           alert(validcontactFields);
            action.setParams({
                con:contactDetails,
                accountId:accid
                
            });
            debugger;
            action.setCallback(this,function(response){
                var state = response.getState();
                alert(state);
                if(state==='SUCCESS' || state==='DRAFT'){
                    var responseValue = response.getReturnValue();
                    alert(responseValue);
                }else if(state==='INCOMPLETE'){
                    
                }else if(state==='ERROR'){
                    var errors = reponse.getError();
                    console.log('errors: ',errors);
                    //component.set('v.errorMsg',errors[0].pageErrors.message);
                }
            },'ALL');
              
        }else{
            alert('Please fill all the fields'+ validcontactFields);
        }
        
        $A.enqueueAction(action,false);
    }
})