({
        init : function(component, event, helper) {
        
        var action = component.get("c.claimData");
        action.setCallback(this,function(response){
            console.log('inside response');
        component.set("v.columns", [{type:"text",label:"Name",fieldName:"Name"},
                                   {type:"Currency",label:"revenue Percentage",fieldName:"Revenue__c"},
                                    {type:"picklist",label:"Digital",fieldName:"ICS_Digital__c"},
                                    {type:"text",label:"Title of business",fieldName:"Title"},
                                   {type:"lookup",label:"PNL",fieldName:"ICS_PNL__c"},
                              {type:"currency",label:"Sales Credit",fieldName:"ICS_Account_Manager_Sales_Credit__c"},
                                  {type:"text",label:"Batch Number",fieldName:"ICS_Batch_Field__c"},
                                    {type:"lookup",label:"Channel Manager",fieldName:"ICS_RSM__c"},
                                  {type:"lookup",label:"Sales Representative",fieldName:"ICS_Rep__c"},
                                    {type:"lookup",label:"Commission",fieldName:"ICS_Commission__c"},
                                  //  {type:"Email",label:"email address",fieldName:"Email"},
                                    {type:"date",label:"Created Date",fieldName:"CreatedDate"}]);
			console.log('test..'+JSON.stringify(response.getReturnValue()));
            console.table('response.getReturnValue()'+response.getReturnValue());
            component.set('v.filteredData', response.getReturnValue());
            
                });
            $A.enqueueAction(action);
        }
    

})