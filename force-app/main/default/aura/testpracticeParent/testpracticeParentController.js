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
    afterclick : function(component, event, helper){
        console.log('after button click..');
        var rec = component.get('v.record');
        var action = component.get('c.uptcon');
        action.setParams({'con':rec});
        action.setCallback(this,function(response){
            var capitals = response.getState();
            console.log('value in response is..'+capitals);
            /*if(capitals === "SUCCESS"){
                var result = response.getReturnValue();
                console.log('value in result is..'+JSON.stringify(result));
                component.set('v.record',result);
            }*/
            
            var evt = component.getEvent("testpracticeEvent");
            evt.fire();
        });
     $A.enqueueAction(action);
    }
})