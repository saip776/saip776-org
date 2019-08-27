trigger RichCopy on Contact (before insert, before update) {
    list<contact> con1 = new list<contact>();
    for(Contact con: trigger.new){
        if(con.Rich_Text__c != null){
            
        con.Rich_Text2__c = con.Rich_Text__c; 
        con1.add(con);
        }
        
    }
    //update con1;
}