public class TimeTrack {
    
    public void getTimeTracking(){
        
        DateTime currentTime = DateTime.now();
        Case newCase =  new Case();
        newCase.Enrollment_StartDate__c=currentTime;
        insert newCase;
        
    }
    

}