({
    clickCreateItem : function(component, event, helper) {
        var validCampItem = component.find('campform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        // If we pass error checking, do some real work
        if(validCampItem){
            // Create the new expense
            var newCampItem = component.get("v.newItem");
            console.log("Create Camp Item: " + JSON.stringify(newCampItem));
            var Item = component.get("v.items");
            // Copy the camping to a new object
            // THIS IS A DISGUSTING, TEMPORARY HACK
            var theItem = JSON.parse(JSON.stringify(Item));
            
            theItem.push(newCampItem);
            component.set("v.items", newCampItem);
            component.set("v.newItem",{ 'sobjectType': 'Camping_Item__c',
                                       'Name': '',
                                       'Quantity__c': 0,
                                       'Price__c': 0,
                                       'Packed__c': false });
            
            
        }
    }
})