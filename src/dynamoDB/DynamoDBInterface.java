package dynamoDB;

import java.util.ArrayList;

import com.amazonaws.util.json.JSONObject;

public interface DynamoDBInterface {

	// get processed data based on specified keys
	public ArrayList<JSONObject> getData(String userid, String beginTimestamp,
			String endTimestamp, ArrayList<String> keyArray, String tableName);

	// get attributes (columns) of database
	public ArrayList<String> getAttributes();

}
