({
	myAction : function(component, event, helper) {
		console.log('this is in js controller');
        helper.helperMethod(component);
	},
    
    myActioned : function(component, event, helper) {
		console.log('this is in js controller one');
        helper.helperMethods(component);
	},
    myActions : function(component, event, helper) {
		console.log('this is in js controller two');
        helper.helperMethodo(component);
	},
     myActor : function(component, event, helper) {
		console.log('this is in js controller three');
        helper.helperMethodology(component);
	},
    startmethodput : function(component, event, helper){
         console.log("in startmethodInput");
        helper.helperMethodput(component);
    },
     startmethodput2 : function(component, event, helper){
         console.log("in startmethodput2");
        helper.abhimethod(component);
    }

    
})