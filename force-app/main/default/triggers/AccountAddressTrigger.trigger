trigger AccountAddressTrigger on Account (before insert,before update){
    
    
    List<Account> accList  = new List<Account>();
    
    
    
    
    for(Account acc: Trigger.New){
        if((acc.BillingPostalCode!='') && acc.Match_Billing_Address__c==true)
        {
            
            acc.ShippingPostalCode= acc.BillingPostalCode;
            accList.add(acc);
        }
    }
    
    
}