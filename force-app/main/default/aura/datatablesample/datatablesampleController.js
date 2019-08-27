({
    init: function(component, event, helper) {
        //component.set('v.isSending',true);
        var sample = [];
        debugger;
         var action = component.get("c.getAccount");
        
        action.setCallback(this,function(response){
            
            component.set("v.columns", [{type:"text",label:"Name",fieldName:"Name",sortable: true},
                                        {type:"number",label:"Number of Locations",fieldName:"ctrla51__NumberofLocations__c",sortable: true},
                                        {type:"currency",label:"Annual Revenue",fieldName:"AnnualRevenue",sortable: true},
                                       	{type:"date",label:"create ddate",fieldName:"CreatedDate",sortable: true}]);
            component.set('v.data',response.getReturnValue());
           // var s = component.get(c.data);
            //console.log('what is in data'+s);
           var pageSize = component.get("v.pageSize");
            
            console.log('pageSize..'+pageSize);
            component.set("v.filteredData", response.getReturnValue());
            console.log('account details..'+JSON.stringify(response.getReturnValue()));
            // get size of all the records and then hold into an attribute "totalRecords"
                //component.set("v.totalRecords", component.get("v.sample").length);
                component.set("v.totalRecords", response.getReturnValue().length);
            
                // set star as 0
                component.set("v.startPage",0);
                
                component.set("v.endPage",pageSize-1);
           var flData = component.get("v.filteredData");
                var PaginationList = [];
                for(var i=0; i< pageSize; i++){
                    if(flData.length> i)
                        
                        PaginationList.push(flData[i]);    
                }
             console.log('PaginationList..'+JSON.stringify(PaginationList));
                component.set('v.filteredData', PaginationList);
            
            
            
           
        });
        
        $A.enqueueAction(action);
       
            
    },
    filter: function(component, event, helper) {
        var data = component.get("v.data"),
            term = component.get("v.filter"),
            results = data, regex;
        var filteredDataList = [];
        debugger;
        try {
            for(var i=0;i<data.length;i++){
                var dataName = data[i].Name;
              if(term == null){

                        if((!data[data[i].Name]))

                            filteredDataList.push({ Name: data[i].Name,NumberofLocations__c: data[i].NumberofLocations__c,AnnualRevenue: data[i].AnnualRevenue,CreatedDate: data[i].CreatedDate});

                    }
					//|| ((data[i].AnnualRevenue.toString()).toLowerCase().includes(term.toLowerCase()))
                   else if((data[i].Name.toLowerCase().startsWith(term.toLowerCase())) || ((data[i].NumberofLocations__c.toString()).toLowerCase().startsWith(term.toLowerCase())) || ((data[i].CreatedDate.toString()).toLowerCase().includes(term.toLowerCase()))){

                        filteredDataList.push({ Name: data[i].Name,NumberofLocations__c: data[i].NumberofLocations__c,AnnualRevenue: data[i].AnnualRevenue,CreatedDate: data[i].CreatedDate});

                    }
            }
            component.set("v.filteredData", filteredDataList);
            var pageSize = component.get("v.pageSize");
            
            if(pageSize == null || pageSize == ''|| pageSize == undefined){
                
                pageSize = 5;
                
            }
            console.log('pageSize..'+pageSize);
            component.set("v.totalRecords", data.length);
            
                // set star as 0
                component.set("v.startPage",0);
                
                component.set("v.endPage",pageSize-1);
           var flData = component.get("v.filteredData");
                var PaginationList = [];
                for(var i=0; i< pageSize; i++){
                    if(filteredDataList.length> i)
                        
                        PaginationList.push(flData[i]);    
                }
             console.log('PaginationList..'+JSON.stringify(PaginationList));
                component.set('v.filteredData', PaginationList);
             
            //regex = new RegExp(term, "i");
            // filter checks each row, constructs new array where function returns true
            //results = data.filter(row=>regex.test(row.Name) || regex.test(row.ctrla51__NumberofLocations__c.toString()));
         debugger;
        } catch(e) {
            // invalid regex, use full list
        }
       
    },
    updateColumnSorting: function (cmp, event, helper) {
      
        var fieldName = event.getParam('fieldName');
      
        var sortDirection = event.getParam('sortDirection');
      
        // assign the latest attribute with the sorted column fieldName and sorted direction
        cmp.set("v.sortedBy", fieldName);
        cmp.set("v.sortedDirection", sortDirection);
        helper.sortData(cmp, fieldName, sortDirection);
    },
    next: function (component, event, helper) {
    helper.next(component, event);
},
    previous: function (component, event, helper) {
    helper.previous(component, event);
},
    handlePageSize: function (component, event, helper) {
    console.log('handlePageSize..');
        debugger;
        var pageSize = parseInt(component.find("pageSizeChange").get("v.value"));
            if(pageSize == null || pageSize == ''|| pageSize == undefined || pageSize == NaN){
                
                pageSize = '5';
                
                
            }
        component.set("v.pageSize",pageSize);
        console.log('pageSize In handlePageSize..'+pageSize);
       
            
           
        var filteredData = component.get("v.data");
            
            console.log('account details..'+JSON.stringify(filteredData));
            // get size of all the records and then hold into an attribute "totalRecords"
                
                component.set("v.totalRecords", filteredData.length);
            
                // set star as 0
                component.set("v.startPage",0);
                
                component.set("v.endPage",pageSize-1);
           //var flData = component.get("v.filteredData");
                var PaginationList = [];
                for(var i=0; i< pageSize; i++){
                    if(filteredData.length> i)
                        
                        PaginationList.push(filteredData[i]);    
                }
             console.log('PaginationList..'+JSON.stringify(PaginationList));
                component.set('v.filteredData', PaginationList);
            
            
        
}
})