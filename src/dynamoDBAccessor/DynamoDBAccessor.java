package dynamoDBAccessor;

import java.util.ArrayList;
import java.util.Iterator;

import com.amazonaws.util.json.JSONException;
import com.amazonaws.util.json.JSONObject;

import dynamoDB.*;

public class DynamoDBAccessor {
	// params to pass through accessor
	private String userid;
	private String beginTimestamp;
	private String endTimestamp; 
	private DynamoDBInterface db;
	private ArrayList<JSONObject> jsonData;
	
	public DynamoDBAccessor() {
		this.userid = "Hrt85AC1L7";
		this.beginTimestamp = "0000-00-00";
		this.endTimestamp = "9999-99-99";
		this.db = new DynamoDBInterfaceImpl();
		this.jsonData = this.db.getData(this.userid, this.beginTimestamp, this.endTimestamp, 
				null, "MelonPractice");
	}
	
	public ArrayList<String> getSelectAttr() throws JSONException{
		ArrayList<String> selectAttrs = new ArrayList<String>();
		 Iterator<JSONObject> it = jsonData.iterator();
		 while (it.hasNext()){
			 selectAttrs.add((String)it.next().get("focus1"));
		 }
		 return selectAttrs;
	}
	
	public static void main(String[] args) throws JSONException {
		DynamoDBAccessor db = new DynamoDBAccessor();
		System.out.println(db.getSelectAttr().toString());
	}
}
