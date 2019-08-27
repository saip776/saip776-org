({
	packItem : function(component, event, helper) {
        var a = component.get("v.item");
        a.Packed__c = true;
        var btn = event.getSource().get("v.label");
        console.log('Button data is '+btn);
        component.set("v.item",a);
        btn.set("v.disabled",true);
        
        
		/*var btnClicked = event.getSource();
        var btnMessage = btnClicked.get("v.label");
        component.set("v.message",btnMessage);
	},
        handleClick2: function(component, event, helper) {
        var newMessage = event.getSource().get("v.label");
        console.log("handleClick2: Message: " + newMessage);
        component.set("v.message", newMessage);*/
    }

})