public class ContactAndLeadSearch {
    
    public static List<List<sObject>> searchContactsAndLeads(String name){
        
        List<List<sObject>> searchList =[Find 'Smith' in all fields returning Contact(firstName,LastName),Lead(firstName,LastName)];
        return searchList;
    }

}