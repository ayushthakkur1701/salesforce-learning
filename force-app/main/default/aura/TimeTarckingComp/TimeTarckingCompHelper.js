({
	initHelper:function(component,event,helper)
    {
        
        var action = component.get("c.getTimeTracking"); 
        
        action.setCallback(this, function(response) {
                var state = response.getState();
                 debugger;
                if (state === "SUCCESS") {
                console.log('Helper Time tracking');
                    
                }else {
                    
                    console.log('Error in Time Tracking');
                }
        });
        $A.enqueueAction(action);
    }
})