package team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team.project.model.AddressDTO;
import team.project.model.NotificationDTO;
import team.project.model.ProductDTO;
import team.project.model.UserListDTO;
import team.project.model.UserQuestionDTO;


 
public class LeeDAO {
	private void closeConnection(PreparedStatement pstmt, Connection conn) {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private void closeConnection(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext(); 
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	public int insertNewUser(UserListDTO member, AddressDTO member_add ) {
		int count =-1;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		try {
			conn = getConnection(); 	
			String sql= "insert into userlist(user_id, user_pw, user_email, user_name, user_phone, user_img, user_reg) values(?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getUser_id());
			pstmt.setString(2, member.getUser_pw());
			pstmt.setString(3, member.getUser_email());
			pstmt.setString(4, member.getUser_name());
			pstmt.setString(5, member.getUser_phone());
			pstmt.setString(6, member.getUser_img());
			
			int updateUser= pstmt.executeUpdate();
			System.out.println("insert updateUser:"+updateUser);
			count += updateUser;
			
			sql="insert into address(a_no,a_address,a_address2,a_zipcode,a_name,user_id,a_tag) values(ADDRESS_SEQ.nextval,?,?,?,?,?,?)";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, member_add.getA_address());
			pstmt.setString(2, member_add.getA_address2());
			pstmt.setInt(3, member_add.getA_zipCode());
			pstmt.setString(4, member.getUser_name());
			pstmt.setString(5, member.getUser_id());
			pstmt.setString(6, member_add.getA_tag());
			
			int updateUserAdd=pstmt.executeUpdate();
			System.out.println("insert updateUserAdd:"+updateUser);
			count += updateUserAdd;
			
		}catch(Exception e) {
			System.out.println("LEEDAO.insertNewUser ERR");
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			
		}
		
		
		System.out.println("1정상 0-1개만들어감 -1 둘다안들어감:"+count);
		
		return count;
	}
	
	public int idpwChkUser(String id, String pw) {
		//result =2 정지된 아이디 result =3 삭제된 아이디
		int result =-1;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql="select user_delete from userlist where user_id=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getInt(1)==1) {
					return result =3;
				}
			}
			
			sql ="select user_report from userlist where user_id=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getInt(1)==1) {
					return result =2;//정지된계정
				}
			}
			
			 sql = "select count(*) from userlist where user_id = ? and user_pw = ?";
			

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();

			if (rs.next())
				result = rs.getInt(1);
			else
				result = 0;
		} catch (Exception e) {
			System.out.println("LEEDAO.idpwChkUser(id, pw) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return result;
	}
	
	public Timestamp getReg(String id) {
		Timestamp date=null;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn=getConnection();
			String sql="select user_activereg from userlist where user_id=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				date=rs.getTimestamp(1);
			}
					
			
		}catch(Exception e) {
			System.out.println("LEE DAO getReg ERR");
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			
		}
		
		
		
		
		return date;
	}
	
	public int insertinquiry(UserQuestionDTO inquiry ) {
		int result =-1;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		try {
			conn=getConnection();
			String sql="insert into userquestion(uq_no, user_id, uq_title, uq_content, uq_cat,uq_img1,uq_img2,uq_img3,uq_reg) VALUES(userquestion_seq.nextval,?,?,?,?,?,?,?,sysdate)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, inquiry.getUser_id());
			pstmt.setString(2, inquiry.getUq_title());
			pstmt.setString(3, inquiry.getUq_content());
			pstmt.setString(4, inquiry.getUq_cat());
			pstmt.setString(5, inquiry.getUq_img1());
			pstmt.setString(6, inquiry.getUq_img2());
			pstmt.setString(7, inquiry.getUq_img3());
			
			int updateCount = pstmt.executeUpdate(); 
			System.out.println("insertinquiry :"+updateCount);
			
			
			
			
			
		}catch(Exception e) {
			System.out.println("LeeDAO.insertinquiry ERR");
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			
		}
		
		
		
		return result;
	}
	
	
	public int getInquiryListCount(String id) {
		int result=0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		

		try {
			conn = getConnection();
			String sql="select count(*) from userquestion where user_id=?";
	
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
			

		} catch (Exception e) {
			System.out.println("LEEDAO.getInquiryListCount ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}
		

		
		return result;
	}
	
	public List getInquiryList(int start, int end , String id) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql ="select * from(select ROWNUM r, A.* FROM (select * from userquestion  ORDER BY UQ_REG DESC) A) B where r>="+start+" and r<="+end+" and user_id=? " ;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					UserQuestionDTO dto = new UserQuestionDTO();
					dto.setP_no(rs.getInt("R"));
					dto.setUq_no(rs.getInt("UQ_NO"));
					if(rs.getString("P_NO")==null) {
						dto.setP_no(0000);
					}else {dto.setP_no(rs.getInt("P_NO"));}
					dto.setUser_id(rs.getString("USER_ID"));
					dto.setUq_title(rs.getString("UQ_TITLE"));
					dto.setUq_content(rs.getString("UQ_CONTENT"));
					dto.setUq_cat(rs.getString("UQ_CAT"));
					dto.setUq_img1(rs.getString("UQ_IMG1"));
					dto.setUq_img2(rs.getString("UQ_IMG2"));
					dto.setUq_img3(rs.getString("UQ_IMG3"));
					dto.setUq_reg(rs.getTimestamp("UQ_REG"));
					dto.setUqa_content(rs.getString("UQA_CONTENT"));
					dto.setUqa_reg(rs.getTimestamp("UQA_REG"));
					list.add(dto);
							
					
				}while(rs.next());
			}
		}catch(Exception e) {
			System.out.println("LEEDAO.getInquiryList ERR");
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		
		return list;
	}
	
	
	public UserQuestionDTO getContent(int uq_no) {
		UserQuestionDTO dto =null;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql ="select * from userquestion where uq_no ="+uq_no ;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				do {
					dto = new UserQuestionDTO();
					dto.setP_no(rs.getInt("P_NO"));
					dto.setUq_no(rs.getInt("UQ_NO"));
					dto.setUser_id(rs.getString("USER_ID"));
					dto.setUq_title(rs.getString("UQ_TITLE"));
					dto.setUq_content(rs.getString("UQ_CONTENT"));
					dto.setUq_cat(rs.getString("UQ_CAT"));
					dto.setUq_img1(rs.getString("UQ_IMG1"));
					dto.setUq_img2(rs.getString("UQ_IMG2"));
					dto.setUq_img3(rs.getString("UQ_IMG3"));
					dto.setUq_reg(rs.getTimestamp("UQ_REG"));
					dto.setUqa_content(rs.getString("UQA_CONTENT"));
					dto.setUqa_reg(rs.getTimestamp("UQA_REG"));
					
							
					
				}while(rs.next());
			}
		}catch(Exception e) {
			System.out.println("LEEDAO.getContent ERR");
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		
		
		
		return dto;
	}
	
	
	public int notificationListCount(String id) {
		int result=0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		

		try {
			conn = getConnection();
			String sql="select count(*) from notification where user_id=?";
	
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
			

		} catch (Exception e) {
			System.out.println("LEEDAO.notificationListCount ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}
		

		
		return result;
	}
	
	
	public List getNotificationList(int start, int end , String id) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql ="select * from(select ROWNUM r, A.* FROM (select * from notification  ORDER BY NOT_REG DESC) A) B where r>="+start+" and r<="+end+" and user_id=? " ;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					
							
					NotificationDTO ndto = new NotificationDTO();
					ndto.setNot_no(rs.getInt("NOT_NO"));
					ndto.setUser_id(rs.getString("USER_ID"));
					ndto.setNot_type(rs.getString("NOT_TYPE"));
					ndto.setNot_message(rs.getString("NOT_MESSAGE"));
					ndto.setNot_reg(rs.getTimestamp("NOT_REG"));
					ndto.setNot_readReg(rs.getTimestamp("NOT_READREG"));
					ndto.setNot_ch(rs.getInt("NOT_CH"));
					list.add(ndto);
					
					
				}while(rs.next());
			}
		}catch(Exception e) {
			System.out.println("LEEDAO.getNotificationList ERR");
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		
		return list;
	}
	
	public int notificationCheckChange(String value) {
		System.out.println("value:"+value);
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		int result=0;
		
		try {
			System.out.println("이걸내탓을2?");
			conn=getConnection();
			String sql="update notification set NOT_CH =1 WHERE NOT_NO="+value;
			pstmt =conn.prepareStatement(sql);
			result =pstmt.executeUpdate();
			System.out.println("notificationCheckChange"+result);
			
		
		
			
		}catch(Exception e) {
			System.out.println("Ledd.dao - notificationCheckChangeErr");
		}finally {
			
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		
		
		
		return result;
	}
	
	
	public int notificationListCount2(String id) {
		int result=0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		

		try {
			conn = getConnection();
			String sql="select count(*) from notification where user_id=? and NOT_TYPE=1";
	
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
			

		} catch (Exception e) {
			System.out.println("LEEDAO.notificationListCount2 ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}
		

		
		return result;
	}
	
	public int notificationListCount3(String id) {
		int result=0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		

		try {
			conn = getConnection();
			String sql="select count(*) from notification where user_id=? and NOT_TYPE=2";
	
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
			

		} catch (Exception e) {
			System.out.println("LEEDAO.notificationListCount2 ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}
		

		
		return result;
	}
	
	public int notificationListCount4(String id) {
		int result=0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		

		try {
			conn = getConnection();
			String sql="select count(*) from notification where user_id=? and NOT_TYPE=3";
	
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
			

		} catch (Exception e) {
			System.out.println("LEEDAO.notificationListCount2 ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}
		

		
		return result;
	}
	
	public List getNotificationList2(int start, int end , String id) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql ="select * from(select ROWNUM r, A.* FROM (select * from notification where not_type=1 ORDER BY NOT_REG DESC ) A) B where r>="+start+" and r<="+end+" and user_id=? " ;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					
							
					NotificationDTO ndto = new NotificationDTO();
					ndto.setNot_no(rs.getInt("NOT_NO"));
					ndto.setUser_id(rs.getString("USER_ID"));
					ndto.setNot_type(rs.getString("NOT_TYPE"));
					ndto.setNot_message(rs.getString("NOT_MESSAGE"));
					ndto.setNot_reg(rs.getTimestamp("NOT_REG"));
					ndto.setNot_readReg(rs.getTimestamp("NOT_READREG"));
					ndto.setNot_ch(rs.getInt("NOT_CH"));
					list.add(ndto);
					
					
				}while(rs.next());
			}
		}catch(Exception e) {
			System.out.println("LEEDAO.getNotificationList2 ERR");
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		
		return list;
	}
	
	public List getNotificationList3(int start, int end , String id) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql ="select * from(select ROWNUM r, A.* FROM (select * from notification where not_type=2 ORDER BY NOT_REG DESC ) A) B where r>="+start+" and r<="+end+" and user_id=? " ;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					
							
					NotificationDTO ndto = new NotificationDTO();
					ndto.setNot_no(rs.getInt("NOT_NO"));
					ndto.setUser_id(rs.getString("USER_ID"));
					ndto.setNot_type(rs.getString("NOT_TYPE"));
					ndto.setNot_message(rs.getString("NOT_MESSAGE"));
					ndto.setNot_reg(rs.getTimestamp("NOT_REG"));
					ndto.setNot_readReg(rs.getTimestamp("NOT_READREG"));
					ndto.setNot_ch(rs.getInt("NOT_CH"));
					list.add(ndto);
					
					
				}while(rs.next());
			}
		}catch(Exception e) {
			System.out.println("LEEDAO.getNotificationList3 ERR");
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		
		return list;
	}
	
	public List getNotificationList4(int start, int end , String id) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql ="select * from(select ROWNUM r, A.* FROM (select * from notification where not_type=3 ORDER BY NOT_REG DESC ) A) B where r>="+start+" and r<="+end+" and user_id=? " ;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					
							
					NotificationDTO ndto = new NotificationDTO();
					ndto.setNot_no(rs.getInt("NOT_NO"));
					ndto.setUser_id(rs.getString("USER_ID"));
					ndto.setNot_type(rs.getString("NOT_TYPE"));
					ndto.setNot_message(rs.getString("NOT_MESSAGE"));
					ndto.setNot_reg(rs.getTimestamp("NOT_REG"));
					ndto.setNot_readReg(rs.getTimestamp("NOT_READREG"));
					ndto.setNot_ch(rs.getInt("NOT_CH"));
					list.add(ndto);
					
					
				}while(rs.next());
			}
		}catch(Exception e) {
			System.out.println("LEEDAO.getNotificationList4 ERR");
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		
		return list;
	}
	
	
	public List recentProductList() {
		List list =null;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql ="select B.* FROM(Select ROWNUM R, A.* FROM(select * from TEAMID.product order by p_reg desc) A) B WHERE R>= 1 AND R<=8";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
	
					ProductDTO dto = new ProductDTO();
					dto.setP_title(rs.getString("P_TITLE"));
					dto.setP_img1(rs.getString("P_IMG1"));
					dto.setP_no(rs.getInt("P_NO"));
					list.add(dto);
					
					
					
				}while(rs.next());
			}
		}catch(Exception e) {
			System.out.println("LEEDAO.recentProductList ERR");
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		return list;
	}
	
	public List viewsProductList() {
		List list =null;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql ="select B.* FROM(Select ROWNUM R, A.* FROM(select * from TEAMID.product order by teamid.product.p_readcount desc) A) B WHERE R>= 1 AND R<=8";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
	
					ProductDTO dto = new ProductDTO();
					dto.setP_title(rs.getString("P_TITLE"));
					dto.setP_img1(rs.getString("P_IMG1"));
					dto.setP_no(rs.getInt("P_NO"));
					list.add(dto);
					
					
					
				}while(rs.next());
			}
		}catch(Exception e) {
			System.out.println("LEEDAO.recentProductList ERR");
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		return list;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
