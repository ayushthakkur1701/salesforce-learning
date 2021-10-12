/*************************************************************************************************************************************************************************
 * @author     Ramaseshu
 * @date       Feb 04, 2019
 * @decription BaseObjectSelector. This class helps to get the queryString and applicable accross all applications
 *************************************************************************************************************************************************************************/
public class BaseObjectSelector {
    
    public final static String SOQL = 'SELECT {0} FROM {1}';
    public final static String SOQL_WHERE = ' WHERE {0}';
    public final static String SOQL_GROUPBY = ' GROUP BY {0}';
    public final static String SOQL_ORDERBY = ' ORDER BY {0}';
    
    /***************************************************************************************************************************
    * SOQL Builder method that builds SOQL SELECT Command from objectApiName, fieldList, parentFieldList, and where clause, and orderBy List, 
    * @param	objectApiName			Name of the object from which records are to be selected
    * @param	fieldSetName		Field Set name from the object
    * @param	fieldList			A list fields to be selected
    * @param	parentFieldList		A list fields to be selected from parent object
    * @param	whereClause			A String of 'where' clause 
    * @param	orderByList			A list of order by fields
    * @return	queryString			Query String
	****************************************************************************************************************************/
    public Static String soqlBuilderWithFieldSet(String objectApiName, String fieldSetName, 
                                                 List<String> parentFieldList, String whereClause, List<String> orderByList) {
        System.debug('objectApiName  '+ objectApiName);
        System.debug('fieldSetName  '+ fieldSetName);
        return soqlBuilder(objectApiName, fieldSetName,NULL, parentFieldList, whereClause, orderByList, -1);
    }
    /***************************************************************************************************************************
    * SOQL Builder method that builds SOQL SELECT Command from objectApiName, fieldList, parentFieldList, and where clause, and orderBy List, 
    * @param	objectApiName			Name of the object from which records are to be selected
    * @param	fieldSetName		Field Set name from the object
    * @param	fieldList			A list fields to be selected
    * @param	parentFieldList		A list fields to be selected from parent object
    * @param	whereClause			A String of 'where' clause 
    * @param	orderByList			A list of order by fields
    * @return	queryString			Query String
	****************************************************************************************************************************/
    public Static String soqlBuilderWithFieldList(String objectApiName, List<String> fieldList, List<String> parentFieldList, String whereClause, List<String> orderByList) {
        return soqlBuilder(objectApiName, '',fieldList, parentFieldList, whereClause, orderByList, -1);
    }
    /***************************************************************************************************************************
    * SOQL Builder method that builds SOQL SELECT Command from objectApiName, fieldList, parentFieldList, and where clause, and orderBy List, 
    * @param	objectApiName			Name of the object from which records are to be selected
    * @param	fieldSetName		Field Set name from the object
    * @param	fieldList			A list fields to be selected
    * @param	parentFieldList		A list fields to be selected from parent object
    * @param	whereClause			A String of 'where' clause 
    * @param	orderByList			A list of order by fields
    * @return	queryString			Query String
	****************************************************************************************************************************/
    public Static String soqlBuilder(String objectApiName,  List<String> parentFieldList, String whereClause, List<String> orderByList) {
        return soqlBuilder(objectApiName, '',NULL, parentFieldList, whereClause, orderByList, -1);
    }
    
   /***************************************************************************************************************************
    * SOQL Builder method that builds SOQL SELECT Command from objectApiName, fieldList, parentFieldList, and where clause, and orderBy List, 
    * @param	objectApiName		Name of the object from which records are to be selected
    * @param	fieldSetName		Field Set name from the object
    * @param	fieldList			A list fields to be selected
    * @param	parentFieldList		A list fields to be selected from parent object
    * @param	whereClause			A String of 'where' clause 
    * @param	orderByList			A list of order by fields
    * @return	queryString			Query String
	****************************************************************************************************************************/
    public Static String soqlBuilder(String objectApiName,  List<String> fieldList, List<String> parentFieldList, String whereClause, List<String> orderByList) {
        return soqlBuilder(objectApiName, '',fieldList, parentFieldList, whereClause, orderByList, -1);
    }
    
   /***************************************************************************************************************************
    * SOQL Builder method that builds SOQL SELECT Command from objectApiName, fieldList, parentFieldList, AND where clause, and orderBy List, and object Limit
    * @param	objectApiName		Name of the object from which records are to be selected
    * @param	fieldSetName		Field Set name from the object
    * @param	fieldList			A list fields to be selected
    * @param	parentFieldList		A list fields to be selected from parent object
    * @param	whereClause			A String of 'where' clause 
    * @param	orderByList			A list of order by fields
    * @param	recordLimit			Maximum number of objects to return (if less than 1, then return all selected objects)
	* @return	queryString			Query String
	****************************************************************************************************************************/
    public Static String soqlBuilder(String objectApiName, String fieldSetName, List<String> fieldList, List<String> parentFieldList, String whereClause, List<String> orderByList, Integer recordLimit) {
        return soqlBuilder(objectApiName,  fieldSetName, fieldList, parentFieldList, whereClause, NULL, orderByList, recordLimit);
    }
    
   /***************************************************************************************************************************
    * SOQL Builder method that builds SOQL SELECT Command from objectApiName, fieldList, parentFieldList, AND where clause, and groupBy List, 
    * 														and orderBy List, and record Limit
    * @param	objectApiName		Name of the object from which records are to be selected
    * @param	fieldList			A list fields to be selected
    * @param	fieldSetName		Field Set name from the object
    * @param	parentFieldList		A list fields to be selected from parent object
    * @param	whereClause			A String of 'where' clause 
    * @param	groupByList			A list of group by clauses
    * @param	orderByList			A list of order by fields
    * @param	objectLimit			Maximum number of objects to return (if less than 1, then return all selected objects)
	* @return	queryString			Query String
	****************************************************************************************************************************/
    public Static String soqlBuilder(String objectApiName, String fieldSetName, 
                                     List<String> fieldList, List<String> parentFieldList, 
                                     String whereClause, List<String> groupByList, List<String> orderByList,
                                     Integer recordLimit) {
        //String fieldSet = 'cht_exposure_query_fields';
        try{
            List<String> queryFieldList = new List<String>();
            // Validations 
            // throw the expection if the object name is blank
            if (String.isBlank(objectApiName)){
                throw new Exception.QueryException('ShellObjectSelector.soqlBuilder: An object api name must be specified');
            }
            Map<String, Schema.SObjectType> sObjectMap = Schema.getGlobalDescribe(); 
            if(sObjectMap.get(objectApiName) == NULL){
                throw new Exception.QueryException('ShellObjectSelector.soqlBuilder: Incorrect object Api Name');
            }
            // Check if fieldList is not Empty
            if(fieldList!= NULL && !fieldList.isEmpty() && fieldList.size()>0) {
                // add only specific fields to queryFieldList if there is no parentfields
                queryFieldList.addAll(fieldList);
            }
            else if(String.isNotBlank(fieldSetName)){
                
                Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
                Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(objectApiName);
                Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
                List<Schema.FieldSetMember> fieldSetMem =  DescribeSObjectResultObj.fieldSets.getMap().get(fieldSetName).getFields();
                if(fieldSetMem != NULL){
                	for(Schema.FieldSetMember f : fieldSetMem) {
                    	queryFieldList.add(f.getFieldPath());
                    }  
                }
            }
            // If fieldList is empty, then add all the fields of the object in the query
            else {
                // Get all the fields of the Object from Schema
                Map<String, Schema.sObjectField> objectFieldMap = Schema.getGlobalDescribe().get(objectApiName).getDescribe().fields.getMap();
                // add only specific fields to queryFieldList if there is no parentfields
                queryFieldList = new List<String>{ String.join(new List<String>(objectFieldMap.keySet()), CoreConstants.DELIMITER_COMMA)};
                    }
            if(parentFieldList != NULL && !parentFieldList.isEmpty() && parentFieldList.size()>0) {
                queryFieldList.addAll(parentFieldList);
            }
            // Start building the query string(queryString) with queryFieldList
            System.debug('==queryFieldList'+queryFieldList);
              System.debug('==SOQL'+SOQL);
            String queryString = String.format(SOQL, new List<String>{String.join(queryFieldList,  CoreConstants.DELIMITER_COMMA), objectApiName});
  System.debug('==queryString'+queryString);            
            // Check if the whereClause is not blank then add this to the queryString string
            if(String.isNotBlank(whereClause)) {
                queryString += String.format(SOQL_WHERE, new List<String>{whereClause});
            }
            // Check if the groupByList is not Empty then add this to the queryString string
            if (groupByList != NULL && !groupByList.isEmpty() && groupByList.size()>0 ) {
                queryString += String.format(SOQL_GROUPBY, new List<String>{String.join(groupByList, CoreConstants.DELIMITER_COMMA)});
            }
            // Check if the orderByList is not Empty then add this to the queryString string
            if (orderByList != NULL && !orderByList.isEmpty() && orderByList.size()>0) {
                queryString += String.format(SOQL_ORDERBY, new List<String>{String.join(orderByList, ', ')});
            }
            // Check if the objectLimit is greater than 0 and add this to the queryString string
            if (recordLimit > 0) {
                queryString += ' LIMIT ' + String.valueOf(recordLimit).replace(CoreConstants.DELIMITER_COMMA, CoreConstants.BLANK_STRING);
            }
            return queryString;
        }
        catch (Exception ex){
            System.debug('==finalsoqlBuilder=='+ ex.getLineNumber()+ '=='+ ex.getMessage());
            return null;
        }
    }
}