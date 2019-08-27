({
	myAction : function(component, event, helper) {
		
	},
    copy : function(component, event, helper) {
    var holdtxt = component.getElementById('rich');
    //var holdtext = holdtxt.getElement();
    //console.log('value copied is....'+holdtext);
    holdtxt.select();
   // document.queryCommandSupported('copy');
    document.execCommand('copy');

    var source = event.getSource();
    source.set('v.label','COPIED!');

   // setTimeout(function(){
     //   component.set("v.showModal", false);
    //}, 1500);
}
})