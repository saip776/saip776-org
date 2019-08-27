public class DateTimeSave {
    
    @AuraEnabled
    public static Account setDateTime(string name, string datetimeval, string typeval, Account rec) {
        system.debug('rec data is '+rec);
        system.debug('date time value is '+datetimeval);
        /* 2019-06-26T12:06:00.000Z */
        
        string datettime1 = datetimeval.replace('T',' ');
        system.debug('repalced date'+datettime1);
        string datettime2 = datettime1.replace('.000Z','');
        system.debug('datetime2...'+datettime2);
        
        
        
        
        Account acc = new Account();
        acc.name = name;
        acc.Type__c = typeval;
        acc.DateTime__c = datetime.valueOf(datettime2);
        insert acc;
        return acc;
    }
}