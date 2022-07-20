package team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team.project.model.AddressDTO;
import team.project.model.BiddingDTO;
import team.project.model.CategoryDTO;
import team.project.model.ProductDTO;
import team.project.model.ProductQuestionDTO;
import team.project.model.UserListDTO;

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
		int result = -1;
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
	
	public int RportAdd(int p_no, String UID, String rp_title, String rp_content, String rp_reportedUid, String rp_reason) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "insert into Report(RP_NO, RP_REASON, RP_TITLE, RP_CONTENT, RP_REPORTUID, RP_REPORTEDUID, RP_PRO, P_NO, RP_REG) ";
			sql+= "values(report_seq.nextval, ?, ?, ?, ?, ?, 0, ?, sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rp_reason);
			pstmt.setString(2, rp_title);
			pstmt.setString(3, rp_content);
			pstmt.setString(4, UID);
			pstmt.setString(5, rp_reportedUid);
			pstmt.setInt(6, p_no);
			
			result = pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch (Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch (Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	public int WishAdd(int p_no, String UID) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "insert into WishList values(?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.setString(2, UID);
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch (Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch (Exception e) {e.printStackTrace();}
		}
		
		return result;
	}
	
	public int productBuyerSet(int p_no, String UID) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update Product set p_buyerId=? where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(2, p_no);
			pstmt.setString(1, UID);
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch (Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch (Exception e) {e.printStackTrace();}
		}
		
		return result;
	}
	
	public AddressDTO addressCheck(String UID) {
		AddressDTO addDTO = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "select * from Address where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, UID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				addDTO = new AddressDTO();
				addDTO.setA_address(rs.getString("a_address"));
				addDTO.setA_address2(rs.getString("a_address2"));
				addDTO.setA_comment(rs.getString("a_comment"));
				addDTO.setA_name(rs.getString("a_name"));
				addDTO.setA_no(rs.getInt("a_no"));
				addDTO.setA_tag(rs.getString("a_tag"));
				addDTO.setA_zipCode(rs.getInt("a_zipCode"));
				addDTO.setUser_id(UID);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch (Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch (Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch (Exception e) {e.printStackTrace();}
		}
		
		return addDTO;
	}
	
	public AddressDTO addressCheck(String UID, int a_no) {
		AddressDTO addDTO = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "select * from Address where user_id=? and a_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, UID);
			pstmt.setInt(2, a_no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				addDTO = new AddressDTO();
				addDTO.setA_address(rs.getString("a_address"));
				addDTO.setA_address2(rs.getString("a_address2"));
				addDTO.setA_comment(rs.getString("a_comment"));
				addDTO.setA_name(rs.getString("a_name"));
				addDTO.setA_no(a_no);
				addDTO.setA_tag(rs.getString("a_tag"));
				addDTO.setA_zipCode(rs.getInt("a_zipCode"));
				addDTO.setUser_id(UID);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch (Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch (Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch (Exception e) {e.printStackTrace();}
		}
		
		return addDTO;
	}
	
	public int biddingInput(String UID, int b_bidding, int p_no) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "insert into Bidding(B_NO, P_NO, B_BIDDING, USER_ID, B_REG) ";
			sql += "values(Bidding_seq.nextval, ?, ?, ?, sysdate) where b_status=0";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.setInt(2, b_bidding);
			pstmt.setString(3, UID);
			result = pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch (Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch (Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	public UserListDTO userCheck(String UID) {
		UserListDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "select * from UserList where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, UID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new UserListDTO();
				dto.setUser_id(UID);
				dto.setUser_pw(rs.getString("user_pw"));
				dto.setUser_email(rs.getString("user_email"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_phone(rs.getString("user_phone"));
				dto.setUser_money(rs.getInt("user_money"));
				dto.setUser_usemoney(rs.getInt("user_usemoney"));
				dto.setUser_stars(rs.getInt("user_stars"));
				dto.setUser_img(rs.getString("user_img"));
				dto.setUser_reg(rs.getTimestamp("user_reg"));
				dto.setUser_delete(rs.getInt("user_delete"));
				dto.setUser_deleteReg(rs.getTimestamp("user_deleteReg"));
				dto.setUser_activeReg(rs.getTimestamp("user_activeReg"));
				dto.setUser_report(rs.getInt("user_report"));
				dto.setUser_reportCnt(rs.getInt("user_reportCnt"));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch (Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch (Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch (Exception e) {e.printStackTrace();}
		}
		
		return dto;
	}
	
	public int userMoneyCheck(int p_no, String UID, int money) {
		int result = -2;
		int priceMoney = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "select p_price from Product where p_no=? and p_buyerId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.setString(2, UID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				priceMoney = rs.getInt(1);
				if(priceMoney <= money) {
					sql = "update UserList set user_money=? where user_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, money-priceMoney);
					pstmt.setString(2, UID);
					result = pstmt.executeUpdate();
				}else {
					result = -1;
				}
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch (Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch (Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch (Exception e) {e.printStackTrace();}
		}
		
		
		return result;
	}
	
	public int productBuy(int p_no) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "select p_finish from Product where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sql = "update product set p_finish=1";
				result = pstmt.executeUpdate();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch (Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch (Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch (Exception e) {e.printStackTrace();}
		}
		
		return result;
	}
	
	public List<CategoryDTO>  getCategory() {
		List<CategoryDTO> list = null; 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
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
		}finally {
			if(rs != null)try {rs.close();}catch (Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch (Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch (Exception e) {e.printStackTrace();}
		}
		return list;
	}
	
	public int productSelling(ProductDTO dto) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "insert into Product(P_NO, P_STATUS, P_TITLE, P_PRICE, P_MAXPRICE, P_MINPRICE, CA_NO, P_IMG1, P_IMG2, P_IMG3, P_IMG4, P_CONTENT, P_SELLERID, P_BUYERID, P_START, P_END) ";
			sql += "values(Product_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, null, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getP_status());
			pstmt.setString(2, dto.getP_title());
			pstmt.setInt(3, dto.getP_price());
			pstmt.setInt(4, dto.getP_maxPrice());
			pstmt.setInt(5, dto.getP_minPrice());
			pstmt.setInt(6, dto.getCa_no());
			pstmt.setString(7, dto.getP_img1());
			pstmt.setString(8, dto.getP_img2());
			pstmt.setString(9, dto.getP_img3());
			pstmt.setString(10, dto.getP_img4());
			pstmt.setString(11, dto.getP_content());
			pstmt.setString(12, dto.getP_sellerId());
			pstmt.setTimestamp(13, dto.getP_start());
			pstmt.setTimestamp(14, dto.getP_end());
			
			result = pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch (Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch (Exception e) {e.printStackTrace();}
		}
		
		return result;
	}
	
	public ProductDTO getP_no(String P_img1) {
		ProductDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "select p_no from Product where p_img1=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, P_img1);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new ProductDTO();
				dto.setP_no(rs.getInt(1));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch (Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch (Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch (Exception e) {e.printStackTrace();}
		}
		
		return dto;
	}
}
