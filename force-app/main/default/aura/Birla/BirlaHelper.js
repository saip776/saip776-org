({
	helperMethod : function(component, event, helper) {
        console.log('this is in helper controller one');
        var act1 = component.get("c.gettru");
        
        act1.setCallback(this,function(response){
            var actnam1 = response.getReturnValue();
            console.log('value came from apex is'+JSON.stringify(actnam1));
            component.set("v.truckname1",actnam1);
              }),
        	 $A.enqueueAction(act1);  
	},
                         
    helperMethods : function(component, event, helper) {
        console.log('this is in helper controller two');
        //method is called here
        var aton = component.get("c.getacct");
        
        //receiving response
        aton.setCallback(this,function(response){
            //retreiving the return data
            var actname = response.getReturnValue();           
            console.log('response from account is '+actname);
            //setting the value to displayed
            component.set("v.displayname",actname);
        }),
             $A.enqueueAction(aton);
		
	},
    helperMethodo: function(component, event, helper) {
        console.log('this is in helper controller three');
        var act = component.get("c.gettruck");
        console.log('value came from apex is'+JSON.stringify(act));
        act.setCallback(this,function(response){
            var actnam = response.getReturnValue();
            console.log('response from truck name  is '+actnam);
            component.set("v.truckname",actnam);
            
        }),
        	 $A.enqueueAction(act);
		
	},
    
    helperMethodology: function(component, event, helper) {
        console.log('this is in helper controller four');
        var abc = component.get("c.colormap");       
        abc.setCallback(this,function(response){
            var abcnam = response.getReturnValue();
           console.log('value came from colormap is'+JSON.stringify(abcnam));
            var maprr = [];
            for(var key in abcnam)
                {
                    console.log('key data is '+key);
                    console.log('value of key data is '+abcnam[key]);
                    maprr.push({key:key,value:abcnam[key]})
                }
            component.set("v.mapdata",maprr);
            
        }),
        	 $A.enqueueAction(abc);
		
	},
     helperMethodput: function(component, event, helper) {
        console.log('this is in helper controller five');
         var nameinp = component.get("v.firstname");
        var brandinput = component.get("v.emailaddress");
        console.log(nameinp+brandinput);
        var tion=component.get("c.truckins");
       tion.setParams({"nam":nameinp,"brand":brandinput});
       tion.setCallback(this,function(response){
            var abcnam = response.getReturnValue();
           console.log('value came from colormap is'+abcnam);
            
            }),
                  	 $A.enqueueAction(tion);
		
	},
    
     searchmethod: function(component, event, helper) {
        console.log('this is in helper controller six');
         var namein = component.get("v.searchtext");
        console.log('input'+namein);
        var lion=component.get("c.searchtruck");
       lion.setParams({st:namein});
         //console.log('params are'+lion.setParams({st:namein}));
         lion.setCallback(this,function(response){
           var abnam = response.getReturnValue();
          console.log('value came from search truck is'+abnam);
            
         //               
        
        	
		 })
          $A.enqueueAction(lion);
	},
     abhimethod: function(component, event, helper) {
         var namein = component.get("v.searchtext");
        console.log('input'+namein);
        var act=component.get("c.searchtruck");
         
         act.setParams({"st":namein});
         //console.log('params are'+lion.setParams({st:namein}));
         act.setCallback(this,function(response){
           var abnam = response.getReturnValue();
          console.log('value came from search truck is'+JSON.stringify(abnam));
          component.set("v.dynsearch",abnam);
		 })
          $A.enqueueAction(act);
         
     }
})