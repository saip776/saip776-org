({
	sortData: function (cmp, fieldName, sortDirection) {
        var data = cmp.get("v.filteredData");
        //alert('data..'+ JSON.stringify(data));
        
        var reverse = sortDirection !== 'asc';
        //alert('reverse..'+ reverse);
        //sorts the rows based on the column header that's clicked
        data.sort(this.sortBy(fieldName, reverse))
        cmp.set("v.filteredData", data);
    },
    sortBy: function (field, reverse, primer) {
        var key = primer ?
            function(x) {return primer(x[field])} :
            function(x) {return x[field]};
        //checks if the two rows should switch places
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
        }
    },
    /*
     * Method will be called when use clicks on next button and performs the 
     * calculation to show the next set of records
     */
    next : function(component, event){
        var sObjectList = component.get("v.data");
        //alert('sObjectList..'+JSON.stringify(sObjectList)+'length..'+sObjectList.length);
        var end = component.get("v.endPage");
         //alert('end size..'+end);
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var Paginationlist = [];
        var counter = 0;
        for(var i=end+1; i<end+pageSize+1; i++){
            //alert('after for in if..'+i);
            if(sObjectList.length > i){
                //alert('in if..');
                Paginationlist.push(sObjectList[i]);
                  //alert('after sObjectList..'+JSON.stringify(sObjectList)+'length..'+sObjectList.length);
            }
            counter ++ ;
        }
        //alert('Paginationlist..'+JSON.stringify(Paginationlist));
        start = start + counter;
        end = end + counter;
        component.set("v.startPage",start);
        component.set("v.endPage",end);
        component.set('v.filteredData', Paginationlist);
    },
    /*
     * Method will be called when use clicks on previous button and performs the 
     * calculation to show the previous set of records
     */
    previous : function(component, event){
        var sObjectList = component.get("v.data");
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var Paginationlist = [];
        var counter = 0;
        for(var i= start-pageSize; i < start ; i++){
            if(i > -1){
                Paginationlist.push(sObjectList[i]);
                counter ++;
            }else{
                start++;
            }
        }
        start = start - counter;
        end = end - counter;
        component.set("v.startPage",start);
        component.set("v.endPage",end);
        component.set('v.filteredData', Paginationlist);
    },
})