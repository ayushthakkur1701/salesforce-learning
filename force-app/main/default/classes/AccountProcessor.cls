public class AccountProcessor {
    
    @future
    public static void countContacts(Set<Id> setIdAcc){
		List<Account> contactsInAccount = [SELECT Id,Number_of_Contacts__c,(select id from contacts) FROM Account Where Id IN :setIdAcc];
        integer count = 0;
        for(Account acc : contactsInAccount){
            List<Contact> lstcont= acc.contacts;
            acc.Number_of_Contacts__c = lstcont.size();
        }
        update contactsInAccount;
        
    }

}