({
    doinit : function(component, event, helper) {
        console.log("In TWR doinit");
        
        var action = component.get("c.getRecordTypes");
        
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log("state", state);
            
            if(state === 'SUCCESS' || state === 'DRAFT') {
                var res = response.getReturnValue();
                console.log("res", res);
                
                var recName =[];
                for (var i = 0; i < res.length; i++) { 
                    recName.push({'label': res[i].Name, 'value': res[i].DeveloperName});
                }
                
                component.set("v.value", res[0].DeveloperName);
                console.log("recName", recName);
                component.set("v.recTypes",recName);
                
                var meth = component.get('c.selectedRecType');
                $A.enqueueAction(meth);
            }
        });
        
        $A.enqueueAction(action);
    },
    
    selectedRecType : function(component, event, helper) {
        console.log("In selectedRecType");
        
        var val = component.get("v.value");
        console.log("SelectedRecType Value", val);
        
        component.set('v.columns', [
            {label: 'Account Id', fieldName: 'Id', type: 'text'},
            {label: 'Account name', fieldName: 'Name', type: 'text'},
            {label: 'Industry', fieldName: 'Industry', type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'phone'}
            
        ]);
        
        var action = component.get("c.getAccounts");
        
        action.setParams({
            RecType : val,
            searchTerm : ''
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log("state", state);
            
            if(state === 'SUCCESS' || state === 'DRAFT') {
                var res = response.getReturnValue();
                console.log("res", res);
                component.set("v.AccountList",res); 
                console.log("res.length", res.length);
                component.set("v.count", res.length);
                if(res.length > 0 || res.length !== 0){
                    
                    component.set("v.flag", false);
                }else {
                    component.set("v.flag", true);
                }
            }
            if(res.length === 0 || res.length ===null){
                //alert('There are no records of the selected type'+res.length);
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Message',
                    message: 'No Data available for this Record Type',
                    duration:' 3000',
                    key: 'info_alt',
                    type: 'message',
                    mode: 'pester'
                });
                toastEvent.fire();
            }
        });
        
        $A.enqueueAction(action);
        
    },
    
    handleChange : function(component, event, helper) {
        var searchval = component.get("v.searchterm");
        var val = component.get("v.value");
        var action = component.get("c.getAccounts");
        
        action.setParams({
            RecType : val,
            searchTerm : searchval
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log("state", state);
            
            if(state === 'SUCCESS' || state === 'DRAFT') {
                var res = response.getReturnValue();
                console.log("res", res);
                component.set("v.AccountList",res); 
                component.set("v.count", res.length);
            }
        });
        
        $A.enqueueAction(action);
        
        
    }
})