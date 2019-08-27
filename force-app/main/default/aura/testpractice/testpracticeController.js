({
	doinit : function(component, event, helper) {
		console.log('in do init....');
        var id = component.get('v.recordId');
        console.log('id is ...'+id);
        var action = component.get('c.getcon');
        action.setParams({'recid':id});
        action.setCallback(this,function(response){
            var capital = response.getState();
            console.log('value in response is..'+capital);
            if(capital === "SUCCESS"){
                var result = response.getReturnValue();
                console.log('value in result is..'+JSON.stringify(result));
                component.set('v.record',result);
            }
        });
     $A.enqueueAction(action);  
	},
    handleEvent : function(component, event, helper) {
		console.log('in handle event....');
        var a = component.get('c.doinit');
    $A.enqueueAction(a);
    }
})