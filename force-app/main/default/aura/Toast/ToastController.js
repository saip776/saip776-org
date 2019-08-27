({
       showInfoToast : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Info Message',
            message: 'this is normal Message',
            messageTemplate: 'Record {0} created! See it {1}!',
            duration:' 5000',
            key: 'info_alt',
            type: 'info',
            mode: 'pester'
        });
        toastEvent.fire();
    },
    showSuccessToast : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success Message',
            message: 'Mode is pester ,duration is 5sec and this is normal Message',
            messageTemplate: 'Record {0} created! See it {1}!',
            duration:' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
    },
    showErrorToast : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Error Message',
            message:'Mode is pester ,duration is 5sec and Message is not overrriden because messageTemplateData is not specified',
            messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrride',
            duration:' 5000',
            key: 'info_alt',
            type: 'error',
            mode: 'pester'
        });
        toastEvent.fire();
    },
    showWarningToast : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Warning',
            message: 'normal message',
            
            duration:' 5000',
            key: 'info_alt',
            type: 'warning',
            mode: 'sticky'
        });
        toastEvent.fire();
    },
})