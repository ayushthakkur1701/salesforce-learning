public class AccountController {

//Added a comment to test CICD
  static string CS_NAME='Configuration';

  public static List<Account> getAllActiveAccounts() {
    return [SELECT Id,Name,Active__c FROM Account WHERE Active__c = 'Yes'];
  }

      @AuraEnabled(cacheable=true)
      public static List<sObject> findAccounts(){
        List<String> orderByList = new List<String>();
        //orderByList.add('order by CreatedDate desc');
        ObjectAndFieldSetDetails objFsetdeatils = AccountController.getConfigurationDetails();
        String queryString = BaseObjectSelector.soqlBuilderWithFieldSet(objFsetdeatils.OBJECTNAME, objFsetdeatils.OBJECTFIELDSETNAME,NULL,NULL,null);// AND OwnerId=:currentUserId
        System.debug(Database.query(queryString));
        //List<FieldSetMemberWrapperClass> lstWrap = AccountController.getFieldSetMember();
        return Database.query(queryString);
      
      
      }

      private static ObjectAndFieldSetDetails getConfigurationDetails(){

        System.debug('Map of Object name and field set :+++++++++++++++++');
        Map<string,Reusable_Approval_Configuration__c> mapApprovalConfig = Reusable_Approval_Configuration__c.getAll();
        System.debug('Map of Object name and field set :');
        ObjectAndFieldSetDetails objectAndfieldSet =  new ObjectAndFieldSetDetails();
        objectAndfieldSet.OBJECTNAME = mapApprovalConfig.get(CS_NAME).Object_Api_Name__c;
        objectAndfieldSet.OBJECTFIELDSETNAME = mapApprovalConfig.get(CS_NAME).FieldSet_Name__c;
        
        return objectAndfieldSet;

      }

      @AuraEnabled(cacheable=true)
    public static String getFieldSetMember(){
      ObjectAndFieldSetDetails objFsetdeatils = AccountController.getConfigurationDetails();
        List<FieldSetMemberWrapperClass> wrapperList = new List<FieldSetMemberWrapperClass>();
        Schema.SObjectType sObj = Schema.getGlobalDescribe().get(objFsetdeatils.OBJECTNAME);
        
        for(Schema.FieldSetMember fieldMember : sObj.getDescribe().fieldSets.getMap().get(objFsetdeatils.OBJECTFIELDSETNAME).getFields()){
            FieldSetMemberWrapperClass wrapper = new FieldSetMemberWrapperClass();
            wrapper.isDBRequired = fieldMember.getDbRequired();
            wrapper.isRequired = fieldMember.getRequired();
            wrapper.fieldType = String.valueOf(fieldMember.getType());
            wrapper.fieldLabel = fieldMember.getLabel();
            wrapper.fieldAPIName = fieldMember.getFieldPath();
            if(String.valueOf(fieldMember.getType()) == 'PICKLIST' || 
               				String.valueOf(fieldMember.getType()) == 'MULTIPICKLIST'){
                wrapper.pickListValues = sObj.getDescribe().fields.getMap().get(fieldMember.getFieldPath())
                    									   .getDescribe().getPicklistValues();
            }
            wrapperList.add(wrapper);
        }
        System.debug('#### wrapperList '+wrapperList);
        
       return JSON.serialize(wrapperList);
      // System.System.debug(JSON.serialize(wrapperList));
    }

    /*
     @Description: Method to push selected record in approval process.
    */
    @AuraEnabled(cacheable=false)
    public static String submitRecordsApproval( List<ID> recIdList,String submitComment)
    {
        Integer failedCount=0;
        String Message='';
        String Status='';
        List<Approval.ProcessSubmitRequest> submitReqList = new List<Approval.ProcessSubmitRequest>(); 
        System.debug(recIdList);
        try {
          for(Id recordID:recIdList){
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setObjectId(recordID);
            req.setComments(submitComment);
            //req.setNextApproverIds(new List<Id>{UserInfo.getUserId()});
            submitReqList.add(req);
        } 
            
        System.debug(submitReqList);   
        if(submitReqList.size()>0) {
            Approval.ProcessResult[] processResults = Approval.process(submitReqList);
            for(Integer i=0;i<processResults.size();i++)
            {
                if(!processResults.get(i).isSuccess())
                {
                    failedCount++;
                }
            }
            Integer totalRecords = submitReqList.Size();
            integer SuccessRecords = totalRecords - failedCount;
            System.debug(SuccessRecords); 
            Message = 'Success: ';//+SuccessRecords+'<br/> Failed: '+failedCount+'';
            //sendEMail(submitComment);
            return Message;
        }        
          
        } catch (Exception ex) {
          System.debug(ex.getCause() +' '+ex.getLineNumber()+' '+ex.getMessage()+' '+ex.getStackTraceString());
          Message = ex.getCause() +' '+ex.getLineNumber()+' '+ex.getMessage()+' '+ex.getStackTraceString();
          return Message;
        }
        
        return null;
    }

    /*
      * @Description : Wrapper class contains the information about object name and fieldset
    */ 
   
    public class ObjectAndFieldSetDetails{
      @AuraEnabled
      public String OBJECTNAME{ get; set; }
      @AuraEnabled
      public String OBJECTFIELDSETNAME{ get; set; }
     

    }
    /*
     * @Description : Wrapper class contains the information about all the fields of a FieldSet
     */ 
    
    public class FieldSetMemberWrapperClass{
        
      @AuraEnabled
      public Boolean isDBRequired{ get; set; }
      @AuraEnabled
      public Boolean isRequired{ get; set; }
      @AuraEnabled
      public String fieldType{ get; set; }
      @AuraEnabled
      public String fieldLabel{ get; set; }
      @AuraEnabled
      public String fieldAPIName{ get; set; }
      @AuraEnabled
      public List<Schema.PicklistEntry> pickListValues { get; set; }
      
  }
}