public class AccountController {
    @AuraEnabled
    public static list<Account> getaccounts() {
        
        List<Account> acc = [select id, Name, AccountNumber, Site, Active__c, AnnualRevenue, DateTime__c, Number_of_Locations__c, Industry, Match_Billing_Address__c from Account where Number_of_Locations__c != null Limit 50];
        system.debug('list data is'+acc);
        return acc;  
    }

}