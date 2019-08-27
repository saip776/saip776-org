public class dmlpractice {

    public static void newacc()
    {
        account a = new account();
        a.Name = 'abhishek trainer';
        a.Type__c = 'prospect';
        insert a;
        system.debug('acc id is '+a.id);
        
    }
    
    public static void newopp()
    {
        opportunity o = new opportunity();
        o.name = 'abhi opp';
        o.StageName ='prospecting';
        o.Discount_Percent__c=10;
        o.CloseDate = date.today()+6;
        o.AccountId = [select id from account where id='0017F00000vSftvQAC'].id;
        insert o;
    }
    
    public static void truck()
    {
        User u=[select id from user where id =: UserInfo.getUserId()];
        Truck_Model__c tc = new Truck_Model__c();
        tc.name = 'kishore';
        tc.Brand__c = 'bala brand';
        tc.Company__c = [select id from account where id='0017F00000vSftvQAC'].id;
        tc.manufacturer__c= u.id;
        insert tc;
        
        List<Truck_Model__c> trc = new List<Truck_Model__c>();
        for (integer i=0;i<5;i++)
        {
            Truck_Model__c trck = new Truck_Model__c();
            trck.name = 'rolando';
       		 trck.Brand__c = 'bala fake';
        	trck.Company__c = [select id from account where id='0017F00000vSftvQAC'].id;
        	trck.manufacturer__c= u.id;
            trc.add(trck);
            system.debug('list is '+trc);
        }
        insert trc;
        }
       
    public static void divyeah()
        {
            User u=[select id from user where id =: UserInfo.getUserId()];
            List<Account> accList=new List<Account>();
            account a = new account();
       	 	a.Name = 'Prime';
        	a.Type__c = 'prospect';
        	accList.add(a);
            account a1 = new account();
       	 	a1.Name = 'Sedan';
        	a1.Type__c = 'prospect';
        	accList.add(a1);
            account a2 = new account();
       	 	a2.Name = 'Mini';
        	a2.Type__c = 'prospect';
        	accList.add(a2);
            insert accList;
            
            List<Truck_Model__c> truckdiv = new List<Truck_Model__c>();
           for (integer i=0;i<=10;i+3)
        {
            if(Math.mod(i,2)==0){
            Truck_Model__c trck = new Truck_Model__c();
            trck.name = 'TruckModel'+i;
       		trck.Brand__c = 'Sedan';
        	trck.Company__c = accList[0].id;
        	trck.manufacturer__c= u.id;
        
        }
        
            Map<Id,Truck_Model__c> maptm= new Map<Id,Truck_Model__c>();
            
            
        }
            
    
    
        }       
   
    
}