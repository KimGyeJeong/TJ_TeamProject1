package team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import team.project.model.CategoryDTO;
import team.project.model.OrderListDTO;
import team.project.model.ProductDTO;
public class InstanceDAO {
	

	protected Connection getConnection() throws SQLException, NamingException {
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

	
	
	// 모든 카테고리 리스트 가져오기
	public List<CategoryDTO>  getCategory() {
		List<CategoryDTO> list = null; 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql ="select * from category order by ca_grp asc"; 
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
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
	
	
	
	
	
	
	
	
	


	
	

	
	
	
	
	
	
	
	
	
	// uid 주고 입찰상품정보 가져오기
	public List<ProductDTO>  getSellerProduct(String uid) {
		List<ProductDTO> list = null;
		ProductDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from product where p_status=1 and p_finish=0 and p_sellerid=? and p_delete=0 order by p_reg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<ProductDTO>();
				do {
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
					list.add(dto);
				} while (rs.next());
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return list;
	}
		
	
	
	
	
	//	orderlist 구매확정 하기
	public void updateOrderConfirmation(int Ono) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn= getConnection();
			String sql = "update orderlist set o_pro=3 where o_no=?";
			pstmt.setInt(1, Ono);
			pstmt= conn.prepareStatement(sql);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(pstmt, conn);}
	}
	
	
	
	
	
	
	
	
	
	
	

		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
	// uid 주고 구매한 모든 상품정보 가져오기
	public List<OrderListDTO>  getOrderList(String uid) {
		List<OrderListDTO> list = null;
		OrderListDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from orderlist where o_buyerId=? and o_reg between sysdate-(interval '3' MONTH) and sysdate order by o_reg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<OrderListDTO>();
				do {
					dto = new OrderListDTO();
					dto.setO_no(rs.getInt("o_no"));
					dto.setP_no(rs.getInt("p_no"));
					dto.setP_status(rs.getInt("p_status"));
					dto.setA_no(rs.getInt("a_no"));
					dto.setO_buyerId(uid);
					dto.setO_sellerId(rs.getString("o_sellerId"));
					dto.setO_pro(rs.getInt("o_pro"));
					dto.setO_reg(rs.getTimestamp("o_reg"));
					dto.setO_trackingNo(rs.getInt("o_trackingNo"));
					dto.setO_review(rs.getInt("o_review"));
					list.add(dto);
				} while (rs.next());
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return list;
	}
	
	
	
	
	
	
	
	
	
	
	
	// 상품 한개 갖고오기 feat.p_no
	public ProductDTO  getProduct(int pno) {
		ProductDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select * from product where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pno);
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
		}finally {closeConnection(rs,pstmt,conn);}
		return dto;
	}
	
	
	
	
	// List 주고 상품List 받기 
	public List<ProductDTO> getProductList(List<OrderListDTO> orderlist) {
		List<ProductDTO> list = null;
		if (orderlist != null) {
			list = new ArrayList<ProductDTO>();
			for(int i=0 ; i<orderlist.size() ; i++) {
				int pno = orderlist.get(i).getP_no();
				ProductDTO dto = getProduct(pno);
				list.add(dto);
			}
		}
		return list;
	}

	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
