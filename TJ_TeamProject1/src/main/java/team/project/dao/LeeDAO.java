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
import javax.swing.text.AbstractDocument.Content;

import team.project.model.AddressDTO;
import team.project.model.ContentDTO;
import team.project.model.NoticeDTO;
import team.project.model.NotificationDTO;
import team.project.model.ProductDTO;
import team.project.model.QnADTO;
import team.project.model.ReplyDTO;
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
			String sql ="select * from(select ROWNUM r, A.* FROM (select * from userquestion where user_id=?  ORDER BY UQ_REG DESC) A) B where r>=? and r<=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
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
			String sql ="select * from(select ROWNUM r, A.* FROM (select * from notification where user_id=? ORDER BY NOT_REG DESC ) A) B where r>=? and r <=? " ;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
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
			String sql ="select B.* FROM(Select ROWNUM R, A.* FROM(select * from TEAMID.product where p_delete=0 and P_FINISH =0 order by p_reg desc) A) B WHERE R>= 1 AND R<=8";
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
			String sql ="select B.* FROM(Select ROWNUM R, A.* FROM(select * from TEAMID.product where p_delete=0  and P_FINISH =0 order by teamid.product.p_readcount desc) A) B WHERE R>= 1 AND R<=8";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
	
					ProductDTO dto = new ProductDTO();
					dto.setP_title(rs.getString("P_TITLE"));
					dto.setP_img1(rs.getString("P_IMG1"));
					dto.setP_no(rs.getInt("P_NO"));
					dto.setCa_no(rs.getInt("ca_no"));
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
	
	public int getProductListCount() {
		int result=0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		

		try {
			conn = getConnection();
			String sql="select count(*) from product";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
			

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}

		return result;
	}
	
	public List categorySelect(int start, int end) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql ="select * from(select ROWNUM r, A.* FROM (select * from product ORDER BY P_REG DESC) A) B where r>=? and r<=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
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
					dto.setP_img1(rs.getString("p_img1"));
					dto.setP_finish(rs.getInt("p_finish"));
					dto.setP_readCount(rs.getInt("p_readCount"));
					dto.setP_finish(rs.getInt("p_finish"));
					list.add(dto);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		
		return list;
	}
	
	public int getProductListSearchCount(String sel, String search) {
		int count =0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn=getConnection();
			String sql="select count(*) from product where "+sel+" like '%"+search+"%'";
			pstmt= conn.prepareStatement(sql);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			System.out.println("getProductListSearchCount:"+count);
		}catch(Exception e){
			System.out.println("LEEDAO. getProductListSearchCount ERR");
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		

		return count;
	}
	
	
	
	public List categorySearchSelect(int start, int end, String sel, String search) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql ="select * from(select ROWNUM r, A.* FROM (select * from product where "+sel+" like '%"+search+"%' ORDER BY P_REG DESC) A) B where r>=? and r<=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
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
					dto.setP_img1(rs.getString("p_img1"));
					dto.setP_finish(rs.getInt("p_finish"));
					dto.setP_readCount(rs.getInt("p_readCount"));
					dto.setP_finish(rs.getInt("p_finish"));
					list.add(dto);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		
		return list;
	}
	
	public int noticeCount() {
		int count =0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn= getConnection();
			String sql="select count(*) from notice";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt(1);
			}
			
		}catch(Exception e) {
			System.out.println("LEE DAO .noticeCount ERR");
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		return count;
	}
	public int noticeCount2() {
		int count =0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn= getConnection();
			String sql="select count(*) from notice";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt(1);
			}
			
		}catch(Exception e) {
			System.out.println("LEE DAO .noticeCount ERR");
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		return count;
	}
	
	
	public List noticeList(int start, int end) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql ="select * from(select ROWNUM r, A.* FROM (select * from notice  ORDER BY NO_REG DESC) A) B where r>=? and r<=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				list = new ArrayList();
				do {
					
					NoticeDTO ndto = new NoticeDTO();
					ndto.setNo_no(rs.getInt("NO_NO"));
					ndto.setNo_title(rs.getString("NO_TITLE"));
					ndto.setNo_content(rs.getString("NO_CONTENT"));
					ndto.setNo_cat(rs.getString("NO_CAT"));
					ndto.setNo_hidden(rs.getInt("NO_HIDDEN"));
					ndto.setNo_reg(rs.getTimestamp("NO_REG"));
					list.add(ndto);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		
		return list;
	}
	
	public List noticeList2(int start, int end) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql ="select * from(select ROWNUM r, A.* FROM (select * from notice  ORDER BY NO_REG DESC) A) B where r>=? and r<=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				list = new ArrayList();
				do {
					
					NoticeDTO ndto = new NoticeDTO();
					ndto.setNo_no(rs.getInt("NO_NO"));
					ndto.setNo_title(rs.getString("NO_TITLE"));
					ndto.setNo_content(rs.getString("NO_CONTENT"));
					ndto.setNo_cat(rs.getString("NO_CAT"));
					ndto.setNo_hidden(rs.getInt("NO_HIDDEN"));
					ndto.setNo_reg(rs.getTimestamp("NO_REG"));
					list.add(ndto);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		
		return list;
	}
	
	public int qnaCount() {
		int count =0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn= getConnection();
			String sql="select count(*) from qna";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt(1);
			}
			
		}catch(Exception e) {
			System.out.println("LEE DAO .qnaCount ERR");
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		return count;
	}
	
	public List qnaList(int start, int end) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql ="select * from(select ROWNUM r, A.* FROM (select * from qna  ORDER BY Q_REG DESC) A) B where r>=? and r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				list = new ArrayList();
				do {
					
					QnADTO dto = new QnADTO();
					dto.setQ_no(rs.getInt("Q_NO"));
					dto.setQ_title(rs.getString("Q_TITLE"));
					dto.setQ_questionContent(rs.getString("Q_QUESTIONCONTENT"));
					dto.setQ_answerContent(rs.getString("Q_ANSWERCONTENT"));
					dto.setQ_reg(rs.getTimestamp("Q_REG"));
					list.add(dto);
					
					
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		
		return list;
	}
	
	public int insertContent(ContentDTO article ) {
		int result =-1;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		try {
			conn=getConnection();
			String sql="insert into content values(CONTENT_SEQ.nextval,?,?,?,sysdate,0,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, article.getC_title() );
			pstmt.setString(2, article.getUser_id());
			pstmt.setString(3, article.getC_content());
			pstmt.setString(4, article.getC_img());
			
			
			
			int updateCount = pstmt.executeUpdate(); 
			System.out.println("insertContent :"+updateCount);
			
			
			
			
			
		}catch(Exception e) {
			System.out.println("LeeDAO.insertContent ERR");
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			
		}
		
		
		
		return result;
	}
	
	public int freeContentCount() {
		int count =0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn= getConnection();
			String sql="select count(*) from content";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt(1);
			}
			
		}catch(Exception e) {
			System.out.println("LEE DAO .freeContentCount ERR");
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		return count;
	}
	
	
	public List freeContentList(int start, int end) {
		List list = null;  
		Connection conn = null;  
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql ="select * from(select ROWNUM r, A.* FROM (select * from content  ORDER BY C_REG DESC) A) B where r>=? and r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				list = new ArrayList();
				do {
					
					
					ContentDTO cdto =new ContentDTO();
					cdto.setC_no(rs.getInt("C_NO"));
					cdto.setC_title(rs.getString("C_TITLE"));
					cdto.setUser_id(rs.getString("USER_ID"));
					cdto.setC_content(rs.getString("C_CONTENT"));
					cdto.setC_reg(rs.getTimestamp("C_REG"));
					cdto.setC_readcount(rs.getInt("C_READCOUNT"));
					cdto.setC_img(rs.getString("C_IMG"));
					list.add(cdto);
					
					
				}while(rs.next());
			}
		}catch(Exception e) {
			System.out.println("LeeDAO freeContentList ERR!");
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		
		return list;
	}
	
	
	public int getfreeContentListSearchCount(String sel, String search) {
		int count =0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn=getConnection();
			String sql="select count(*) from content where "+sel+" like '%"+search+"%'";
			pstmt= conn.prepareStatement(sql);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			System.out.println("getfreeContentListSearchCount:"+count);
		}catch(Exception e){
			System.out.println("LEEDAO. getfreeContentListSearchCount ERR");
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		

		return count;
	}

	public List getfreeContentListSearchList(int start, int end, String sel, String search) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql ="select * from(select ROWNUM r, A.* FROM (select * from content where "+sel+" like '%"+search+"%' ORDER BY C_REG DESC) A) B where r>=? and r<=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				list = new ArrayList();
				do {
					
					
					ContentDTO cdto =new ContentDTO();
					cdto.setC_no(rs.getInt("C_NO"));
					cdto.setC_title(rs.getString("C_TITLE"));
					cdto.setUser_id(rs.getString("USER_ID"));
					cdto.setC_content(rs.getString("C_CONTENT"));
					cdto.setC_reg(rs.getTimestamp("C_REG"));
					cdto.setC_readcount(rs.getInt("C_READCOUNT"));
					cdto.setC_img(rs.getString("C_IMG"));
					list.add(cdto);
					
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("getfreeContentListSearchList");
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		
		return list;
	}
	
	public void addReadcount(int cno) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		try {
			conn = getConnection(); 
			String sql = "update CONTENT set C_readcount=C_readcount+1 where c_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cno);
			
			int result = pstmt.executeUpdate(); 
			System.out.println("update count : " + result);
			
		}catch(Exception e) {
			
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
	}
	
	public ContentDTO getOneContent(int cno) {
		ContentDTO article = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select * from content where c_no =? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cno);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				article = new ContentDTO(); 
				article.setC_no(rs.getInt("C_NO"));
				article.setC_title(rs.getString("C_TITLE"));
				article.setUser_id(rs.getString("USER_ID"));
				article.setC_content(rs.getString("C_CONTENT"));
				article.setC_readcount(rs.getInt("C_READCOUNT"));
				article.setC_reg(rs.getTimestamp("C_REG"));
				article.setC_img(rs.getString("C_IMG"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return article;
	}
	public int deleteArticle(int cno) {
		int result = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "delete from content where c_no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cno);
				
				result = pstmt.executeUpdate(); 
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return result; 
	}
	
	public int updateArticle(ContentDTO article) {
		int result = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection();
		
			String	sql = "update Content set  c_content=?, c_img=? where c_no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, article.getC_content());
				pstmt.setString(2, article.getC_img());
				pstmt.setInt(3, article.getC_no());
				
				result = pstmt.executeUpdate(); 
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return result;
	}
	 
	
	public int getReplyCount(int cno) {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from reply where c_no =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cno);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				count = rs.getInt(1);  
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return count;
	}
	
	
	public List getReplies(int cno, int start, int end) {
		List replyList = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select A.*, rownum r from (select * from reply where c_no = ? order by R_GRP desc, R_STEP asc) A order by R_GRP desc, R_STEP asc) B where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cno);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				replyList = new ArrayList(); 
				do {
					ReplyDTO reply = new ReplyDTO(); 
					
					reply.setUser_id(rs.getString("user_id"));
					reply.setC_no(rs.getInt("c_no"));
					reply.setR_no(rs.getInt("r_no"));
					reply.setR_reply(rs.getString("r_reply"));
					reply.setR_reg(rs.getTimestamp("r_reg"));
					reply.setR_grp(rs.getInt("r_grp"));
					reply.setR_level(rs.getInt("r_level"));
					reply.setR_step(rs.getInt("r_step"));
					replyList.add(reply);
					
					
				}while(rs.next());
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return replyList;
	}
	
	
	public void insertReply(ReplyDTO dto) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		// 새댓글, 댓글의 댓글인지에 따라 조정이 필요한 값들 미리 뽑아 놓기 
		int rno = dto.getR_no(); 	// 새 댓글  = 0, 댓글의 댓글 = 1 이상
		int replyGrp = dto.getR_grp(); 		// 댓글 그룹, 새댓글이면 1
		int replyLevel = dto.getR_level(); 	// 정렬 순서, 새댓글이면 0			 
		int replyStep = dto.getR_step();		// 댓글의 레벨, 새댓글이면 0, 댓글의 댓글.
		int number = 0; 						// replyGrp 체워줄때 필요한 임시변수
		
		
		try {
			conn = getConnection(); 
			String sql = "select max(r_no) from reply";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(); 
			if(rs.next()) number = rs.getInt(1) + 1; //댓글이 있고, 가장 큰번호 
			else number = 1; // 댓글이 하나도 없을 경우 
			System.out.println("RNUMBER:"+rno);
			// 댓글의 댓글 
			if(rno != 0) {
				
				sql = "update reply set r_step=r_step+1 where r_grp=? and r_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, replyGrp);
				pstmt.setInt(2, replyStep);
				pstmt.executeUpdate();
				
				// insert 날리기위해 1씩 증가해주기
				replyStep += 1; 
				replyLevel += 1;
			}else { // 새댓글 
				System.out.println("number:"+number);
				replyGrp = number;
				System.out.println("replyGrp:"+replyGrp);
				replyStep = 0; 
				replyLevel = 0; 
			}

			sql = "insert into reply values(?,?,REPLY_SEQ.nextval,?,sysdate,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUser_id());
			pstmt.setInt(2, dto.getC_no());
			pstmt.setString(3, dto.getR_reply());
			pstmt.setInt(4,replyGrp );
			pstmt.setInt(5, replyLevel);
			pstmt.setInt(6, replyStep);
			
			int result = pstmt.executeUpdate(); 
			System.out.println("insert insertReply : " + result);
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("Leedao.insertReply ERR");
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
	}
	
	public void deleteReply(int rno) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		try {
			conn = getConnection(); 
			String sql = "delete from reply where r_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rno);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
	}

	
	public ReplyDTO getOneReply(int rno) {
		ReplyDTO reply = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select * from reply where r_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rno);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				reply = new ReplyDTO(); 
			
				
				reply.setUser_id(rs.getString("USER_ID"));
				reply.setC_no(rs.getInt("C_NO"));
				reply.setR_no(rs.getInt("R_NO"));
				reply.setR_reply(rs.getString("R_REPLY"));
				reply.setR_reg(rs.getTimestamp("R_REG"));
				reply.setR_grp(rs.getInt("R_GRP"));
				reply.setR_level(rs.getInt("R_LEVEL"));
				reply.setR_step(rs.getInt("R_STEP"));
				
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return reply;
	}
	
	public void updateReply(int rno, String reply) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		try {
			conn = getConnection(); 
			String sql = "update reply set r_reply=? where r_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reply);
			pstmt.setInt(2, rno);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
	}
	
	public boolean confimId(String id) {
		boolean result =false;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn=getConnection();
			String sql="select count(*) from userlist where user_id=?";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getInt(1)==1) {
					result=true;
				}
			}
			
		}catch(Exception e) {
			System.out.println("LEEDAO.confimId ERR");
			e.printStackTrace();
		}finally{
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
		
		return result;
		
	}
	
	
}
