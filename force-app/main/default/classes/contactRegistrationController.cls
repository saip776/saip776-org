public with sharing class contactRegistrationController {

    @AuraEnabled
    public static Contact saveContact(string firstname,string lastname,string Birthdate,string birthdatetime,string phone,string email) {
      
        system.debug('firstname..'+ firstname + 'lastname..'+ lastname +'Birthdate..'+Birthdate + 'birthdatetime..'+birthdatetime  + 'phone..'+phone + 'email.is .. '+email);
        Date myDate = Date.valueOf(Birthdate);
        // start converting datetime
       // String birthdatetime = '2018-05-16T05:20';
	String bdAddZero = birthdatetime+':00';
	String updatedBirthDate = bdAddZero.replace('T',' ');
	system.debug('updatedBirthDate.....'+updatedBirthDate);
	Datetime dt1 = Datetime.valueOf(updatedBirthDate);
	system.debug('dt1..'+dt1);


	
        //end conversion datetime 
        system.debug('myDate..'+myDate);
     //  list <Contact> con = new list<Contact>();
        contact con = new contact();
           con.firstname = FirstName;
       		con.lastname = lastname;
           con.Birthdate = myDate;
        	con.Birthday_Time__c= dt1;
            con.Email= email;
        con.Phone=phone;
        
        
        system.debug('con..'+con);
        insert Con;
         system.debug('con..'+con);
        
        return Con;
    }
    @AuraEnabled
    public static list<contact> getAllContacts() {
        
        list<contact> listContact =[select id,name from contact];
        return listContact;
        
    }
}