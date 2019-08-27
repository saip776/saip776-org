({
 doSubmit : function (component, event, helper) {
    console.log("confirm has been hit");
    var action = component.get("c.createOrder");
    action.setParams({
         "oppId" : component.get("v.recordId")
    });
    console.log("cdoSubmit >> " + component.get("v.recordId"));
    action.setCallback(this, function(response) {
        var res = response.getReturnValue();
        console.log("res >> " + res);
        if (response.getState() === 'SUCCESS') {
            var NotificationError = [];
            if (res !== 'SUCCESS' && res !== '') {
                switch(res) {
                    case 'NotClosedWon':
                        NotificationError.push("change this Opportunity Status as Won before continuing.");
                        break;
                    case 'NoProduct' :
                        NotificationError.push("The current Opportunity does not have any associated products");
                        break;
                    case 'ErrorAccountBillingCity' :
                        NotificationError.push("The Account associated to the current Opportunity is missing the Billing City Information.");
                        break;
                    case 'ErrorAccountBillingStreet' :
                        NotificationError.push("The Account associated to the current Opportunity is missing the Billing Street Information.");
                        break;
                    case 'ErrorAccountBillingState' :
                        NotificationError.push("The Account associated to the current Opportunity is missing the Billing State Information.");
                        break;
                    case 'ErrorAccountBillingPostalCode' :
                        NotificationError.push("The Account associated to the current Opportunity is missing the Billing Postal Code Information.");
                        break;
                    case 'ErrorAccountBillingCountry' :
                        NotificationError.push("The Account associated to the current Opportunity is missing the Billing Country Information.");
                        break;
                    case 'ErrorNoContactAssociated' :
                        NotificationError.push("The Account associated to the current Opportunity do not have any Contact associated.");
                        break;
                    case 'Error' : 
                        component.set("v.notified", "An Error happened, please try again. If it persists please contact your administrator");
                        break;
                } //end switch
                component.set("v.errorCheck", NotificationError);
                component.set("v.shouldContinue", false);        
                console.log(NotificationError);
            } //end if
            else {
                console.log("after Process: " + res);
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Conversion done succesfully",
                    "message": "Your Order is now available under the Order tab. Please review and Activate." 
                });
                $A.get("e.force:closeQuickAction").fire();
                resultsToast.fire();
            }
        } else {
                component.set("v.errorCheck", ["An Error happened, please try again. If it persists please contact your administrator"]);
        }
    });
     $A.enqueueAction(action);
}
})