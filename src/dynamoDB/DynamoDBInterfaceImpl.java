package dynamoDB;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient;
import com.amazonaws.services.dynamodbv2.document.DynamoDB;
import com.amazonaws.services.dynamodbv2.document.Item;
import com.amazonaws.services.dynamodbv2.document.RangeKeyCondition;
import com.amazonaws.services.dynamodbv2.document.ScanOutcome;
import com.amazonaws.services.dynamodbv2.document.Table;
import com.amazonaws.services.dynamodbv2.document.spec.QuerySpec;
import com.amazonaws.services.dynamodbv2.document.ItemCollection;
import com.amazonaws.services.dynamodbv2.document.QueryOutcome;
import com.amazonaws.util.json.JSONException;
import com.amazonaws.util.json.JSONObject;

public class DynamoDBInterfaceImpl implements DynamoDBInterface {

	AmazonDynamoDBClient dynamoDB;
	DynamoDB db;

	/**
	 * The only information needed to create a client are security credentials
	 * consisting of the AWS Access Key ID and Secret Access Key. All other
	 * configuration, such as the service endpoints, are performed
	 * automatically. Client parameters, such as proxies, can be specified in an
	 * optional ClientConfiguration object when constructing a client.
	 *
	 * @see com.amazonaws.auth.BasicAWSCredentials
	 * @see com.amazonaws.auth.ProfilesConfigFile
	 * @see com.amazonaws.ClientConfiguration
	 */
	private DynamoDB initDB() {
		/*
		 * The ProfileCredentialsProvider will return your [MelonUser]
		 * credential profile by reading from the credentials file located at
		 * (/Users/teresa/.aws/credentials).
		 */
		dynamoDB = null;
		AWSCredentials credentials = null;
		try {
			// ExternalUser is defined by AWS IAM service - credentials (access
			// key and secret access key) are environmental vars
			credentials = new ProfileCredentialsProvider("ExternalUser")
					.getCredentials();
			System.out.println("credentials: " + credentials);
		} catch (Exception e) {
			e.printStackTrace();
		}
		dynamoDB = new AmazonDynamoDBClient(credentials);
		Region usStandard = Region.getRegion(Regions.US_EAST_1);
		dynamoDB.setRegion(usStandard);

		db = new DynamoDB(dynamoDB);

		return db;
	}// end initDB

	// //////////////////////////////// PUBLIC
	// //////////////////////////////////////////////////////

	public ArrayList<JSONObject> getData(String userid, String beginTimestamp,
			String endTimestamp, ArrayList<String> keyArray, String tableName) {

		if (tableName == null) {
			tableName = "MelonPractice";
		}

		String keys;
		Map<String, String> nameMap1 = new HashMap<String, String>();
		if (keyArray != null) {

			keys = "";
			for (String k : keyArray) {
				keys = keys + "#" + k + ", ";
				nameMap1.put("#" + k, k);
			}
			keys = keys.substring(0, keys.length() - 2);
		} else {
			keys = null;
		}

		ArrayList<JSONObject> data = new ArrayList<JSONObject>();

		// set up - see
		// http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/QueryingJavaDocumentAPI.html
		DynamoDB db = initDB();
		Table table = db.getTable(tableName);

		if (userid == null) {
			// SCAN because no userid

			// use scan
			Map<String, Object> expressionAttributeValues = new HashMap<String, Object>();
			Map<String, String> expressionAttributeNames = new HashMap<String, String>();

			// timestamp is a dynamodb key word, so need to use placeholder
			// http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ReservedWords.html
			expressionAttributeNames.put("#timestampkey", "timestamp");

			if (beginTimestamp != null) {
				expressionAttributeValues.put(":beginning", beginTimestamp);
				System.out.println("beginning: " + beginTimestamp);
			} else {
				expressionAttributeValues.put(":beginning",
						"0000-00-00 00:00:00 GMT");
			}
			if (endTimestamp != null) {
				expressionAttributeValues.put(":ending", endTimestamp);
				System.out.println("ending: " + endTimestamp);
			} else {
				expressionAttributeValues.put(":ending",
						"3000-00-00 00:00:00 GMT");
			}

			ItemCollection<ScanOutcome> items = table.scan(
					"#timestampkey BETWEEN :beginning AND :ending", // FilterExpression
					keys, // ProjectionExpression - returns all items by default
					expressionAttributeNames, // ExpressionAttributeNames
					expressionAttributeValues);

			// System.out.println(expressionAttributeValues);

			System.out.println("Scan of " + tableName);

			Iterator<Item> iterator = items.iterator();
			System.out.println("items: " + items);

			while (iterator.hasNext()) {
				String dat = iterator.next().toJSONPretty();
				// System.out.println(dat);
				try {

					JSONObject jsonObject = new JSONObject(dat);
					data.add(jsonObject);

				} catch (JSONException e) {
					e.printStackTrace();
					return null;
				}

			}

		} else {
			// QUERY with userId
			System.out.println(userid);
			// get the data from dynamodb that match timestamp keys
			RangeKeyCondition rangeCondition;
			if (beginTimestamp != null && endTimestamp != null) {
				rangeCondition = new RangeKeyCondition("timestamp").between(
						beginTimestamp, endTimestamp);
			} else if (beginTimestamp != null) {
				rangeCondition = new RangeKeyCondition("timestamp")
						.gt(beginTimestamp);
			} else if (endTimestamp != null) {
				rangeCondition = new RangeKeyCondition("timestamp")
						.lt(endTimestamp);
			} else {
				rangeCondition = null;
			}
			// use query
			QuerySpec querySpec;
			if (keys == null) {
				querySpec = new QuerySpec().withHashKey("userId", userid)
						.withRangeKeyCondition(rangeCondition)
						.withConsistentRead(true);

			} else {
				// System.out.println(keys);
				// System.out.println(rangeCondition);
				querySpec = new QuerySpec().withHashKey("userId", userid)
						.withRangeKeyCondition(rangeCondition)
						.withConsistentRead(true)
						.withProjectionExpression(keys).withNameMap(nameMap1);
			}
			ItemCollection<QueryOutcome> items = table.query(querySpec);
			Iterator<Item> iterator = items.iterator();

			// System.out.println("Query: printing results...");

			while (iterator.hasNext()) {
				String dat = iterator.next().toJSONPretty();
				// System.out.println(dat);
				try {

					JSONObject jsonObject = new JSONObject(dat);
					data.add(jsonObject);

				} catch (JSONException e) {
					e.printStackTrace();
					return null;
				}

			}// while iterator
		}// if userid==null

		return data;

	}// /////end getData

	public ArrayList<String> getAttributes() {

		ArrayList<String> attributes = new ArrayList<String>();

		// first get primary attributes
		// attributes.add("userId");
		// attributes.add("timestamp");

		// next, get secondary attributes from the last 5
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -10);
		String today = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
		// System.out.println(today);
		ArrayList<JSONObject> lastData = getData(null, today, null, null,
				"MelonPractice");

		for (int i = 0; i < lastData.size(); i++) {
			JSONObject json = lastData.get(i);
			String[] keys = JSONObject.getNames(json);
			for (int j = 0; j < keys.length; j++) {
				if (!attributes.contains(keys[j]) && !keys[j].contains("Hz")) {// exclude
																				// ampspec
																				// data
					attributes.add(keys[j]);
				}
			}
		}

		return attributes;

	}// ///end getAttributes

}
