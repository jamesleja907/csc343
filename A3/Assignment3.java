import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class Assignment3 extends JDBCSubmission {
	
    public Assignment3() throws ClassNotFoundException {
        Class.forName("org.postgresql.Driver");
    }

    @Override
    public boolean connectDB(String url, String username, String password) {
	    //write your code here.
    	try {
    		connection = DriverManager.getConnection(url, username, password);
    		if (connection != null) {
    			return true;
    		} 
        // Do we need to catch a specific exception?
        // Return false in catch? Yells at you if no false outside of try
    	} catch (SQLException e) {
    		e.printStackTrace();
    		//return false;
    	}
    	return false;
    }

    @Override
    public boolean disconnectDB() {
	    //write your code here.
            try {
				connection.close();
				if (connection.isClosed()) {
					return true;
				}
				return false;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
    }

    @Override
    public ElectionResult presidentSequence(String countryName) {
        ElectionResult result = null;
        try {
            List<Integer> presidentIds = new ArrayList<Integer>();
            List<String> partyNames = new ArrayList<String>();
            PreparedStatement presidentStat = connection.prepareStatement(
                "SELECT politician_president.id, party.name " +
                "from politician_president join party " + 
                "on politician_president.party_id = party.id join country " +
                "on country.id = politician_president.country_id " +
                "where country.name = " + "\'" + countryName + "\' " +
                "order by politician_president.start_date desc;");
            ResultSet presidents = presidentStat.executeQuery();
            while (presidents.next()) {
                int currentPresident = presidents.getInt(1);
                String currentParty = presidents.getString(2);
                presidentIds.add(currentPresident);
                partyNames.add(currentParty);
            }
            result = new ElectionResult(presidentIds, partyNames);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;    
	}

    @Override
    public List<Integer> findSimilarParties(Integer partyId, Float threshold) {
	//Write your code here.
        // This method currently fails, not sure if its because of the helper though.
        List<Integer> similarParties = new ArrayList<Integer>();
        int tempId = partyId;
        // Double doubleThreshold = (Double) threshold;
        // Double doubleThreshold = new FloatingDecimal(threshold.floatValue()).doubleValue();
        try {
            PreparedStatement getParties = connection.prepareStatement(
                "SELECT id, description from party;");
            PreparedStatement comparedParty = connection.prepareStatement(
                "Select id, description from party where id = ?");
                //+ Integer.toString(partyId) + " ;");
            comparedParty.setInt(1, tempId);
            ResultSet allParties = getParties.executeQuery();
            ResultSet singleParty = comparedParty.executeQuery();
            String comparedDescription = singleParty.getString(2);
            while (allParties.next()) {
                String currentDescription = allParties.getString(2);
                int currentParty = allParties.getInt(1);
                if (similarity(currentDescription, comparedDescription) >= threshold) {
                    similarParties.add(currentParty);
                }

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return similarParties;
    }

    public static void main(String[] args) throws Exception {
   	    //Write code here. 
    	// Didn't they say no print statements?
	    // System.out.println("Hellow World");
	    Assignment3 a3 = new Assignment3();
	    String url = "dbc:postgresql://localhost:5432/csc343h-lejajame";
	    String username = "lejajame";
        Float f = 0.3f;
	    boolean connected = a3.connectDB(url, username, "");
	    if (connected) {
	    	System.out.println("Connected hooray");
            List<Integer> result = a3.findSimilarParties(401, f);
            System.out.println(result.toString());
	    }
	    boolean disconnected = a3.disconnectDB();
    }

}



