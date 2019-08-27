public class retriveRelatedUsers {
    
    public static void usersdata(){
        Set<id> parset = new Set<id>();
        map<id,List<user>> usermap = new map<id,List<user>>();
        List<user> UserList = [SELECT Id,Parent__c,(select id,Name from Parents__r) Name FROM user];
        system.debug('***UserList***'+UserList);
        for(User usr : UserList)
            if(usr.Parent__c != null)
            	parset.add(usr.Parent__c);
        
        for(id pid : parset){
            List<user> uList = new List<user>();
            for(User usr : UserList){
                if(usr.Parent__c == pid){
                    uList.add(usr);
                }
            }
            usermap.put(pid,uList);
        }
        
        /****************/
        
        for(id mid : usermap.keyset()){
            for(user usr : usermap.get(mid)){ 
                if(usermap.containskey(usr.id)){
                    usermap.get(mid).addall(usermap.get(usr.id));
                }
            }
            usermap.put(mid,usermap.get(mid));
        }
        //system.debug('***data in user map***'+usermap);
        
        
    } 

}