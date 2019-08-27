({
    loadOptions: function (component, event, helper) {
        var opts = [
            { value: "R", label: "Red" },
            { value: "G", label: "Green" },
            { value: "B", label: "Blue" }
         ];
         component.set("v.colors", opts);
    },
    onChangeColor: function (component, event, helper) {
        var myColor = event.getSource().get("v.value");
        alert('mycolor..'+myColor);
        //var test;
    }
})