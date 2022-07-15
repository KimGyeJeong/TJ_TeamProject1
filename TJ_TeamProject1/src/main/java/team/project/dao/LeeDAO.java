package team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team.project.model.AddressDTO;
import team.project.model.UserListDTO;


public class LeeDAO {
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
			String sql= "insert into userlist(user_id,user_pw,user_email,user_name,user_phone,user_img,user_reg) values(?,?,?,?,?,?,sysdate)";
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
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			
		}
		
		
		System.out.println("1정상 0-1개만들어감 -1 둘다안들어감:"+count);
		
		return count;
	}
	
}
