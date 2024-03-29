package team.project.dao;

import java.sql.Timestamp;
import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import team.project.model.AddressDTO;
import team.project.model.BiddingDTO;
import team.project.model.CategoryDTO;
import team.project.model.OrderListDTO;
import team.project.model.ProductDTO;
import team.project.model.ReviewDTO;
import team.project.model.UserListDTO;
import team.project.model.WishListDTO;
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
			String sql = "select * from product where p_sellerid=? and p_delete=0 order by p_reg desc";
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
		
	
	
	
	
	//	orderlist o_pro=3 구매확정 하기
	public int updateOrderConfirmation(int Ono) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn= getConnection();
			String sql = "update orderlist set o_pro=3 where o_no=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, Ono);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(pstmt, conn);}
		return result;
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
	

	
	
	
	// ono 주고 상품정보 가져오기
		public OrderListDTO  getOrder(String o_no) {
			OrderListDTO dto = null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int ono = Integer.parseInt(o_no);
			try {
				conn = getConnection();
				String sql = "select * from orderlist where o_no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ono);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto = new OrderListDTO();
					dto.setO_no(rs.getInt("o_no"));
					dto.setP_no(rs.getInt("p_no"));
					dto.setP_status(rs.getInt("p_status"));
					dto.setA_no(rs.getInt("a_no"));
					dto.setO_buyerId(rs.getString("o_buyerId"));
					dto.setO_sellerId(rs.getString("o_sellerId"));
					dto.setO_pro(rs.getInt("o_pro"));
					dto.setO_reg(rs.getTimestamp("o_reg"));
					dto.setO_trackingNo(rs.getInt("o_trackingNo"));
					dto.setO_review(rs.getInt("o_review"));
				}
			}catch (Exception e) {
				e.printStackTrace();
			}finally {closeConnection(rs,pstmt, conn);}
			return dto;
		}
	
	
	
	
	
	public AddressDTO getaddress(int a_no) {
		AddressDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn =getConnection();
			String sql = "select * from address where a_no=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, a_no);
			rs = pstmt.executeQuery();
			if(rs.next()){
				dto = new AddressDTO();
				dto.setA_no(rs.getInt("a_no"));
				dto.setA_address(rs.getString("a_address"));
				dto.setA_address2(rs.getString("a_address2"));
				dto.setA_zipCode(rs.getInt("a_zipCode"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setA_name(rs.getString("a_name"));
				dto.setA_tag(rs.getString("a_tag"));
				dto.setA_comment(rs.getString("a_comment"));
				dto.setA_usereg(rs.getTimestamp("a_usereg"));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return dto;
	}
	
	
	
	
	//	uid 주고 a_no 배열 만들어서 a_no 주고 address리스트 갖고오기
	public List<AddressDTO> getaddressList(String uid) {
		List<AddressDTO> list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select a_no from address where user_id=? and a_delete=0 order by a_usereg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				List<Integer> a_no = new ArrayList<Integer>(); 
				do {
					a_no.add(rs.getInt(1));
				} while (rs.next());
				list = new ArrayList<AddressDTO>();
				for(int a: a_no) {
					AddressDTO dto = getaddress(a);
					list.add(dto);
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return list;
	}
	
	
	
	
	
	
	
	// a_no , comment값 주고 배송요청사항 수정 
	public int setAddressComment(int ano,String comment) {
		int result=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "update address set a_comment=? where a_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, comment);
			pstmt.setInt(2, ano);
			result = pstmt.executeUpdate();
			if(result==0) {
				System.out.println("setAddressComment() result==0");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return result;
	}
	
	// a_no[] , HashMap<Integer,String> a_comment 주고 모든 배송요청사항 수정
	public void setAddressAllComment(Integer [] ano,Map<Integer,String> a_comment) {
		for(int i=0 ; i<ano.length ; i++) {
			if(!a_comment.get(ano[i]).equals("")) {
				setAddressComment(ano[i],a_comment.get(ano[i]));
			}
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	//	ano ono 주고 ano 수정
	public int setAddressNum(String a_no,String o_no) {
		int ano=Integer.parseInt(a_no);
		int ono=Integer.parseInt(o_no);
		int result=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "update orderlist set a_no=? where o_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ano);
			pstmt.setInt(2, ono);
			result = pstmt.executeUpdate();
			sql = "update address set a_usereg=sysdate where a_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ano);
			result += pstmt.executeUpdate(); 
			if(result==0) {
				System.out.println("setAddressNum() result==0");
			}else if(result==1) {
				System.out.println("setAddressNum() result==1");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	//	addressDTO 주고 address레코드 insert
	public int insertAddress(AddressDTO dto) {
		int result=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "insert into address(a_no, a_tag, a_name, a_address, a_zipcode, a_address2 ,a_comment,user_id , a_usereg) "
					+ "values(address_seq.nextval,?,?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getA_tag());
			pstmt.setString(2, dto.getA_name());
			pstmt.setString(3, dto.getA_address());
			pstmt.setInt(4, dto.getA_zipCode());
			pstmt.setString(5, dto.getA_address2());
			pstmt.setString(6, dto.getA_comment());
			pstmt.setString(7, dto.getUser_id());
			result = pstmt.executeUpdate(); 
			if(result==0) {
				System.out.println("setAddress() result==0");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return result;
	}
	
	// addressDTO 주고 update address 레코드
	public int modifyAddress(AddressDTO dto) {
		int result=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "update address set a_tag=?, a_name=?, a_address=?, a_zipcode=?, a_address2=? ,a_comment=?,user_id=? where a_no=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getA_tag());
			pstmt.setString(2, dto.getA_name());
			pstmt.setString(3, dto.getA_address());
			pstmt.setInt(4, dto.getA_zipCode());
			pstmt.setString(5, dto.getA_address2());
			pstmt.setString(6, dto.getA_comment());
			pstmt.setString(7, dto.getUser_id());
			pstmt.setInt(8, dto.getA_no());
			result = pstmt.executeUpdate(); 
			if(result==0) {
				System.out.println("modifyAddress() result==0");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return result;
	}
	
	//	a_no 주고 deleteAddress 
	public int deleteAddress(String a_no) {
		int ano = Integer.parseInt(a_no);
		int result=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "update address set a_delete=1 where a_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ano);
			result = pstmt.executeUpdate(); 
			if(result==0) {
				System.out.println("deleteAddress() result==0");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return result;
	}
	
	// uid 주고 최신 주소 갖고오기 2
	
	
	
	
	
	
	
	
	
	
	
	
	
	//	p_no 주고 bidding dto갖고 오기
	public BiddingDTO getBidding(int pno) {
		System.out.println(pno+"=pno");
		BiddingDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from bidding where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pno);
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				dto = new BiddingDTO();
				dto.setB_no(rs.getInt("b_no"));
				dto.setP_no(rs.getInt("p_no"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setB_bidding(rs.getInt("b_bidding"));
				dto.setB_status(rs.getInt("b_status"));
				dto.setB_reg(rs. getTimestamp("b_reg"));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return dto;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//	produect p_delete = 1 로 수정(삭제됨으로 수정)
	public int deleteProduct(String p_no) {
		int pno= Integer.parseInt(p_no);
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn= getConnection();
			String sql = "update product set p_delete=1 where p_no=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, pno);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(pstmt, conn);}
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//	bidding 테이블에서 경매중인(b_bidding=1) 상품(p_no)의 참여자수 갖고오기
	public int getBiddingNum(int pno) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		try {
			conn= getConnection();
			String sql = "select * from bidding where p_no=? and b_bidding=1";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pno);
			rs = pstmt.executeQuery();
			if(!rs.next()) {
				sql = "select count(*) from bidding where p_no=?";
				pstmt= conn.prepareStatement(sql);
				pstmt.setInt(1, pno);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}else {
				count = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return count;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	//	uid 로 wish list 갖고오기
	public List<WishListDTO> getWishList(String uid) {
		List<WishListDTO> list = null;
		WishListDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn= getConnection();
			String sql = "select * from wishlist where user_id=? order by w_reg desc";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<WishListDTO>();
				do {
					dto = new WishListDTO();
					dto.setP_no(rs.getInt("p_no"));
					dto.setUser_id(rs.getString("user_id")); 
					dto.setW_reg(rs.getTimestamp("w_reg"));
					list.add(dto);
				}while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return list;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	//	delete wishlist 레코드 1개 삭제
	public int deleteWishList(int pno,String uid) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn= getConnection();
			String sql = "delete from wishlist where user_id=? and p_no=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.setInt(2, pno);
			result= pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(pstmt, conn);}
		return result;
	}
	
	public int checkWishList(int pno,String uid) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn= getConnection();
			String sql = "select count(*) from wishlist where user_id=? and p_no=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.setInt(2, pno);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(pstmt, conn);}
		return result;
	}
	
	
	
	
	
	
	
	
	
	//  이 유저가 평가한 리뷰 20개 갖고오기
	public List<ReviewDTO> getRecentReportReview(String uid) {
		List<ReviewDTO> list =null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn= getConnection();
			String sql = "select * from (select rownum r , A.* from (select * from review where re_reportUid=? and re_delete=0"
					+ " order by re_reg desc) A) B where r <=20";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<ReviewDTO>();
				do {
					ReviewDTO dto = new ReviewDTO();
					dto.setRe_no(rs.getInt("re_no"));
					dto.setRe_stars(rs.getInt("re_stars"));
					dto.setRe_content(rs.getString("re_content"));
					dto.setRe_reportUid(rs.getString("re_reportuid"));
					dto.setRe_reportedUid(rs.getString("re_reporteduid"));
					dto.setRe_delete(rs.getInt("re_delete"));
					dto.setRe_reg(rs.getTimestamp("re_reg"));
					dto.setP_no(rs.getInt("p_no"));
					list.add(dto);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return list;
	}
	
	
	
	
	//  이 유저가 평가 당한 리뷰 20개 갖고오기	
	public List<ReviewDTO> getRecentReportedReview(String uid) {
		List<ReviewDTO> list =null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReviewDTO dto= null;
		try {
			conn= getConnection();
			String sql = "select * from (select rownum r , A.* from (select * from review where re_reportedUid=? and re_delete=0"
					+ " order by re_reg desc) A) B where r <=20";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<ReviewDTO>();
				do {
					dto = new ReviewDTO();
					dto.setRe_no(rs.getInt("re_no"));
					dto.setRe_stars(rs.getInt("re_stars"));
					dto.setRe_content(rs.getString("re_content"));
					dto.setRe_reportUid(rs.getString("re_reportuid"));
					dto.setRe_reportedUid(rs.getString("re_reporteduid"));
					dto.setRe_delete(rs.getInt("re_delete"));
					dto.setRe_reg(rs.getTimestamp("re_reg"));
					dto.setP_no(rs.getInt("p_no"));
					list.add(dto);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return list;
	} 
	
	
	
	
	
	
	
	
	
	
	// 마이페이지 유저 테이블 수정하기
	public int updateUser(UserListDTO dto) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		int n = 4;
		try {
			conn = getConnection();
				sql = "update userlist set user_name=? , user_email=? , user_phone=?";
				if(!dto.getUser_pw().isEmpty()) {
					sql = sql+" , user_pw=?";
				}
				if(dto.getUser_img()!=null) {
					sql = sql+" , user_img=?";
				}
				sql = sql+" where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUser_name());
			pstmt.setString(2, dto.getUser_email());
			pstmt.setString(3, dto.getUser_phone());
			if(!dto.getUser_pw().isEmpty()) {
				pstmt.setString(n, dto.getUser_pw());
				n=n+1;
			}
			if(dto.getUser_img()!=null){
				pstmt.setString(n , dto.getUser_img());
				n=n+1;
			}
			pstmt.setString(n, dto.getUser_id());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("InstanceDAO.updateUser(UserListDTO dto) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	// 마이페이지 유저 테이블 삭제처리로 변경하기
		public int deleteUser(String uid) {
			int result = 0;
			Connection conn = null;
			PreparedStatement pstmt = null;
			try {
				conn = getConnection();
				String sql = "update userlist set user_delete=1 where user_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,uid);
				result = pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeConnection(pstmt, conn);
			}
			return result;
		}
	
	
	//	Reported 리뷰 갯수 갖오기
	public int getReportedReviewCount(String uid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count= 0;
		try {
			conn= getConnection();
			String sql = "select count(*) from review where re_reportedUid=? and re_delete=0";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return count;
	}
	//	Report 리뷰 갯수 갖오기
	public int getReportReviewCount(String uid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count= 0;
		try {
			conn= getConnection();
			String sql = "select count(*) from review where re_reportUid=? and re_delete=0";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return count;
	}
	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
	
	
	
	
	//  이 유저가 평가 당한 리뷰 페이지에 넣어줄만큼 갖고오기 역순으로	
	public List<ReviewDTO> getReportedReview(String uid, int StartPage , int EndPage) {
		List<ReviewDTO> list =null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReviewDTO dto= null;
		try {
			conn= getConnection();
			String sql = "select * from (select rownum r , A.* from (select * from review where re_reportedUid=? and re_delete=0"
					+ " order by re_reg desc) A) B where r >=? and r <=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.setInt(2, StartPage);
			pstmt.setInt(3, EndPage);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<ReviewDTO>();
				do {
					dto = new ReviewDTO();
					dto.setRe_no(rs.getInt("re_no"));
					dto.setRe_stars(rs.getInt("re_stars"));
					dto.setRe_content(rs.getString("re_content"));
					dto.setRe_reportUid(rs.getString("re_reportuid"));
					dto.setRe_reportedUid(rs.getString("re_reporteduid"));
					dto.setRe_delete(rs.getInt("re_delete"));
					dto.setRe_reg(rs.getTimestamp("re_reg"));
					dto.setP_no(rs.getInt("p_no"));
					list.add(dto);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return list;
	} 
	
	
	
	
	
	
	
	
	
	
		//	이 유저가 작성한 평가 페이지에 넣어줄만큼 갖고오기
		public List<ReviewDTO> getReportReview(String uid, int StartPage , int EndPage) {
			List<ReviewDTO> list =null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ReviewDTO dto= null;
			try {
				conn= getConnection();
				String sql = "select * from (select rownum r , A.* from (select * from review where re_reportUid=? and re_delete=0"
						+ " order by re_reg desc) A) B where r >=? and r <=?";
				pstmt= conn.prepareStatement(sql);
				pstmt.setString(1, uid);
				pstmt.setInt(2, StartPage);
				pstmt.setInt(3, EndPage);
				rs= pstmt.executeQuery();
				if(rs.next()) {
					list = new ArrayList<ReviewDTO>();
					do {
						dto = new ReviewDTO();
						dto.setRe_no(rs.getInt("re_no"));
						dto.setRe_stars(rs.getInt("re_stars"));
						dto.setRe_content(rs.getString("re_content"));
						dto.setRe_reportUid(rs.getString("re_reportuid"));
						dto.setRe_reportedUid(rs.getString("re_reporteduid"));
						dto.setRe_delete(rs.getInt("re_delete"));
						dto.setRe_reg(rs.getTimestamp("re_reg"));
						dto.setP_no(rs.getInt("p_no"));
						list.add(dto);
					} while (rs.next());
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {closeConnection(rs,pstmt, conn);}
			return list;
		} 
		
	
	
	
	
	
	
	
	
	
	public OrderListDTO getOrderList(int p_no , String sellerId , String buyerId) {
		OrderListDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from orderlist where p_no=? and o_sellerid=? and o_buyerid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.setString(2, sellerId);
			pstmt.setString(3, buyerId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new OrderListDTO();
				dto.setO_no(rs.getInt("o_no"));
				dto.setP_no(p_no);
				dto.setP_status(rs.getInt("p_status"));
				dto.setA_no(rs.getInt("a_no"));
				dto.setO_buyerId(buyerId);
				dto.setO_sellerId(sellerId);
				dto.setO_pro(rs.getInt("o_pro"));
				dto.setO_reg(rs.getTimestamp("o_reg"));
				dto.setO_fedexName(rs.getString("o_fedexName"));
				dto.setO_trackingNo(rs.getInt("o_trackingNo"));
				dto.setO_review(rs.getInt("o_review"));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return dto;
	}
	
	
	
	
	
	
	public int setFedex(String o_fedexName , String o_trackingNo , String o_no) {
		int trackingNo = Integer.parseInt(o_trackingNo);
		int ono = Integer.parseInt(o_no);
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "update orderlist set o_fedexName=? , o_trackingNo=? where o_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, o_fedexName); 
			pstmt.setInt(2,trackingNo);
			pstmt.setInt(3,ono);
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs,pstmt, conn);}
		return result;
	}
	
	
	
	
	
	//	o_pro = 받은 값으로 변경하기
	public int updateO_pro(int Ono , int o_pro) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn= getConnection();
			String sql = "update orderlist set o_pro=? where o_no=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, o_pro);
			pstmt.setInt(2, Ono);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(pstmt, conn);}
		return result;
	}
	
	
	
	
	
	
	
	//	review 작성 카운트
	public int writeReview(int p_no) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn= getConnection();
			String sql = "select count(*) from review where p_no=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs, pstmt, conn);}
		return count;
	}
	
	
	
	//	오버로딩 getProductList 
	public List<ProductDTO> getProductList(ArrayList<BiddingDTO> biddinglist) {
		List<ProductDTO> list = null; 
		if(biddinglist != null) {
			list = new ArrayList<ProductDTO>();
			for(int i=0; i<biddinglist.size() ; i++) {
				int pno=biddinglist.get(i).getP_no();
				list.add(getProduct(pno));
			}
		}
		return list;
	}
	
	// getbidding 조건 feat.uid 조건 : status = 0 , reg desc(역순)
	public List<BiddingDTO> getBiddigList(String uid) {
		List<BiddingDTO> list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn= getConnection();
			String sql = "select * from bidding where b_status=0 and user_id=? order by b_reg desc";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<BiddingDTO>();
				do {
					BiddingDTO dto = new BiddingDTO();
					dto.setB_no(rs.getInt(1));
					dto.setP_no(rs.getInt(2));
					dto.setB_bidding(rs.getInt(3));
					dto.setUser_id(rs.getString(4));
					dto.setB_reg(rs.getTimestamp(5));
					dto.setB_status(rs.getInt(6));
					list.add(dto);
				}while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs, pstmt, conn);}
		return list;
	}
	
	
	
	
	
	
	
	// notification(알림) 넣기
	public void insertNotification(String uid,String type, String message) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn= getConnection();
			String sql = "insert into notification (not_no ,user_id ,not_type ,not_message ,not_reg) ";
				sql += "values(notification_seq.nextval,?,?,?,sysdate)";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.setString(2, type);
			pstmt.setString(3, message);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(pstmt, conn);}
	}
	public int getReviewCheck(String uid, int pno) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			conn= getConnection();
			String sql = "select count(*) from review where re_reportUid=? and p_no=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.setInt(2, pno);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}else {
				System.out.println("getReviewCheck 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {closeConnection(rs, pstmt, conn);}
		return count;
	}
	
	
	
	
	
	
	
	
	
}

