({
	save : function(component, event, helper) {
		console.log("In Save.....");
        
        var rec = component.get("v.account");
        console.log('date time value is ..',component.find("dateTimeId").get("v.value"));

        var action = component.get("c.setDateTime");
        action.setParams({

            name : component.find("nameId").get("v.value"),
            datetimeval : component.find("dateTimeId").get("v.value"),
            typeval : component.find("typeId").get("v.value"),
            rec : rec
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log("state", state);
            var emptyRec = {'sobjectType' : 'Account',
                            'Name' : '',
                            'DateTime__c' : '',
                            'Type__c' : ''};
            component.set("v.account",emptyRec);  
            
            var res = response.getReturnValue();
            alert(JSON.stringify(res));
        });
        
        $A.enqueueAction(action);
	}
})