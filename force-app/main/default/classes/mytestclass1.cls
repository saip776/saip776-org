public class mytestclass1
{
    // comment
    
    public mytestclass1()
    {
        Integer i = 20;
        String s = 'sai';
        Date d1 = date.today();
        DateTime d2 = system.now();
        integer len = s.length();
        system.debug('date is '+d1);
        system.debug('date is '+d2);
        system.debug('date is '+len);

    }
public Integer multiplication(Integer a, Integer b)
{
    Integer result = a*b;
    return result;
}

    public static Integer multiplication1(Integer a, Integer b)
{
    Integer result = a*b;
    return result;
}
    public static boolean isZero(Integer i)
    {
        if (i==0) return true;
        else
        return false;
    }
    
    public static void collection1()
    {
        List<integer> intlist = new List<integer>();
        intlist.add(23);
        intlist.add(33);
		intlist.add(43); 
        intlist.add(33);
		intlist.add(53);
        system.debug('the list is '+intlist);
        system.debug('the value in list is '+intlist.get(1));
        intlist.remove(3);
        system.debug('the list is '+intlist);
        
        
        set<integer> intset = new set<integer>();
        intset.add(23);
        intset.add(33);
		intset.add(43); 
        intset.add(33);
		intset.add(53);
        system.debug('the list is '+intset);
        intset.remove(33);
        system.debug('the list is '+intset);
        
        map<integer,string> numbermap = new map<integer,string>();
        numbermap.put(1,'one');
        numbermap.put(2,'two');
        numbermap.put(3,'three');
        numbermap.put(4,'four');
        numbermap.put(5,'four');
        system.debug('the number map is '+numbermap);
        system.debug('the number map is '+numbermap.get(5));
        system.debug('the number map is '+numbermap.keyset());
    	
        for(Integer i : intlist)
        {
            system.debug('In Loop '+i);
        }
    
    }
    		/*palindrome*/
    public static void palindrome(string i)
    {
         List<string> splitlist = new List<String>();
        boolean result=true;
        for(String item : i.split('')){
            splitlist.add(item);
        }
       system.debug('splitlist data is  '+splitlist);
        Integer listSize=splitlist.size();
       system.debug('splitlist data is  '+listSize); 
        
        for(integer a=0;a<listsize-1;a++)
        {
            system.debug('first string '+a);
            system.debug('second string '+(listSize-1-a));
            
            if(!splitlist.get(a).equals(splitlist.get(listSize-1-a)))
            {
                result=false;
            }
                system.debug('display');
            
        }
       
    }
    
    public static void soqlmem()
    {
        map<string,list<double>> mamap= new map<string,list<double>>();
        list<Truck_Model__c> models = [Select id,name, color__c,price__c from Truck_Model__c];
        system.debug('name is '+models);
        for(Truck_Model__c truck : models)
        {
            if(mamap.containsKey(truck.color__c))
            {

                 list<double> trucklist = mamap.get(truck.color__c);
                trucklist.add(truck.price__c);
                
                
                mamap.put(truck.color__c,trucklist);
               
            }
            else
            {
                 list<double> trucklist = new list<double>();
                trucklist.add(truck.price__c);
                mamap.put(truck.color__c,trucklist);
            }
           // mamap.put(truck.color__c,truck);
            
        }
        system.debug('map data is ..'+mamap);
    }
    
     public static void soqlmem1()
    {
       
        list<Truck_Model__c> models = [Select id,name, color__c,price__c,manufacturer__r.email from Truck_Model__c];
        system.debug('name is '+models);
        for(Truck_Model__c truck : models)
        {
            if((truck.manufacturer__r.Email).contains('gmail'))
            {
                system.debug('name is  '+truck.name);
                system.debug('email is  '+truck.manufacturer__r.email);
                
            }
           
        }
    }
    public static void numrange()
    {
        list<integer> oddrange1 = new list<integer>();
        list<integer> oddrange2 = new list<integer>();
        for(integer i=0;i<=100;i++)
        {
            if(math.mod(i,2)!=0)
            {
            oddrange1.add(i);
            }
        }
        system.debug('oddrange1 is ..'+oddrange1);
        
        for (integer i=100;i<=500;i++)
        {
            if(math.mod(i,2)!= 0)
            {
                oddrange2.add(i);
            }
        }
        system.debug('oddrange2 ..'+oddrange2);
        
        map<integer,list<integer>> rangemap = new map<integer,list<integer>>();
        rangemap.put(100,oddrange1);
        rangemap.put(500,oddrange2);
        
        system.debug('rangemap ..'+rangemap);
        
        
     }
    

}