({
	stopspin : function(component, event, helper) {
        var wheelspin = component.find("spinwheel").get("e.toggle");
		console.log('wheelspin data is ....'+wheelspin);
        wheelspin.setParams({isVisible:false});
        console.log('before firing event');
        wheelspin.fire();
        console.log('after firing event');
	}
})