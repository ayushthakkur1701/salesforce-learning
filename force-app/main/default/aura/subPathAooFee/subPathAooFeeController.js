({
    handleSelect : function (component, event, helper) {
        //get selected Status value
        var selectStatus = event.getParam("detail").value;
        //set selected Status value
        component.set("v.picklistField.Stage__c", selectStatus);
        component.set("v.picklistField.Sub_Stage__c", selectStatus);
         
        component.find("record").saveRecord($A.getCallback(function(response) {
            if (response.state === "SUCCESS") {
                $A.get('e.force:refreshView').fire();
                component.find('notifLib').showToast({
                    "variant": "success",
                    "message": selectStatus +" Is Approved",
                    "mode" : "sticky"
                });
            } else {
                component.find('notifLib').showToast({
                    "variant": "error",
                    "message": "Please Verify the details again.",
                    "mode" : "sticky"
                });
            }
        }));
    }
})