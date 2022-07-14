package team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team.project.model.ProductDTO;

public class BeomSuDAO {
	private Connection getConn() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		
		return ds.getConnection();
	}
	
	public List categorySelect(int ca_no) {
		List list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConn();
			String sql = "select * from product where ca_no=?";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList();
				do {
					ProductDTO dto = new ProductDTO();
					dto.setP_no(rs.getInt("p_no"));
					dto.setP_status(rs.getInt("p_status"));
					dto.setP_title(rs.getString("p_title"));
					dto.setP_price(rs.getInt("p_price"));
					dto.setP_minPrice(rs.getInt("p_minPrice"));
					dto.setP_maxPrice(rs.getInt("p_maxPrice"));
					dto.setCa_no(rs.getInt("ca_no"));
					dto.setP_img1(rs.getString("p_img1"));
					dto.setP_finish(rs.getInt("p_finish"));
					dto.setP_readCount(rs.getInt("p_readCount"));
				}while(rs.next());
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch (Exception e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch (Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch (Exception e) {e.printStackTrace();}
		}
		
		return list;
	}
}
