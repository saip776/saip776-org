({
doInit : function(component, event, helper) {
    var action = component.get("c.isClosedWon");
    action.setParams({
        "oppId" : component.get("v.recordId")
    });
    action.setCallback(this, function(response) {
        var state = response.getState();
        console.log("doInit >> val >> " + response.getReturnValue());
        console.log("doInit >> state >> " + state);
        if (state === "SUCCESS") {
            component.set("v.isWon", response.getReturnValue());
            if (response.getReturnValue()) 
                component.set("v.shouldContinue", true);
            else 
                component.set("v.shouldContinue", false);
        } else {
            component.set("v.notified", "A server Error occuried, please try again later.");
        }
    });
    $A.enqueueAction(action);
},

changeStatus : function (component, event, helper) {
    try {
        var selectValue = component.find("selectClosedStage").get("v.value");
        var action = component.get("c.CustomUpdateRecord");
        action.setParams({
            "oppId" : component.get("v.recordId"),
            "stageName" : selectValue
        });
        console.log('changeStatus >> selectValue >> '+ selectValue);
        action.setCallback(this, function(response) {
            var res = response.getReturnValue();
            console.log("changeStatus >> val >> " + response.getReturnValue());
            console.log("changeStatus >> state >> " + response.getState());
            if (selectValue === 'Closed Won') {
                component.set("v.isWon", true);
                component.set("v.shouldContinue", true);
            } else {
                component.set("v.isWon", false);
                component.set("v.shouldContinue", false);
                component.set("v.notified", 'the current opportunity is Closed Lost. No Order can be created for it');
            }
        });
        $A.enqueueAction(action);
    } catch (e) {
        console.log(e);
    } 
}
})