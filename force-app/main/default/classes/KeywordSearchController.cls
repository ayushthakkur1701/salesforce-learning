public with sharing class KeywordSearchController {

 //Page Size
 private Static Final Integer PAGE_NUMBER = 25;
 
  //Search String used in ArticleList tag
 public String searchstring { get; set; }

 public  List<KnowledgeArticleVersion> articleList;

 public List<FAQ__DataCategorySelection> dataCategory;
 
 public KeywordSearchController() {
 String qryString = 'SELECT Id, title, UrlName, LastPublishedDate,LastModifiedById FROM KnowledgeArticleVersion WHERE (PublishStatus = \'online\' and Language = \'en_US\')';
  articleList= Database.query(qryString);
     
  maxSize = articleList.size() ;
 }
 
 //Keeps track of current page & max size of article list
 Integer currentPage = 1;
 Integer maxSize = 1;
 
 // Returns whether we need to see previous button or not
 public boolean getPrevRequired() {
  return currentPage > 1;
 }

 // Returns whether we need to see next button or not
 public boolean getNextRequired() {
  return currentPage * PAGE_NUMBER < maxSize;
 }
 
 //Returns current page number 
 public Decimal getCurrentPageNumber() {
  return this.currentPage;
 }

 //action for next click
 public PageReference next() {
  if(maxSize > this.currentPage * PAGE_NUMBER) {
   this.currentPage = this.currentPage + 1;
  }
  return null;
 }    
 
 //action for previous click
 public PageReference previous() {        
  if(this.currentPage > 1)
   this.currentPage = this.currentPage - 1;
  return null;
 }

public List<SelectOption> getDataCategory()
{
 
      
    	List<SelectOption> options = new List<SelectOption>();
    	List<FAQ__kav> faqList  = new List<FAQ__kav>();
    	faqList = [SELECT id ,Title FROM FAQ__kav WHERE PublishStatus='online'AND language ='en_US'];
    	
    	For(FAQ__kav fq: faqList)
        {
            id artId = fq.id;
            dataCategory = [Select toLabel(DataCategoryName),ParentId FROM FAQ__DataCategorySelection where ParentId=:artId LIMIT 1];
			
            for(FAQ__DataCategorySelection faq:dataCategory){
                options.add(new SelectOption(faq.ParentId,faq.DataCategoryName));
            }
        }
        System.debug('options > '+options);
        return options;
 
}


}