({
	doContactList : function(component, event, helper) {
        //Step 1
        var action = component.get('c.contactList');
    	var handleValue = component.get('v.recordId');
        //alert(handleValue);
        //step 2 to set parameter values of Apex method
        action.setParams({
            
            accId:handleValue,
        });

		//step 4         
        action.setCallback(this,function(response){
                          
            var responseValue= response.getReturnValue();
        	//console.log('responseValue ',responseValue);
            component.set('	v.contactList',responseValue);
            
         });
    
    	//Step 3 , second parameter for making server call in background
    	$A.enqueueAction(action,false);
	}
})