package team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import team.project.model.CategoryDTO;
public class InstanceDAO {
	

	private Connection getConnection() throws SQLException, NamingException {
		Context ctx = new InitialContext();
		Context env = (Context) ctx.lookup("java:comp/env");
		DataSource ds = (DataSource) env.lookup("jdbc/orcl");
		return ds.getConnection();
	}

	private void closeConnection(PreparedStatement pstmt, Connection conn) {
		if (pstmt != null) { try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
		if (conn != null) { try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
	}
	private void closeConnection(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		if (rs != null) { try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
		if (pstmt != null) { try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
		if (conn != null) { try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
	}

	
	
	
	
	
	
	
	
	public List<CategoryDTO>  getCategory() {
		List<CategoryDTO> list = null; 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql ="select * from category"; 
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			System.out.println(1);
			if(rs.next()) {
				list = new ArrayList<CategoryDTO>();
				do {
					CategoryDTO dto = new CategoryDTO();
					dto.setCa_no(rs.getInt("ca_no"));
					dto.setCa_name(rs.getString("ca_name"));
					dto.setCa_level(rs.getInt("ca_level"));
					dto.setCa_grp(rs.getInt("ca_grp"));
					list.add(dto);
				} while (rs.next());
			}else{
				System.out.println("getCategory = 0");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return list;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
