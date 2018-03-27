import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class Assignment3 extends JDBCSubmission {
    // See JDBCSubmission.java for javadocs
     
    public Assignment3() throws ClassNotFoundException {
        Class.forName("org.postgresql.Driver");
    }

    @Override
    public boolean connectDB(String url, String username, String password) {
    	try {
    		connection = DriverManager.getConnection(url, username, password);
    		if (connection != null) {
    			return true;
    		}
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
    	return false;
    }

    @Override
    public boolean disconnectDB() {
        try {
			connection.close();
            // Check if connection is closed before returning true
			if (connection.isClosed()) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
        return false;
    }

    @Override
    public ElectionResult presidentSequence(String countryName) {
        ElectionResult result = null;
        // ArrayLists to be passed to ElectionResult
        List<Integer> presidentIds = new ArrayList<Integer>();
        List<String> partyNames = new ArrayList<String>(); 
        try {
            // Get the president_ids and party_name using countryName
            PreparedStatement presidentStat = connection.prepareStatement(
                "SELECT politician_president.id, party.name " +
                "from politician_president join party " +
                "on politician_president.party_id = party.id join country " +
                "on country.id = politician_president.country_id " +
                "where country.name = " + "\'" + countryName + "\' " +
                "order by politician_president.start_date desc;");
            ResultSet presidents = presidentStat.executeQuery();
            // iterate over the ResultSet, adding the president and party to the lists
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
        List<Integer> similarParties = new ArrayList<Integer>();
        try {
            // get the id and description of all the parties except the one with id=partyId
            PreparedStatement getParties = connection.prepareStatement(
                "SELECT id, description from party where id != " + 
                Integer.toString(partyId) + ";");
            // get the description of the party to be compared for similarity
            PreparedStatement comparedParty = connection.prepareStatement(
                "SELECT description from party where id =  " + 
                Integer.toString(partyId) + ";");
            ResultSet singleParty = comparedParty.executeQuery();
			// call next() to advance the cursor to the first row of the result
            singleParty.next();
            String comparedDescription = singleParty.getString(2);
            ResultSet allParties = getParties.executeQuery();
            // iterate over allParties, adding the currentParty to our result iff
            // the description is similar enough to comparedDescription
            while (allParties.next()) {
                String currentDescription = allParties.getString(2);
                int currentParty = allParties.getInt(1);
                // see JDBCSubmission.java for similarity method
                if ((similarity(currentDescription, comparedDescription)) >= threshold) {
                    similarParties.add(currentParty);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return similarParties;
    }

    public static void main(String[] args) throws Exception {}
}
