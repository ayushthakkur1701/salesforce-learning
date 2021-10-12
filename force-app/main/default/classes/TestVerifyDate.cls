@isTest
public class TestVerifyDate {

    @isTest static void CheckDatesValid(){
        
        Date Enddate = VerifyDate.CheckDates(Date.today(),Date.today() + 2);
        System.assertEquals(Date.today() + 2 , Enddate);
    }
    
     @isTest static void CheckDatesInvalid(){
        
        Date Enddate = VerifyDate.CheckDates(Date.today(),Date.today() + 32);
        System.assertEquals(Date.today() + 32 , Enddate);
    }
}