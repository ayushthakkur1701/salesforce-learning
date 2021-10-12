public class AccountTriggerHandler {
    
    public static void CreateAccounts(List<Account> accList){
        
      
        
        for(Account acc: accList){
            if(acc.BillingState != Null){
                
                acc.ShippingState = acc.BillingState;
            }
            
         
        }
        
     
    }

}