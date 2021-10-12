@isTest
public class TestRestrictContactByName {
	
    @isTest
    static void TestTrigger(){
        Contact cont =  new Contact();
        cont.LastName='Some Name';
        
        
        Contact cont2 =  new Contact();
        cont2.LastName='INVALIDNAME';
      
        
        List<Contact> contList = new List<Contact>();
        contList.add(cont);
        contList.add(cont2);
   
    
        Test.startTest();
        try{
        	Database.insert(contList,false);
        	//Database.SaveResult saveResult = Database.update(cont,false);
        }
        catch(Exception e){
            
        }
            Test.stopTest();
    
        
        
    }
    
}