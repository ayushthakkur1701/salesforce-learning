public with sharing class mcNetworkSessionsController {

    @AuraEnabled(cacheable=true)
    public static List<Session__c> getSessionDetails(){
        List<Session__c> listOfSessions;

            listOfSessions =  [select id,Name,Subject__c,Presenter__c,Date_Of_Session__c from Session__c Order by Date_Of_Session__c];
            
            
        return listOfSessions;
    }

    
}