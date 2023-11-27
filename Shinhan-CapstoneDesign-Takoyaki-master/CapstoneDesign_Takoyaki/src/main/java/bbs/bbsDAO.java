package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class bbsDAO {
	
	private Connection conn;
	private ResultSet rs;

	public bbsDAO() {
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
	public String getDate() {
		String SQL ="SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {
		String SQL ="SELECT bbsID FROM bbs ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1)+1;				
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(String bbsTitle, String id, String bbsContent) {
			String SQL ="INSERT INTO bbs VALUES (?, ?, ?, ?, ?, ?)";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1,  getNext());
				pstmt.setString(2,  bbsTitle);
				pstmt.setString(3,  id);
				pstmt.setString(4,  getDate());
				pstmt.setString(5,  bbsContent);
				pstmt.setInt(6,  1);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
	
	public ArrayList<bbs> getList(int pageNumber){
			String SQL ="SELECT * FROM bbs WHERE bbsID < ? AND bbsAvaiLable = 1 ORDER BY bbsID DESC LIMIT 10";
			ArrayList<bbs> list = new ArrayList<bbs>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext()- (pageNumber - 1) * 10);
				rs = pstmt.executeQuery();
				while (rs.next()) {
				bbs Bbs = new bbs();
				Bbs.setBbsID(rs.getInt(1));
				Bbs.setBbsTitle(rs.getString(2));
				Bbs.setuserid(rs.getString(3));
				Bbs.setBbsDate(rs.getString(4));
				Bbs.setBbsContent(rs.getString(5));
				Bbs.setBbsAvaiLable(rs.getInt(6));
				list.add(Bbs);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return list;
	}
		public boolean nextPage(int pageNumber) {
			String SQL ="SELECT * FROM bbs WHERE bbsID < ? AND bbsAvaiLable = 1";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext()- (pageNumber - 1) * 10);
				rs = pstmt.executeQuery();
				if (rs.next()) {
				 return true;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}
		
		public bbs getbbs(int bbsID) {
			String SQL ="SELECT * FROM bbs WHERE bbsID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, bbsID);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bbs Bbs = new bbs();
					Bbs.setBbsID(rs.getInt(1));
					Bbs.setBbsTitle(rs.getString(2));
					Bbs.setuserid(rs.getString(3));
					Bbs.setBbsDate(rs.getString(4));
					Bbs.setBbsContent(rs.getString(5));
					Bbs.setBbsAvaiLable(rs.getInt(6));
					return Bbs;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
			
		}
		public int update(int bbsID, String bbsTitle, String bbsContent) {
			String SQL ="UPDATE bbs SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1,  bbsTitle);
				pstmt.setString(2,  bbsContent);
				pstmt.setInt(3, bbsID);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
			
		}
		public int delete(int bbsID) {
			String SQL ="UPDATE bbs SET bbsAvaiLable = 0 WHERE bbsID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1,  bbsID);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
}
