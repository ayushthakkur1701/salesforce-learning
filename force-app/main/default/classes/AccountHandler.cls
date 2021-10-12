public class AccountHandler {

    
    public static Account insertNewAccount(String actName){
        
	  Account Act;
        try
        {
        
            Act = new Account(Name=actName);
          
            insert Act;
            
           
        }
        catch(DmlException e)
        {
            return null;
        }
        
        return  Act;
    }
}