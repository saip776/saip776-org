({
	getPicklistValues : function(component, event, helper) {
        console.log('inside controller');
        
        var valincon = component.find("abc");
        console.log('valincon..'+valincon);
        var pickListValue = valincon.get("v.value");
        
        console.log('pickListValue.....'+pickListValue);
		
	},
    doInit : function(component, event, helper) {
        var action = component.get("c.getAllContacts");
       
       
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
 
                
               
                component.set("v.options", allValues);
            }
        });
        $A.enqueueAction(action);
    },
})