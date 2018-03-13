import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class Assignment3 extends JDBCSubmission {
	// add conn field.
	Connection conn;
    public Assignment3() throws ClassNotFoundException {
        Class.forName("org.postgresql.Driver");
    }

    @Override
    public boolean connectDB(String url, String username, String password) {
	    //write your code here.
    	try {
    		conn = DriverManager.getConnection(url, username, password);
    		if (conn != null) {
    			return true;
    		}
        // Do we need to catch a specific exception?
        // Return false in catch? Yells at you if no false outside of try
    	} catch (SQLException e) {
    		e.printStackTrace();
    		
    	}
    	return false;
    }

    @Override
    public boolean disconnectDB() {
	    //write your code here.
            try {
				conn.close();
				if (conn.isClosed()) {
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
            //Write your code here.
            return null;
	}

    @Override
    public List<Integer> findSimilarParties(Integer partyId, Float threshold) {
	//Write your code here.
        return null;
    }

    public static void main(String[] args) throws Exception {
   	    //Write code here. 
    	// Didn't they say no print statements?
	    System.out.println("Hellow World");
	    Assignment3 a3 = new Assignment3();
	    String url = "dbc:postgresql://localhost:5432/csc343h-lejajame";
	    String username = "lejajame";
	    boolean connected = a3.connectDB(url, username, "");
	    if (connected) {
	    	System.out.println("Connected hooray");
	    }
	    boolean disconnected = a3.disconnectDB();
    }

}



