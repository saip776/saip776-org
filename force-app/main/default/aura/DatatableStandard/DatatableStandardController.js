({
	doinit : function(component, event, helper) {
        
        var action = component.get("c.getaccounts");
        action.setCallback(this,function(response){
            var state = response.getState();
            
            if(state === 'SUCCESS' || state === 'DRAFT'){
                var result =  response.getReturnValue();
                console.log("result", result);
                component.set("v.data", result);
            }
        });
         component.set('v.columns', [
            { label: 'Name', fieldName: 'Name', type: 'text' },
            { label: 'Account Number', fieldName: 'AccountNumber', type: 'text' },
         
             { label: 'Account Site', fieldName: 'Site', type: 'text' },
             { label: 'Is Active', fieldName: 'Active__c', type: 'picklist' },
           { label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'Currency' },
             { label: 'Billing Address', fieldName: 'BillingAddress', type: 'Address' },
             { label: 'Date Time', fieldName: 'DateTime__c', type: 'Date/Time' },
             { label: 'Number of Locations', fieldName: 'Number_of_Locations__c', type: 'number' },
             { label: 'Industry', fieldName: 'Industry', type: 'picklist' },
             { label: 'Match Billing Address', fieldName: 'Match_Billing_Address__c', type: 'Boolean' }
           ]);
            $A.enqueueAction(action);
    },
    
    handle : function(component, event, helper) {
        var data = component.find("form");
        console.log("result before", data);
        var data2 = component.find("form").get("v.value");
        console.log("result", data2);
    }
    
	
})