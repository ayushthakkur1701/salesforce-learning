public class MyController {
    
    public string myString{
        get{
            if(myString==null){
                myString='a';
            }
            return myString;
            
        }private set;
    }

    public string getMyString(){
        return 'getmyString';
    }
    
    public String getStringMethod(){
        if(myString==null){
            myString='b';
        }
        return myString;
    }
}