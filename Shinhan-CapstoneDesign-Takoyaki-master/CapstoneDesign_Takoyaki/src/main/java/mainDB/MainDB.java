package mainDB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MainDB {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet competitionsResultSet;
	private ResultSet externalResultSet;
	
	public MainDB() {
		try {
			String dbURL = "AWS_RDS_ADDRESS";
			String dbID = "DBID";
			String dbPW = "DBPW";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPW);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<Competition> recentContent() {
	    String contSQL = "SELECT * FROM competitions ORDER BY contid DESC LIMIT 3";
	    List<Competition> competitionList = new ArrayList<>();
	    
	    try {
	        pstmt = conn.prepareStatement(contSQL);
	        competitionsResultSet = pstmt.executeQuery();
	        while (competitionsResultSet.next()) {
	            Competition competition = new Competition();
	            competition.setTitle(competitionsResultSet.getString("title"));
	            competition.setLocation(competitionsResultSet.getString("location"));
	            competition.setDate(competitionsResultSet.getString("date"));
	            competition.setHref(competitionsResultSet.getString("href"));
	            competition.setContid(competitionsResultSet.getInt("contid"));
	            competitionList.add(competition);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return competitionList;
	}

	public List<External> recentExternal() {
	    String extSQL = "SELECT * FROM externals ORDER BY extid DESC LIMIT 3";
	    List<External> externalList = new ArrayList<>();
	    
	    try {
	        pstmt = conn.prepareStatement(extSQL);
	        externalResultSet = pstmt.executeQuery();
	        while (externalResultSet.next()) {
	            External external = new External();
	            external.setTitle(externalResultSet.getString("title"));
	            external.setLocation(externalResultSet.getString("location"));
	            external.setDate(externalResultSet.getString("date"));
	            external.setHref(externalResultSet.getString("href"));
	            external.setExtid(externalResultSet.getInt("extid"));
	            externalList.add(external);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return externalList;
	}
}
