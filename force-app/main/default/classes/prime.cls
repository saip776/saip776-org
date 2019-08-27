public class prime {
    
    public static integer isprime( integer n)
    {
        
       integer i,m=0,f;
        m=n/2;
        if(n==0||n==1){  
  	 system.debug(n+'is not prime number');      
 	 }
        else
        {  
  			 for(i=2;i<=m;i++){      
   		 if(math.mod(n,i)==0){      
     system.debug(n+'is not prime number');      
     f=1;      
     break;      
    }      
   }      
   if(f==0)  
   {
      system.debug (n+'is prime number');
   }  
  }
        return n;
        
    }
        

}