package team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team.project.model.BiddingDTO;
import team.project.model.ProductDTO;
import team.project.model.ProductQuestionDTO;

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
			pstmt.setInt(1, ca_no);
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
					dto.setP_finish(rs.getInt("p_finish"));
					list.add(dto);
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
	
	public ProductDTO productDetailBuy(int p_no) {
		ProductDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "select * from product where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new ProductDTO();
				dto.setP_img1(rs.getString("p_img1"));
				dto.setP_img2(rs.getString("p_img2"));
				dto.setP_img3(rs.getString("p_img3"));
				dto.setP_img4(rs.getString("p_img4"));
				dto.setCa_no(rs.getInt("ca_no"));
				dto.setP_content(rs.getString("p_content"));
				dto.setP_finish(rs.getInt("p_finish"));
				dto.setP_buyerId(rs.getString("p_buyerId"));
				dto.setP_delete(rs.getInt("p_delete"));
				dto.setP_end(rs.getTimestamp("p_end"));
				dto.setP_price(rs.getInt("p_price"));
				dto.setP_maxPrice(rs.getInt("p_maxPrice"));
				dto.setP_minPrice(rs.getInt("p_minPrice"));
				dto.setP_no(rs.getInt("p_no"));
				dto.setP_readCount(rs.getInt("p_readCount"));
				dto.setP_reg(rs.getTimestamp("p_reg"));
				dto.setP_sellerId(rs.getString("p_sellerId"));
				dto.setP_start(rs.getTimestamp("p_start"));
				dto.setP_status(rs.getInt("p_status"));
				dto.setP_title(rs.getString("p_title"));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch (Exception e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch (Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch (Exception e) {e.printStackTrace();}
		}
		return dto;
	}
	
	public List ProductQuestionList(int p_no) {
		List list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "select * from ProductQuestion where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList();
				do {
					ProductQuestionDTO dto = new ProductQuestionDTO();
					dto.setPq_no(rs.getInt("pq_no"));
					dto.setP_no(rs.getInt("p_no"));
					dto.setPq_title(rs.getString("pq_title"));
					dto.setPq_content(rs.getString("pq_content"));
					dto.setUser_id(rs.getString("user_id"));
					dto.setPq_writeReg(rs.getTimestamp("pq_writeReg"));
					dto.setPq_answer(rs.getString("pq_answer"));
					dto.setPq_answerReg(rs.getTimestamp("pq_answerReg"));
					dto.setPq_delete(rs.getInt("pq_delete"));
					list.add(dto);
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
	
	public int ProductQuestionAdd(int p_no, String UID, String pq_title, String pq_content) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "insert into ProductQuestion(pq_no, p_no, pq_title, pq_content, user_id, pq_writeReg, pq_answer, pq_answerReg, pq_delete) ";
			sql += "values(ProductQuestion_seq.nextval,?,?,?,?,sysdate,null,null,0)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.setString(2, pq_title);
			pstmt.setString(3, pq_content);
			pstmt.setString(4, UID);
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();}catch (Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch (Exception e) {e.printStackTrace();}
		}
		return result;
	}
}
