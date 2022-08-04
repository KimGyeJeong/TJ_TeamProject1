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

import oracle.jdbc.proxy.annotation.Pre;
import team.project.model.AddressDTO;
import team.project.model.BiddingDTO;
import team.project.model.CategoryDTO;
import team.project.model.OrderListDTO;
import team.project.model.ProductDTO;
import team.project.model.ProductQuestionDTO;
import team.project.model.ReviewDTO;
import team.project.model.UserListDTO;
import team.project.model.UserQuestionDTO;

public class BeomSuDAO {

	// 알림 넣어주기 위해 사용할 class
	GyeJeongDAO dao_gj = null;

	private Connection getConn() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context) ctx.lookup("java:comp/env");
		DataSource ds = (DataSource) env.lookup("jdbc/orcl");

		return ds.getConnection();
	}

	public List categorySelect(int start, int end, int ca_no) {
		List list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConn();
			String sql = "select * from(select ROWNUM r, A.* FROM (select * from product where ca_no=? and p_delete=0  ORDER BY P_REG DESC) A) B where r>=? and r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ca_no);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				list = new ArrayList();
				do {
					ProductDTO dto = new ProductDTO();
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
					dto.setP_tempReg(rs.getTimestamp("p_tempReg"));
					list.add(dto);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}

		return list;
	}

	public int getProductListCount(int ca_no) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConn();
			String sql = "select count(*) from product where ca_no=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ca_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}

		return result;
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
			if (rs.next()) {
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
				dto.setP_tempReg(rs.getTimestamp("p_tempReg"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
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
			if (rs.next()) {
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
					dto.setPq_secret(rs.getInt("pq_secret"));
					list.add(dto);
				} while (rs.next());
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return list;
	}

	public ProductQuestionDTO ProductQuestionList2(int pq_no) {
		ProductQuestionDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "select * from ProductQuestion where pq_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pq_no);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new ProductQuestionDTO();
				dto.setPq_no(rs.getInt("pq_no"));
				dto.setP_no(rs.getInt("p_no"));
				dto.setPq_title(rs.getString("pq_title"));
				dto.setPq_content(rs.getString("pq_content"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setPq_writeReg(rs.getTimestamp("pq_writeReg"));
				dto.setPq_answer(rs.getString("pq_answer"));
				dto.setPq_answerReg(rs.getTimestamp("pq_answerReg"));
				dto.setPq_delete(rs.getInt("pq_delete"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return dto;
	}

	public int ProductQuestionAdd(int p_no, String UID, String pq_title, String pq_content, int pq_secret) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "insert into ProductQuestion(pq_no, p_no, pq_title, pq_content, user_id, pq_writeReg, pq_answer, pq_answerReg, pq_delete, pq_secret) ";
			sql += "values(ProductQuestion_seq.nextval,?,?,?,?,sysdate,null,null,0,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.setString(2, pq_title);
			pstmt.setString(3, pq_content);
			pstmt.setString(4, UID);
			pstmt.setInt(5, pq_secret);
			result = pstmt.executeUpdate();
			
			//0803 수정 시작. 수정자 김계정
			if(result>0) {
				dao_gj = new  GyeJeongDAO();
				InstanceDAO dao_in = new InstanceDAO();
				
				ProductDTO dto_product = dao_in.getProduct(p_no);
				
				String message = dto_product.getP_title() +"에 대한 질문이 달렸습니다.";
				
				dao_gj.insertNotification(dto_product.getP_sellerId(), "1", message);
			}
			//수정 완료.
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return result;
	}

	public int RportAdd(int p_no, String UID, String rp_title, String rp_content, String rp_reportedUid,
			String rp_reason) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "insert into Report(RP_NO, RP_REASON, RP_TITLE, RP_CONTENT, RP_REPORTUID, RP_REPORTEDUID, RP_PRO, P_NO, RP_REG) ";
			sql += "values(report_seq.nextval, ?, ?, ?, ?, ?, 0, ?, sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rp_reason);
			pstmt.setString(2, rp_title);
			pstmt.setString(3, rp_content);
			pstmt.setString(4, UID);
			pstmt.setString(5, rp_reportedUid);
			pstmt.setInt(6, p_no);

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return result;
	}

	public int WishAdd(int p_no, String UID) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "insert into WishList(user_id, p_no) values(?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, UID);
			pstmt.setInt(2, p_no);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
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
			pstmt.setString(1, UID);
			pstmt.setInt(2, p_no);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
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
			String sql = "select * from Address where user_id=? order by a_usereg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, UID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
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

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
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
			if (rs.next()) {
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

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return addDTO;
	}

	public int biddingInput(String UID, int b_bidding, int p_no) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();

			String sql = "update Bidding set b_bidding=? where user_id=? and p_no=? and b_bidding=0 and b_status=0";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_bidding);
			pstmt.setString(2, UID);
			pstmt.setInt(3, p_no);

			result = pstmt.executeUpdate();

			// 0803수정시작.. 수정자. 김계정
			// 명령문 추가
			if (result > 0) {
				String userid = "";
				String title = "";
				sql = "select * from PRODUCT where P_NO=?";

				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, p_no);

				rs = pstmt.executeQuery();
				if (rs.next()) {
					userid = rs.getString("P_SELLERID");
					title = rs.getString("P_TITLE");
				}

				dao_gj = new GyeJeongDAO();
				String message = UID + "님이 " + title + "에 입찰 신청을 하였습니다.";
				dao_gj.insertNotification(userid, "1", message);
			}
			// 0803 추가
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
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
			if (rs.next()) {
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

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
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
			if (rs.next()) {
				priceMoney = rs.getInt(1);
				if (priceMoney <= money) {
					sql = "update UserList set user_usemoney=? where user_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, money - priceMoney);
					pstmt.setString(2, UID);
					result = pstmt.executeUpdate();
				} else {
					result = -1;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return result;
	}

	public void productBuy(int p_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update Product set p_finish=1 , p_tempReg=sysdate where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
	}

	public void productBuy(int p_no, String UID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update Product set p_finish=1 , p_tempReg=sysdate , p_buyerId where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.setString(2, UID);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
	}

	public List<CategoryDTO> getCategory() {
		List<CategoryDTO> list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "select * from category order by ca_grp asc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				list = new ArrayList<CategoryDTO>();
				do {
					CategoryDTO dto = new CategoryDTO();
					dto.setCa_no(rs.getInt("ca_no"));
					dto.setCa_name(rs.getString("ca_name"));
					dto.setCa_level(rs.getInt("ca_level"));
					dto.setCa_grp(rs.getInt("ca_grp"));
					list.add(dto);
				} while (rs.next());
			} else {
				System.out.println("getCategory = 0");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
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

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
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
			String sql = "select * from Product where p_img1=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, P_img1);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new ProductDTO();
				dto.setP_no(rs.getInt("p_no"));
				dto.setCa_no(rs.getInt("ca_no"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return dto;
	}

	public void readCountUp(int p_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update Product set p_readCount=p_readCount+1 where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
	}

	public int productBiddingSet(int p_no, String UID) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "insert into Bidding(B_NO, P_NO, B_BIDDING, USER_ID, B_REG) ";
			sql += "values(Bidding_seq.nextval, ?, 0, ?, sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.setString(2, UID);
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return result;
	}

	public void orderList(int p_no, String p_sellerId, String p_buyerId, int a_no, int p_status) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "insert into OrderList(O_NO, P_NO, P_STATUS, A_NO, O_SELLERID, O_BUYERID, O_PRO, O_TRACKINGNO) ";
			sql += "values(OrderList_seq.nextval, ?, ?, ?, ?, ?, 0, null)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.setInt(2, p_status);
			pstmt.setInt(3, a_no);
			pstmt.setString(4, p_sellerId);
			pstmt.setString(5, p_buyerId);
			pstmt.executeUpdate();

			// 0803 수정 시작. 수정자 김계정
			dao_gj = new GyeJeongDAO();
			InstanceDAO dao_in = new InstanceDAO();
			ProductDTO dto = dao_in.getProduct(p_no);

			String message = p_buyerId + "님이 " + dto.getP_title() + "을(를) 구매하셨습니다.";
			dao_gj.insertNotification(p_sellerId, "1", message);
			// 수정 완료.

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

	}

	public void orderList(int p_no, String p_sellerId, String p_buyerId, int a_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "insert into OrderList(O_NO, P_NO, P_STATUS, A_NO, O_SELLERID, O_BUYERID, O_PRO, O_TRACKINGNO) ";
			sql += "values(OrderList_seq.nextval, ?, 1, ?, ?, ?, 0, null)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.setInt(2, a_no);
			pstmt.setString(3, p_sellerId);
			pstmt.setString(4, p_buyerId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
	}

	public ProductDTO ProductDateCheck(int p_no) {
		int result = -1;
		ProductDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "update Product set p_finish=3 where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			result = pstmt.executeUpdate();
			if (result == 1) {
				sql = "select * from Product where p_no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, p_no);
				rs = pstmt.executeQuery();
				if (rs.next()) {
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
					dto.setP_tempReg(rs.getTimestamp("p_tempReg"));
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return dto;
	}

	public ProductDTO ProductDateCheck2(int p_no) {
		int result = -1;
		ProductDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "update Product set p_finish=2 where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			result = pstmt.executeUpdate();
			if (result == 1) {
				sql = "select * from Product where p_no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, p_no);
				rs = pstmt.executeQuery();
				if (rs.next()) {
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
					dto.setP_tempReg(rs.getTimestamp("p_tempReg"));
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return dto;
	}

	public ProductDTO ProductDateCheck3(int p_no) {
		int result = -1;
		ProductDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "update Product set p_finish=0 where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			result = pstmt.executeUpdate();
			if (result == 1) {
				sql = "select * from Product where p_no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, p_no);
				rs = pstmt.executeQuery();
				if (rs.next()) {
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
					dto.setP_tempReg(rs.getTimestamp("p_tempReg"));
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return dto;
	}

	public int productModify(ProductDTO dto, int p_no) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update Product set p_status=? , p_title=? , p_price=? , p_maxPrice=? , p_minPrice=? , ca_no=? , p_img1=? , p_img2=? , p_img3=? , p_img4=? ";
			sql += ", p_content=? , p_sellerId=? , p_start=? , p_end=? where p_no=?";
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
			pstmt.setInt(15, p_no);

			result = pstmt.executeUpdate();
			System.out.println(result);
			System.out.println(result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return result;

	}

	public CategoryDTO getCategoryName(int ca_no) {
		CategoryDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "select * from category where ca_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ca_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new CategoryDTO();
				dto.setCa_no(ca_no);
				dto.setCa_name(rs.getString("ca_name"));
				dto.setCa_level(rs.getInt("ca_level"));
				dto.setCa_grp(rs.getInt("ca_grp"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return dto;
	}

	public int setAddressNum(String a_no) {
		int ano = Integer.parseInt(a_no);
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update address set a_usereg=sysdate where a_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ano);
			result = pstmt.executeUpdate();
			if (result == 0) {
				System.out.println("setAddressNum() result==0");
			} else if (result == 1) {
				System.out.println("setAddressNum() result==1");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return result;
	}

	public int updateOrderConfirmation(int Ono) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update orderlist set o_pro=3 where o_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Ono);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return result;
	}

	public OrderListDTO orderListGet(int o_no) {
		OrderListDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "select * from Orderlist where o_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, o_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new OrderListDTO();
				dto.setO_no(o_no);
				dto.setP_no(rs.getInt("p_no"));
				dto.setP_status(rs.getInt("p_status"));
				dto.setA_no(rs.getInt("a_no"));
				dto.setO_sellerId(rs.getString("o_sellerId"));
				dto.setO_buyerId(rs.getString("o_buyerId"));
				dto.setO_pro(rs.getInt("o_pro"));
				dto.setO_reg(rs.getTimestamp("o_reg"));
				dto.setO_review(rs.getInt("o_review"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return dto;
	}

	public int userMoneyUpdate(int p_price, String p_sellerId) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update UserList set user_usemoney=user_usemoney+? where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_price);
			pstmt.setString(2, p_sellerId);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return result;
	}

	public BiddingDTO biddingGet(int p_no, String UID) {
		BiddingDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "Select * from Bidding where p_no=? and user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.setString(2, UID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new BiddingDTO();
				dto.setB_no(rs.getInt("b_no"));
				dto.setP_no(rs.getInt("p_no"));
				dto.setB_bidding(rs.getInt("b_bidding"));
				dto.setUser_id(UID);
				dto.setB_reg(rs.getTimestamp("b_reg"));
				dto.setB_status(rs.getInt("b_status"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return dto;
	}

	public List biddingGet(int p_no) {
		List list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "Select * from Bidding where p_no=? order by b_bidding desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				list = new ArrayList();
				do {
					BiddingDTO dto = new BiddingDTO();
					dto.setB_no(rs.getInt("b_no"));
					dto.setP_no(rs.getInt("p_no"));
					dto.setB_bidding(rs.getInt("b_bidding"));
					dto.setUser_id(rs.getString("user_id"));
					dto.setB_reg(rs.getTimestamp("b_reg"));
					dto.setB_status(rs.getInt("b_status"));
					list.add(dto);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return list;
	}

	public BiddingDTO ConfirmationBidding(int b_no) {
		BiddingDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "Select * from Bidding where b_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new BiddingDTO();
				dto.setB_no(rs.getInt("b_no"));
				dto.setP_no(rs.getInt("p_no"));
				dto.setB_bidding(rs.getInt("b_bidding"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setB_reg(rs.getTimestamp("b_reg"));
				dto.setB_status(rs.getInt("b_status"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return dto;
	}

	public int confirmation(int b_no) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update bidding set b_status=1 where b_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_no);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return result;
	}

	public int biddingStatusSet(int p_no, int b_no) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update bidding set b_status=2 where p_no=? and b_no!=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.setInt(2, b_no);
			result = pstmt.executeUpdate();

			// 0803 수정 시작. 수정자 김계정
			if (result > 0) {
				dao_gj = new GyeJeongDAO();
				InstanceDAO dao_in = new InstanceDAO();
				ProductDTO dto_product = dao_in.getProduct(p_no);
				BiddingDTO dto_bid = null;
				List<BiddingDTO> list_bid = dao_gj.getBiddingList(p_no);
				if (list_bid != null) {
					for (int i = 0; i < list_bid.size(); i++) {
						dto_bid = list_bid.get(i);
						String message = dto_product.getP_title() + "의 입찰자로 선정되지 못하셨습니다.";

						dao_gj.insertNotification(dto_bid.getUser_id(), "2", message);
					}
				}
			}
			// 수정 완료.

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return result;
	}

	public int biddingStatusSet(int p_no) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update bidding set b_status=2 where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return result;
	}

	public List completionBidding(int p_no, int b_no) {
		List list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "Select * from Bidding where p_no=? and b_no!=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.setInt(2, b_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				list = new ArrayList();
				do {
					BiddingDTO dto = new BiddingDTO();
					dto.setB_no(rs.getInt("b_no"));
					dto.setP_no(rs.getInt("p_no"));
					dto.setB_bidding(rs.getInt("b_bidding"));
					dto.setUser_id(rs.getString("user_id"));
					dto.setB_reg(rs.getTimestamp("b_reg"));
					dto.setB_status(rs.getInt("b_status"));
					list.add(dto);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return list;
	}

	public List completionBidding(int p_no) {
		List list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "Select * from Bidding where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				list = new ArrayList();
				do {
					BiddingDTO dto = new BiddingDTO();
					dto.setB_no(rs.getInt("b_no"));
					dto.setP_no(rs.getInt("p_no"));
					dto.setB_bidding(rs.getInt("b_bidding"));
					dto.setUser_id(rs.getString("user_id"));
					dto.setB_reg(rs.getTimestamp("b_reg"));
					dto.setB_status(rs.getInt("b_status"));
					list.add(dto);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return list;
	}

	public void userMoneyReturn(String user_id, int bidding) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update UserList set user_usemoney=user_usemoney+? where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bidding);
			pstmt.setString(2, user_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

	}

	public int biddingModify(String UID, int b_bidding, int p_no) {
		int bid = 0;
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "select b_bidding from bidding where user_id=? and p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, UID);
			pstmt.setInt(2, p_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bid = rs.getInt("b_bidding");
				sql = "update bidding set b_bidding=? where user_id=? and p_no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, b_bidding);
				pstmt.setString(2, UID);
				pstmt.setInt(3, p_no);
				result = pstmt.executeUpdate();
				if (result == 1) {
					sql = "update UserList set user_usemoney=user_usemoney+? where user_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, bid - b_bidding);
					pstmt.setString(2, UID);
					result = pstmt.executeUpdate();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return result;
	}

	public int ProductAnswerAdd(int pq_no, String pq_answer) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update ProductQuestion set pq_answer=? , pq_answerReg=sysdate where pq_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pq_answer);
			pstmt.setInt(2, pq_no);
			result = pstmt.executeUpdate();

			// 0803 수정 시작. 수정자 김계정
			if (result > 0) {
				dao_gj = new GyeJeongDAO();
				ProductDTO dto_product = dao_gj.getproductDTOFrompq_no(pq_no);
				String message = dto_product.getP_sellerId() + " 님이 " + dto_product.getP_title()
						+ "의 상품문의에 대한 답변을 남겼습니다.";

				dao_gj.insertNotification(dto_product.getP_buyerId(), "2", message);
			}
			// 수정 완료.

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return result;
	}

	public int reviewAdd(ReviewDTO reDTO) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "insert into Review(RE_NO, RE_STARS, RE_REPORTUID, RE_CONTENT, RE_REPORTEDUID, p_no) ";
			sql += "values(Review_seq.nextval, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reDTO.getRe_stars());
			pstmt.setString(2, reDTO.getRe_reportUid());	//구매자
			pstmt.setString(3, reDTO.getRe_content());
			pstmt.setString(4, reDTO.getRe_reportedUid());	//판매자
			pstmt.setInt(5, reDTO.getP_no());
			result = pstmt.executeUpdate();

			//0803 수정 시작. 수정자 김계정
			if(result>0) {
				dao_gj = new GyeJeongDAO();
				InstanceDAO dao_in = new InstanceDAO();
				
				ProductDTO dto_product = dao_in.getProduct(reDTO.getP_no());
				
				String message=dto_product.getP_title()+"에 대한 거래후기가 생성되었습니다.";
				
				dao_gj.insertNotification(reDTO.getRe_reportedUid(), "1", message);
				System.out.println("리뷰작성 정상작동. BeomSuDAO is working. line2004");
			}
			//수정 완료.
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return result;
	}

	public int cancelPurchase(int p_price, String UID) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update UserList set user_usemoney=user_usemoney+? where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_price);
			pstmt.setString(2, UID);
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return result;
	}

	public void productCancelPurchase(int p_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update Product set p_finish=0 where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
	}

	public void endDateUpdate(int p_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update Product set p_tempReg=sysdate where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
	}

	public int productDelete(int p_no) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update Product set p_delete=1 where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return result;
	}

	public void userMoneydelete(String UID, int b_bidding) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update userlist set user_usemoney=user_usemoney-? where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_bidding);
			pstmt.setString(2, UID);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
	}

	public int biddingDelete(int b_no) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 0803수정시작.. 수정자. 김계정
			dao_gj = new GyeJeongDAO();
			ProductDTO dtoProduct = dao_gj.getproductDTOFromb_no(b_no);
			// 0803 수정 끝

			conn = getConn();
			String sql = "delete from bidding where b_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_no);
			result = pstmt.executeUpdate();

			// 0803수정시작.. 수정자. 김계정
			// 명령문 추가
			if (result > 0) {

				String message = dtoProduct.getP_buyerId() + "님이 구매 하였습니다.";
				dao_gj.insertNotification(dtoProduct.getP_sellerId(), "1", message);
			}
			// 0803 추가

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return result;
	}

	public void buyerSet(int p_no, String user_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update Product set p_buyerId=? where p_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setInt(2, p_no);
			int result = pstmt.executeUpdate();

			// 0803 수정 시작. 수정자 김계정
			if (result > 0) {
				dao_gj = new GyeJeongDAO();
				InstanceDAO dao_in = new InstanceDAO();
				ProductDTO dto_product = dao_in.getProduct(p_no);

				String message = dto_product.getP_title() + "의 입찰자로 선정되셨습니다.";

				dao_gj.insertNotification(dto_product.getP_buyerId(), "2", message);
			}
			// 수정 완료.

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

	}

	public List getReview(String p_sellerId) {
		List list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			String sql = "select * from review where RE_REPORTEDUID=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_sellerId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				list = new ArrayList();
				do {
					ReviewDTO dto = new ReviewDTO();
					dto.setRe_no(rs.getInt("re_no"));
					dto.setRe_stars(rs.getInt("re_stars"));
					dto.setRe_reportUid(rs.getString("re_reportUid"));
					dto.setRe_content(rs.getString("re_content"));
					dto.setRe_delete(rs.getInt("re_delete"));
					dto.setRe_reportedUid(rs.getString("re_reportedUid"));
					dto.setRe_reg(rs.getTimestamp("re_reg"));
					list.add(dto);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return list;
	}

	public void userStarsAdd(String p_sellerId, int stars) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "update UserList set user_stars=? where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, stars);
			pstmt.setString(2, p_sellerId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
	}

	public void deleteOrder(int o_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConn();
			String sql = "delete from orderList where o_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, o_no);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
	}
}
