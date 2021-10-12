public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(integer numCont, string lastname)
    {
        List<Contact> contList = new List<Contact>();
        
        for(integer i=0;i<numCont;i++)
        {
            Contact conts = new Contact();
            conts.FirstName='FirstName' + i;
            conts.LastName = lastname;
            contList.add(conts);
        }
        
        return contList;
    }
}