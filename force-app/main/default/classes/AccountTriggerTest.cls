@istest
public class AccountTriggerTest {
    
    @istest
    private static void accountTriggerTest(){
        
        List<Account> testAccData = new List<Account>();
        
        for(Integer i =0;i<200;i++)
        {
            Account acc =  new Account(Name='Account Name' + i,BillingState ='CA');
            testAccData.add(acc);
        }
        
        Test.startTest();
        if(testAccData.size()>0){
            
            insert testAccData;
        }
        test.stopTest();
        
        List<Account> verifyAccts = [SELECT Id,ShippingState FROM Account where BillingState='CA'];
        for(Account VAcc:verifyAccts){
        	System.assertEquals('CA', VAcc.ShippingState);
        }
    }

}