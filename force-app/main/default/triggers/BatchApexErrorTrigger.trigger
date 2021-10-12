trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
    List<BatchLeadConvertErrors__c > lstBlce = new List<BatchLeadConvertErrors__c >();
    for(BatchApexErrorEvent baE: Trigger.New){
        BatchLeadConvertErrors__c blce =  new BatchLeadConvertErrors__c();
        blce.AsyncApexJobId__c = baE.AsyncApexJobId;
        blce.Records__c = baE.JobScope;
        blce.StackTrace__c = baE.StackTrace;
        lstBlce.add(blce);
    }
	insert lstBlce;
}