public with sharing class LwcAccountController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> findAccounts(String searchKey) {
        String key = '%' + searchKey + '%';
        return [SELECT Id, Name, AccountNumber FROM Account WHERE Name LIKE :key  LIMIT 10];
    }

    @AuraEnabled(cacheable=true)
    public static List<ObjectDataModelClass> fetchApprovalProcesses(Id recordId){
       System.debug('in fetchApprovalProcesses' +recordId);
      List<ObjectDataModelClass> listOfProcesses =  new List<ObjectDataModelClass>();
      List<ProcessInstanceWorkitem> workItems = [SELECT Id,ProcessInstance.LastActor.Name,ProcessInstance.TargetObject.Name,Actor.Name,ProcessInstanceId,ActorId,ProcessInstance.Status,ProcessInstance.TargetObjectId,ProcessInstance.TargetObject.Type,ProcessInstance.ProcessDefinitionId,ProcessInstance.Id,OriginalActorId FROM ProcessInstanceWorkitem WHERE ProcessInstance.Status='Pending' AND ProcessInstance.TargetObject.Type='AOO_Fee__c'];
      set<id> objectIds = new set<Id>();

      for(ProcessInstanceWorkitem workitemRecord: workItems){
          if(!objectIds.contains(workitemRecord.ProcessInstance.TargetObjectId))
          {
              objectIds.add(workitemRecord.ProcessInstance.TargetObjectId);
          }
      }

      for(ProcessInstanceWorkitem pItem : workItems){
          ObjectDataModelClass odmWrap = new ObjectDataModelClass();
          odmWrap.objProceess = pItem;
            odmWrap.Status =pItem.ProcessInstance.Status;
            odmWrap.isSelected=false;
            odmWrap.ActorName = pItem.Actor.Name;
            odmWrap.lastActorName = pItem.ProcessInstance.LastActor.Name;
            odmWrap.TypeofObject = pItem.ProcessInstance.TargetObject.Type;
            odmWrap.RelatedtoName = pItem.ProcessInstance.TargetObject.Name;
            listOfProcesses.add(odmWrap);
      }
      return listOfProcesses;
    }

    public class ObjectDataModelClass{
        @AuraEnabled public ProcessInstanceWorkitem objProceess{get;set;}
        @AuraEnabled public String RelatedtoName{get;set;}
        @AuraEnabled public Boolean isSelected{get;set;}
        @AuraEnabled public String ActorName{get;set;}
        @AUraEnabled public String Status{get;set;}
        @AuraEnabled public String TypeofObject{get;set;}
        @AuraEnabled public String lastActorName{get;set;}
        
    }
}