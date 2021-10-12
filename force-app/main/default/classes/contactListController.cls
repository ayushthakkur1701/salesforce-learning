public class contactListController {

    @AuraEnabled
    public static List<Contact> contactList(string accId){
        system.debug('accid: '+ accId);
        List<contact> lstContact = new List<Contact>();
        lstContact = [select id, firstName, lastName, email,phone,AccountId from Contact where Email != NULL and AccountId =:accId];
        return lstContact;
    }
    
    @AuraEnabled
    public static Contact createContact(Contact con, Id accountId){
        system.debug('con '+ con);
        con.AccountId=accountId;
        insert con;
        return con;
    }
}