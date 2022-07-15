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

import team.project.model.UserListDTO;

public class GyeJeongDAO {
	int result = -1;
	String sql = "";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	private Connection getConnection() throws SQLException, NamingException {
		Context ctx = new InitialContext();
		Context env = (Context) ctx.lookup("java:comp/env");
		DataSource ds = (DataSource) env.lookup("jdbc/orcl");

		return ds.getConnection();
	}

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

	// new method here
	// admin 아이디 비번값 받아와서 DB 비교
	public int idpwChk(String id, String pw) {
		try {
			conn = getConnection();

			sql = "select count(*) from admin where ad_id = ? and ad_pw = ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();

			if (rs.next())
				result = rs.getInt(1);
			else
				result = 0;
		} catch (Exception e) {
			System.out.println("GyeJeongDAO.idpwChk(id, pw) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return result;
	}

	// new method here
	//
	public int getUserSearchCount(String search) {
		try {
			result = 0;
			conn = getConnection();

			sql = "select count(*) from userlist where user_id like '%" + search + "%'";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				result = rs.getInt(1);

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getUserSearchCount(search) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return result;
	}

	// new method here
	public int getUserCount() {
		try {
			result = 0;
			conn = getConnection();

			sql = "select count(*) from userlist";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				result = rs.getInt(1);

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getUserCount() ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}
		return result;
	}

	// new method here
	public List<UserListDTO> getUserSearch(int startRow, int endRow, String search, String orderBy) {
		List<UserListDTO> list = null;
		UserListDTO dto = null;
		try {
			conn = getConnection();

			sql = "select B.* FROM\r\n" + "(select ROWNUM r, A.* from\r\n"
					+ "(select * from USERLIST where user_id like '%" + search + "%' ORDER BY USER_REG " + orderBy
					+ ")A)B\r\n" + "where r>=? and r<=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<UserListDTO>();
				do {
					dto = new UserListDTO();

					dto.setUser_id(rs.getString(2));
					dto.setUser_pw(rs.getString(3));
					dto.setUser_email(rs.getString(4));
					dto.setUser_name(rs.getString(5));
					dto.setUser_phone(rs.getString(6));
					dto.setUser_money(rs.getInt(7));
					dto.setUser_usemoney(rs.getInt(8));
					dto.setUser_stars(rs.getDouble(9));
					dto.setUser_img(rs.getString(10));
					dto.setUser_reg(rs.getTimestamp(11));
					dto.setUser_delete(rs.getInt(12));
					dto.setUser_deleteReg(rs.getTimestamp(13));
					dto.setUser_activeReg(rs.getTimestamp(14));
					dto.setUser_report(rs.getInt(15));
					dto.setUser_reportCnt(rs.getInt(16));

					list.add(dto);

				} while (rs.next());
			}
		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getUserSearch(startRow, endRow, search) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return list;
	}

	// new method here
	// 유저 리스트 가져오기
	public List<UserListDTO> getUser(int startRow, int endRow, String orderBy) {
		List<UserListDTO> list = null;
		UserListDTO dto = null;

		try {
			conn = getConnection();

			sql = "SELECT b.* FROM\r\n" + "(SELECT ROWNUM r, A.* FROM\r\n"
					+ "(SELECT * FROM USERLIST ORDER BY USER_REG " + orderBy + ")A)B\r\n" + "WHERE r>=? and r<=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<UserListDTO>();
				do {

					dto = new UserListDTO();

					dto.setUser_id(rs.getString(2));
					dto.setUser_pw(rs.getString(3));
					dto.setUser_email(rs.getString(4));
					dto.setUser_name(rs.getString(5));
					dto.setUser_phone(rs.getString(6));
					dto.setUser_money(rs.getInt(7));
					dto.setUser_usemoney(rs.getInt(8));
					dto.setUser_stars(rs.getDouble(9));
					dto.setUser_img(rs.getString(10));
					dto.setUser_reg(rs.getTimestamp(11));
					dto.setUser_delete(rs.getInt(12));
					dto.setUser_deleteReg(rs.getTimestamp(13));
					dto.setUser_activeReg(rs.getTimestamp(14));
					dto.setUser_report(rs.getInt(15));
					dto.setUser_reportCnt(rs.getInt(16));

					list.add(dto);

				} while (rs.next());
			}

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getUser(startRow, endRow) ERR");
			e.printStackTrace();
		}

		return list;
	}
	// new method here

}