public class ContactSearch {
    
    public static List<Contact> searchForContacts(String lastName, String pcode){
        
        List<Contact> cont = [Select ID,Name from Contact where lastName=:lastName and MailingPostalCode=:pcode];
        return cont;
  
    }

}