public class Acclist1 {
@AuraEnabled
    public Static list<account> getAccount(){
        
        
        return [select id,Name,AnnualRevenue,createddate from account where NumberofLocations__c !=null  order by NumberofLocations__c asc ];
       
    }
    @AuraEnabled
    public static Account getAccount(Id accountId) {
        // Perform isAccessible() checks here
        return [SELECT Name, BillingCity, BillingState FROM Account WHERE Id = :accountId];
    }
    
    @AuraEnabled
    public static Contact saveContactWithAccount(Contact contact, Id accountId) {
        // Perform isAccessible() and isUpdateable() checks here
        contact.AccountId = accountId;
        upsert contact;
        return contact;
    }
    
    @AuraEnabled
   public Static  list<account> sortAccount(list<account> accountData){
        System.debug('accountData '+accountData);
       // String data = StudentsData.replace('"','\'');
     //   System.debug('data '+data);
       // list<Student__c> newStudents = (list<Student__c>)JSON.deserialize(StudentsData, list<Student__c>.class);
      
      //  System.debug('newStudents '+newStudents);
          update accountData;
       system.debug('accountData..'+accountData);
        return [select id,Name,NumberofLocations__c from account where NumberofLocations__c !=null  order by NumberofLocations__c asc limit 5];
       // return null;
    }
     @AuraEnabled
    public static list<contact> claimData()
    {
         return[SELECT name,title,phone,email,Birthday_Time__c,CreatedDate FROM contact];
    }

     @AuraEnabled
   public Static void cloneOpp(string recordId){
       list<Opportunity> obj =[select id,name,StageName from Opportunity where id =: recordId];
       
       list<Opportunity> listobjforUpdate = new list<Opportunity>();			
	   list<Opportunity> listobjforclone = new list<Opportunity>();
       
       for(Opportunity ob:obj){
		ob.StageName ='Rama';
		listobjforUpdate.add(ob);
   }
   }
    
    
    
    /*Display account data, this is created as part of pagenation-datatable-selection practice */
    @AuraEnabled
    public static List<Account> showAccounts(){
        List<Account> accountList = new List<Account>();
        accountList = [Select Id, Name, Industry,Type From Account LIMIT 100 ];
        return accountList;
    }

}