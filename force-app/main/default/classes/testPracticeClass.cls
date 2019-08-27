public class testPracticeClass {
    @auraEnabled
    
    public static contact getcon(string recid){
        contact con2 = [select id,name,email,phone from contact where id =: recid limit 1];
    return con2;
    }
    
    @auraEnabled
    public static void uptcon(contact con){
        if(con != Null){
            upsert con;
        }
        
    }

}