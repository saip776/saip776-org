({
   
    createContact: function(component,firstname,lastname,Birthdate,birthdatetime,title,type,message) {
        console.log('inside helper');
        console.log('inside helper::firstname:'+firstname + 'lastname..'+lastname +'Birthdate..'+Birthdate +'birthdatetime..'+birthdatetime);
        var con= component.get("v.newContact");
        console.log('con..'+JSON.stringify(con));
    var action = component.get("c.saveContact");
        console.log('after method called.... '+ action);
       
    action.setParams({
        "firstname": firstname,
        "lastname": lastname,
         "Birthdate": Birthdate,
        "birthdatetime":birthdatetime
        //component.get("v.contacts")
    });

    action.setCallback(this, function(response){
        var state = response.getState();
       // if (component.isValid() && state === "SUCCESS") {
             if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
 				console.log('allvalues'+allValues);
                 if(allValues != null){
                     //string id = allValues.id;
                     //console.log('id of the inserted contact'+id);
                     alert('conatct insert done.....'+JSON.stringify(allValues));
                 }
                
               
               // component.set("v.options", allValues);
            }
       
    });
    $A.enqueueAction(action);
},
    
})