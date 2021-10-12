public class NewCaseListController {
    
    private String val = 'New';
    
    public List<Case> getNewCases()
    {
        List<Case> cases = [SELECT Id,CaseNumber FROM Case WHERE status='New'];            
        return cases;
    }

}