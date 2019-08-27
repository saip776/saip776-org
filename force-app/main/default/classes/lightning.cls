public with sharing class lightning {

    @AuraEnabled
    public static string getacct()
    {
        return [select id,name from account limit 1][0].name;
    }
    
    @AuraEnabled
    public static String gettruck()
    {
       return [select id,name from Truck_Model__c limit 1][0].name ;        
    }
     @AuraEnabled
    public static list<Truck_Model__c> gettru()
    {
        //list<Truck_Model__c> listTruck = [select id,name from Truck_Model__c];
       return [select id,name from Truck_Model__c];
    }
    
    @AuraEnabled
    public static map<string,string> colormap()
    {
        map<string,string> resultmap = new map<string,string>();
        for(Truck_Model__c t :[select name,color__c from Truck_Model__c])
        {
            resultmap.put(t.name,t.color__c);
        }
        return resultmap;
    }
    
     @AuraEnabled
    public static boolean truckins(String nam,String brand)
    {
        Truck_Model__c tcs = new Truck_Model__c();
           
            tcs.name =nam;
        	tcs.Brand__c = brand;
        tcs.Company__c=[select id from Account][0].id;
        insert tcs;
        return true;
    }
     @AuraEnabled
    public static List<Truck_Model__c> searchtruck(String st)
    {
        system.debug('st...'+st);
      return [select name,color__c,brand__c,company__c from Truck_Model__c where name like: '%'+st+'%'];
    }
    
    
}