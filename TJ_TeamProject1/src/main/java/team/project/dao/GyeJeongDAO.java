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

import team.project.model.AddressDTO;
import team.project.model.ContentDTO;
import team.project.model.NoticeDTO;
import team.project.model.ProductDTO;
import team.project.model.ReportDTO;
import team.project.model.UserListDTO;
import team.project.model.UserQuestionDTO;

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
	public int updateCatGrp(String grp, String update) {
		try {
			result = 0;

			conn = getConnection();
			sql = "update category set ca_name = ? where ca_name=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, update);
			pstmt.setString(2, grp);

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("GyeJeongDAO.updateCatGrp(grp,update) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(pstmt, conn);
		}
		return result;
	}

	public int updateCatLevel(String grp, String level, String update) {
		// 소분류 수정할거라 대분류는 필요없을것 같음.. 메모.0718
		try {
			result = 0;

			conn = getConnection();
			sql = "update category set ca_name = ? where ca_name=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, update);
			pstmt.setString(2, level);

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.updateCatLevel(String grp, String level, String update) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(pstmt, conn);
		}

		return result;
	}

	public int insertCatGrp(String grpInsert, String levelInsert) {
		int maxGrpNo = 0;
		try {
			conn = getConnection();

			sql = "SELECT * from CATEGORY order by CA_GRP desc";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				maxGrpNo = rs.getInt(3) + 1; // 맥시멈 값에 +1 해서 저장. 새로 저장하기 위해 +1을 해줌

			// 먼저 대분류 값 넣어주기
			sql = "insert into category(ca_no, ca_name, ca_grp, ca_level) values(category_seq.nextval, ?, ?, 0)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, grpInsert);
			pstmt.setInt(2, maxGrpNo);

			int temp = pstmt.executeUpdate();
			System.out.println("insertCAT(grp, levelinsert).value temp " + temp);

			if (temp > 0) {
				sql = "insert into category(ca_no, ca_name, ca_grp, ca_level) values(category_seq.nextval, ?, ?, 1)";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, levelInsert);
				pstmt.setInt(2, maxGrpNo);

				result = pstmt.executeUpdate();
			}

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.insertCatGrp(String grpInsert, String leveInsert) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}
		return result;
	}

	public int insertCatLevel(String grp, String levelInsert) {
		int myGrp = 0;
		try {
			conn = getConnection();

			sql = "select * from category where ca_name=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, grp);

			rs = pstmt.executeQuery();

			if (rs.next())
				myGrp = rs.getInt(3);

			sql = "insert into category(ca_no, ca_name, ca_grp, ca_level) values(category_seq.nextval, ?, ?, 1)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, levelInsert);
			pstmt.setInt(2, myGrp);

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.insertCatGrp(String grpInsert, String leveInsert) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return result;
	}

	// new method here
	public int insertNotice(NoticeDTO dto) {
		try {
			conn = getConnection();
			sql = "insert into notice values(notice_seq.nextval, ?, ?, ?, ?, sysdate)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNo_title());
			pstmt.setString(2, dto.getNo_content());
			pstmt.setString(3, dto.getNo_cat());
			pstmt.setInt(4, dto.getNo_hidden());

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.insertNotice(NoticeDTO dto) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(pstmt, conn);
		}

		return result;
	}

	// new method here
	public int getQuestionCount() {
		result = 0;
		try {
			conn = getConnection();

			sql = "select count(*) from userquestion";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next())
				result = rs.getInt(1);

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getQuestionCount() ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return result;
	}

	// new method here
	public List<UserQuestionDTO> getUserQuestion(int startRow, int endRow) {
		List<UserQuestionDTO> list = null;
		UserQuestionDTO dto = null;

		try {
			conn = getConnection();

			sql = "select b.* from(\r\n" + "select ROWNUM r, a.* from\r\n"
					+ "(select * from USERQUESTION order by UQ_REG desc)a)b\r\n" + "where r>=? and r<=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<UserQuestionDTO>();
				do {
					dto = new UserQuestionDTO();

					dto.setUq_no(rs.getInt(2));
					dto.setP_no(rs.getInt(3));
					dto.setUser_id(rs.getString(4));
					dto.setUq_title(rs.getString(5));
					dto.setUq_content(rs.getString(6));
					dto.setUq_cat(rs.getString(7));
					dto.setUq_img1(rs.getString(8));
					dto.setUq_img2(rs.getString(9));
					dto.setUq_img3(rs.getString(10));
					dto.setUq_reg(rs.getTimestamp(11));
					dto.setUqa_content(rs.getString(12));
					dto.setUqa_reg(rs.getTimestamp(13));

					list.add(dto);

				} while (rs.next());
			}

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getUserQuestion(startRow, endRow) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
			;
		}
		return list;
	}

	// new method here
	public int getProductCount() {
		result = 0;
		try {
			conn = getConnection();

			sql = "select count(*) from product";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1);
			}

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getProductCount() ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return result;
	}

	// new method here
	public List<ProductDTO> getProductRecent(int startRow, int endRow) {
		List<ProductDTO> list = null;
		ProductDTO dto = null;
		try {
			conn = getConnection();

			sql = "select b.* from\r\n" + "(select ROWNUM r, a.* FROM(\r\n"
					+ "select * from PRODUCT ORDER BY p_reg desc)a)b\r\n" + "where r>=? and r<=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<ProductDTO>();
				do {
					dto = new ProductDTO();

					dto.setP_no(rs.getInt(2));
					dto.setP_status(rs.getInt(3));
					dto.setP_title(rs.getString(4));
					dto.setP_price(rs.getInt(5));
					dto.setP_maxPrice(rs.getInt(6));
					dto.setP_minPrice(rs.getInt(7));
					dto.setCa_no(rs.getInt(8));
					dto.setP_img1(rs.getString(9));
					dto.setP_img2(rs.getString(10));
					dto.setP_img3(rs.getString(11));
					dto.setP_img4(rs.getString(12));
					dto.setP_content(rs.getString(13));
					dto.setP_finish(rs.getInt(14));
					dto.setP_reg(rs.getTimestamp(15));
					dto.setP_readCount(rs.getInt(16));
					dto.setP_delete(rs.getInt(17));
					dto.setP_sellerId(rs.getString(18));
					dto.setP_buyerId(rs.getString(19));
					dto.setP_start(rs.getTimestamp(20));
					dto.setP_end(rs.getTimestamp(21));

					list.add(dto);
				} while (rs.next());
			}

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getProductRecent(startRow, endRow) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return list;
	}

	public List<ProductDTO> getProductView(int startRow, int endRow) {
		List<ProductDTO> list = null;
		ProductDTO dto = null;
		try {
			conn = getConnection();

			sql = "select b.* from\r\n" + "(select ROWNUM r, a.* from\r\n"
					+ "(select * from PRODUCT order by P_READCOUNT DESC)a)b\r\n" + "where r>=? and r<=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<ProductDTO>();
				do {
					dto = new ProductDTO();

					dto.setP_no(rs.getInt(2));
					dto.setP_status(rs.getInt(3));
					dto.setP_title(rs.getString(4));
					dto.setP_price(rs.getInt(5));
					dto.setP_maxPrice(rs.getInt(6));
					dto.setP_minPrice(rs.getInt(7));
					dto.setCa_no(rs.getInt(8));
					dto.setP_img1(rs.getString(9));
					dto.setP_img2(rs.getString(10));
					dto.setP_img3(rs.getString(11));
					dto.setP_img4(rs.getString(12));
					dto.setP_content(rs.getString(13));
					dto.setP_finish(rs.getInt(14));
					dto.setP_reg(rs.getTimestamp(15));
					dto.setP_readCount(rs.getInt(16));
					dto.setP_delete(rs.getInt(17));
					dto.setP_sellerId(rs.getString(18));
					dto.setP_buyerId(rs.getString(19));
					dto.setP_start(rs.getTimestamp(20));
					dto.setP_end(rs.getTimestamp(21));

					list.add(dto);
				} while (rs.next());
			}

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getProductView(startRow, endRow) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return list;
	}

	// TODO productList search 검색
	public int getProductSearchCount(String search) {
		result = 0;

		try {
			conn = getConnection();

			sql = "select count(*) from product where p_sellerid like '%" + search + "%'";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1);
			}

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getProductSearchCount(search) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return result;
	}

	public List<ProductDTO> getProductSearchRecent(int startRow, int endRow, String search) {
		List<ProductDTO> list = null;
		ProductDTO dto = null;

		try {
			conn = getConnection();

			sql = "select b.* from\r\n" + "(select ROWNUM r, a.* FROM(\r\n"
					+ "select * from PRODUCT where p_sellerid like '%" + search + "%' ORDER BY p_reg desc)a)b\r\n"
					+ "where r>=? and r<=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				list = new ArrayList<ProductDTO>();
				do {
					dto = new ProductDTO();

					dto.setP_no(rs.getInt(2));
					dto.setP_status(rs.getInt(3));
					dto.setP_title(rs.getString(4));
					dto.setP_price(rs.getInt(5));
					dto.setP_maxPrice(rs.getInt(6));
					dto.setP_minPrice(rs.getInt(7));
					dto.setCa_no(rs.getInt(8));
					dto.setP_img1(rs.getString(9));
					dto.setP_img2(rs.getString(10));
					dto.setP_img3(rs.getString(11));
					dto.setP_img4(rs.getString(12));
					dto.setP_content(rs.getString(13));
					dto.setP_finish(rs.getInt(14));
					dto.setP_reg(rs.getTimestamp(15));
					dto.setP_readCount(rs.getInt(16));
					dto.setP_delete(rs.getInt(17));
					dto.setP_sellerId(rs.getString(18));
					dto.setP_buyerId(rs.getString(19));
					dto.setP_start(rs.getTimestamp(20));
					dto.setP_end(rs.getTimestamp(21));

					list.add(dto);
				} while (rs.next());
			}

		} catch (Exception e) {

		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return list;
	}

	public List<ProductDTO> getProductSearchView(int startRow, int endRow, String search) {
		List<ProductDTO> list = null;
		ProductDTO dto = null;

		try {
			conn = getConnection();

			sql = "select b.* from\r\n" + "(select ROWNUM r, a.* from\r\n"
					+ "(select * from PRODUCT where p_sellerid like '%"+search+"%' order by P_READCOUNT DESC)a)b\r\n" + "where r>=? and r<=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				list = new ArrayList<ProductDTO>();
				do {
					dto = new ProductDTO();

					dto.setP_no(rs.getInt(2));
					dto.setP_status(rs.getInt(3));
					dto.setP_title(rs.getString(4));
					dto.setP_price(rs.getInt(5));
					dto.setP_maxPrice(rs.getInt(6));
					dto.setP_minPrice(rs.getInt(7));
					dto.setCa_no(rs.getInt(8));
					dto.setP_img1(rs.getString(9));
					dto.setP_img2(rs.getString(10));
					dto.setP_img3(rs.getString(11));
					dto.setP_img4(rs.getString(12));
					dto.setP_content(rs.getString(13));
					dto.setP_finish(rs.getInt(14));
					dto.setP_reg(rs.getTimestamp(15));
					dto.setP_readCount(rs.getInt(16));
					dto.setP_delete(rs.getInt(17));
					dto.setP_sellerId(rs.getString(18));
					dto.setP_buyerId(rs.getString(19));
					dto.setP_start(rs.getTimestamp(20));
					dto.setP_end(rs.getTimestamp(21));

					list.add(dto);
				} while (rs.next());
			}

		} catch (Exception e) {

		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return list;
	}

	// new method here
	public String getProductCatBig(int bigNo) {
		String catBig = "";
		try {
			conn = getConnection();

			sql = "select CA_NAME FROM category where ca_grp = (\r\n"
					+ "select CA_GRP from CATEGORY where CA_NO = ?)\r\n" + "and CA_LEVEL = 0";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, bigNo);

			rs = pstmt.executeQuery();

			if (rs.next())
				catBig = rs.getString(1);

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getProductCatBig(bigNo) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return catBig;
	}

	public String getProductCatSmall(int smallNo) {
		String catSmall = "";
		try {
			conn = getConnection();

			sql = "select CA_NAME FROM CATEGORY WHERE CA_NO = ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, smallNo);

			rs = pstmt.executeQuery();

			if (rs.next())
				catSmall = rs.getString(1);

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getProductCatSmall(smallNo) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return catSmall;
	}

	// new method here
	public UserListDTO getUserProfile(String user_id) {
		UserListDTO dto = null;
		try {
			conn = getConnection();

			sql = "select * from userlist where user_id=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new UserListDTO();

				dto.setUser_id(rs.getString(1));
				dto.setUser_pw(rs.getString(2));
				dto.setUser_email(rs.getString(3));
				dto.setUser_name(rs.getString(4));
				dto.setUser_phone(rs.getString(5));
				dto.setUser_money(rs.getInt(6));
				dto.setUser_usemoney(rs.getInt(7));
				dto.setUser_stars(rs.getDouble(8));
				dto.setUser_img(rs.getString(9));
				dto.setUser_reg(rs.getTimestamp(10));
				dto.setUser_delete(rs.getInt(11));
				dto.setUser_deleteReg(rs.getTimestamp(12));
				dto.setUser_activeReg(rs.getTimestamp(13));
				dto.setUser_report(rs.getInt(14));
				dto.setUser_reportCnt(rs.getInt(15));

			}

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getUserProfile(String user_id) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return dto;
	}

	public List<AddressDTO> getUserAddress(String user_id) {
		List<AddressDTO> list = null;
		AddressDTO dto = null;

		try {
			conn = getConnection();

			sql = "select * from ADDRESS where user_id = ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<AddressDTO>();
				do {
					dto = new AddressDTO();

					dto.setA_no(rs.getInt(1));
					dto.setA_address(rs.getString(2));
					dto.setA_address2(rs.getString(3));
					dto.setA_zipCode(rs.getInt(4));
					dto.setUser_id(rs.getString(5));
					dto.setA_name(rs.getString(6));
					dto.setA_tag(rs.getString(7));
					dto.setA_comment(rs.getString(8));
					dto.setA_usereg(rs.getTimestamp(9));

					list.add(dto);
				} while (rs.next());
			}

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getUserAddress(user_id) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return list;
	}

	// new method here
	public int setYellowCard(String id, int date) {
		result = 0;
		try {
			conn = getConnection();

			// date가 99이면 10년 추가
			if (date == 99) {
				sql = "Update USERLIST\r\n" + "  SET USER_ACTIVEREG=SYSDATE + (interval '99' YEAR), "
						+ " user_report=1 " + "WHERE user_id = ?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, id);

				result = pstmt.executeUpdate();
				System.out.println("DAO.Year SUCCESS");
			} else {
				// 그 외 date 일 추가
				sql = "Update USERLIST\r\n" + "  SET USER_ACTIVEREG=SYSDATE + (interval '" + date + "' DAY), "
						+ " user_report=1 " + "WHERE user_id = ?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, id);

				result = pstmt.executeUpdate();
				System.out.println("DAO.Day SUCCESS");
			}

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.setYellowCard(id, date) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(pstmt, conn);
		}

		return result;
	}

	// new method here
	public int resetYellowCard(String id) {
		result = 0;
		try {
			conn = getConnection();

			sql = "Update userlist\r\n" + "  SET USER_ACTIVEREG=NULL, user_report=0 " + "WHERE user_id = ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.resetYellowCard(String id) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(pstmt, conn);
		}

		return result;
	}

	public List<ProductDTO> getUserProductList(String user_id) {
		List<ProductDTO> list = null;
		ProductDTO dto = null;

		try {
			conn = getConnection();

			sql = "select b.* from\r\n" + "(select ROWNUM r, a.* from\r\n"
					+ "(select * from PRODUCT where P_SELLERID = ? order by P_REG desc)A)B";
			// sql문 수정... rownum 필요없음.. 그러면 아래 dto set 명령어도 수정해야함
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<ProductDTO>();
				do {
					dto = new ProductDTO();

					dto.setP_no(rs.getInt(2));
					dto.setP_status(rs.getInt(3));
					dto.setP_title(rs.getString(4));
					dto.setP_price(rs.getInt(5));
					dto.setP_maxPrice(rs.getInt(6));
					dto.setP_minPrice(rs.getInt(7));
					dto.setCa_no(rs.getInt(8));
					dto.setP_img1(rs.getString(9));
					dto.setP_img2(rs.getString(10));
					dto.setP_img3(rs.getString(11));
					dto.setP_img4(rs.getString(12));
					dto.setP_content(rs.getString(13));
					dto.setP_finish(rs.getInt(14));
					dto.setP_reg(rs.getTimestamp(15));
					dto.setP_readCount(rs.getInt(16));
					dto.setP_delete(rs.getInt(17));
					dto.setP_sellerId(rs.getString(18));
					dto.setP_buyerId(rs.getString(19));
					dto.setP_start(rs.getTimestamp(20));
					dto.setP_end(rs.getTimestamp(21));

					list.add(dto);
				} while (rs.next());
			}

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getUserProductList(user_id) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return list;
	}

	public List<ContentDTO> getUserContentList(String user_id) {
		List<ContentDTO> list = null;
		ContentDTO dto = null;

		try {
			conn = getConnection();

			sql = "SELECT * from CONTENT where USER_ID=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<ContentDTO>();
				do {
					dto = new ContentDTO();

					dto.setC_no(rs.getInt(1));
					dto.setC_title(rs.getString(2));
					dto.setUser_id(rs.getString(3));
					dto.setC_content(rs.getString(4));
					dto.setC_reg(rs.getTimestamp(5));
					dto.setC_readcount(rs.getInt(6));
					dto.setC_img(rs.getString(7));

					list.add(dto);
				} while (rs.next());
			}

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getUserContentList(user_id) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return list;
	}

	// new method here
	public int addMyMoney(String id, String aftermoney) {
		int money = Integer.parseInt(aftermoney);
		result = 0;

		try {
			conn = getConnection();

			sql = "Update userlist\r\n" + "  SET USER_MONEY=user_money+?,\r\n" + "  USER_USEMONEY=USER_USEMONEY+?\r\n"
					+ "WHERE user_id = ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, money);
			pstmt.setInt(2, money);
			pstmt.setString(3, id);

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.addMyMoney(id, aftermoney) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(pstmt, conn);
		}

		return result;
	}

	// new method here
	public int getReportCount() {
		result = 0;
		try {
			conn = getConnection();

			sql = "select count(*) from report";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next())
				result = rs.getInt(1);

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getReportCount() ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return result;
	}

	public List<ReportDTO> getReport(int startRow, int endRow) {
		List<ReportDTO> list = null;
		ReportDTO dto = null;
		result = 0;

		try {
			conn = getConnection();

			sql = "select * from\r\n" + "(select ROWNUM r, a.* from\r\n"
					+ "(select * from REPORT order BY RP_REG DESC)A)B\r\n" + "where r>=? and r<=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<ReportDTO>();

				do {
					dto = new ReportDTO();

					dto.setRp_no(rs.getInt(2));
					dto.setRp_reason(rs.getString(3));
					dto.setRp_title(rs.getString(4));
					dto.setRp_content(rs.getString(5));
					dto.setRp_reportUid(rs.getString(6));
					dto.setRp_reportedUid(rs.getString(7));
					dto.setRp_pro(rs.getInt(8));
					dto.setP_no(rs.getInt(9));
					dto.setRp_reg(rs.getTimestamp(10));

					list.add(dto);
				} while (rs.next());
			}

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getReport(startRow, endRow) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return list;
	}

	public int getSearchReportCount(String search, String searchOpt) {
		result = 0;
		try {
			conn = getConnection();

			sql = "select count(*) FROM REPORT where " + searchOpt + " LIKE '%" + search + "%' ";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next())
				result = rs.getInt(1);

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getSearchReportCount(String search, String searchOpt) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return result;
	}

	// TODO
	public List<ReportDTO> getSearchReport(int startRow, int endRow, String search, String searchOpt) {
		List<ReportDTO> list = null;
		ReportDTO dto = null;

		try {
			conn = getConnection();
			// "+searchOpt+"
			sql = "select B.* from (select rownum r, A.* from " + "(select * from report where " + searchOpt
					+ " like '%" + search + "%'" + " order by RP_REG desc) A) B " + "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<ReportDTO>();

				do {
					dto = new ReportDTO();

					dto.setRp_no(rs.getInt(2));
					dto.setRp_reason(rs.getString(3));
					dto.setRp_title(rs.getString(4));
					dto.setRp_content(rs.getString(5));
					dto.setRp_reportUid(rs.getString(6));
					dto.setRp_reportedUid(rs.getString(7));
					dto.setRp_pro(rs.getInt(8));
					dto.setP_no(rs.getInt(9));
					dto.setRp_reg(rs.getTimestamp(10));

					list.add(dto);

				} while (rs.next());
			}

		} catch (Exception e) {
			System.out.println("GyeJeongDAO.getSearchReport(startRow, endRow, search, searchOpt) ERR");
			e.printStackTrace();
		} finally {
			closeConnection(rs, pstmt, conn);
		}

		return list;
	}
	// new method here
	public UserQuestionDTO getOneUserQuestion(int uq_no) {
		UserQuestionDTO dto = null;
		
		try {
			conn=getConnection();
			
			sql="select * from USERQUESTION where UQ_NO = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, uq_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new UserQuestionDTO();
				
				dto.setUq_no(rs.getInt(1));
				dto.setP_no(rs.getInt(2));
				dto.setUser_id(rs.getString(3));
				dto.setUq_title(rs.getString(4));
				dto.setUq_content(rs.getString(5));
				dto.setUq_cat(rs.getString(6));
				dto.setUq_img1(rs.getString(7));
				dto.setUq_img2(rs.getString(8));
				dto.setUq_img3(rs.getString(9));
				dto.setUq_reg(rs.getTimestamp(10));
				dto.setUqa_content(rs.getString(11));
				dto.setUqa_reg(rs.getTimestamp(12));
			}

			
		}catch(Exception e) {
			
		}finally {
			closeConnection(rs, pstmt, conn);
		}
		
		return dto;
	}
}