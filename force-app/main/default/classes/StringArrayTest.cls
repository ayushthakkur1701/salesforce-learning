public class StringArrayTest {

    public static List<String> generateStringArray(Integer size)
    {
        	String[] listString = new List<String>();
        	for(integer i =0; i<size;i++)
            {
                listString.add('Test ' + i);
                system.debug('>>>> ' + listString[i]);
            }
        	
        return listString;
        	
    }
}