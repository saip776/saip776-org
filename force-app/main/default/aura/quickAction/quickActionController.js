({
	doInit : function(component, event, helper) {
        	window.location.href="/apex/backgroundPage?id="+component.get("v.recordId");

    		setTimeout(function(){
            		$A.get("e.force:closeQuickAction").fire(); 
		}, 1000);
	}
})