({
    
    showInfoToast : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Info Message',
            message: 'This is normal Message and duration is 5sec',
            messageTemplate: 'Mode is dismissible',
            duration:' 5000',
            key: 'info_alt',
            type: 'info',
            mode: 'dismissible'
        });
        toastEvent.fire();
    },
    showSuccessToast : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success Message',
            message: ' this is normal Message',
            messageTemplate: 'Mode is pester and duration is 5sec',
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
            message:'Sample Error and Mode is pester',
            messagetemplatedata:'abcd',
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
            messageTemplate: 'Mode is sticky',
            duration:' 5000',
            key: 'info_alt',
            type: 'warning',
            mode: 'sticky'
        });
        toastEvent.fire();
    },
})