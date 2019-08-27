public with sharing class getAccountsWithRecTypes {
	
    @AuraEnabled
    public static List<RecordType> getRecordTypes() {
        List<RecordType> recTypes = [SELECT Id,Name, DeveloperName FROM RecordType WHERE SobjectType='Account'];
        return recTypes;
    }
    
    @AuraEnabled
    public static List<Account> getAccounts(String RecType, String searchTerm) {
       // string abcd = 'Select Id, Name, Industry, Phone from Account where RecordType.DeveloperName =:'+RecType+'AND Name LIKE\'%'+searchTerm+'%\'';
        string tempInput = '%' + searchTerm + '%';
        List<Account> accs = [Select Id, Name, Industry, Phone from Account where RecordType.DeveloperName =: RecType and Name Like : tempInput];
       // List<Account> accs = Database.query(abcd);
        return accs;
        
    }
}