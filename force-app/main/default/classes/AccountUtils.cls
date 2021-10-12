public class AccountUtils {
    
    public static List<Account> accountsByState(String abbState){
        
        List<Account> listAccountonState = [Select id, Name from Account where BillingState like :abbState];
        return listAccountonState;
    }

}