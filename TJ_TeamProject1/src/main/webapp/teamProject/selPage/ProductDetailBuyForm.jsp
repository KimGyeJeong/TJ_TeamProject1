<%@page import="team.project.model.UserListDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.model.ProductQuestionDTO"%>
<%@page import="team.project.model.BiddingDTO"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.dao.BeomSuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 판매 페이지</title>
<link href="/TJ_TeamProject1/teamProject/style.css" rel="stylesheet" type="text/css" />
</head>
<%
request.setCharacterEncoding("utf-8");
	String UID = (String)session.getAttribute("UID");
	
	String pageNum = (String)request.getParameter("pageNum");
	if(pageNum == null || pageNum == "" || pageNum == "null"){
		pageNum = "0";
	}
	
	String p = request.getParameter("p_no");
	if(p == null){
		p = "-1";
	}
	int p_no = Integer.parseInt(p);
	
	BeomSuDAO dao = new BeomSuDAO();
	ProductDTO dto = null;
	List list = null;
	dto = dao.productDetailBuy(p_no);
	dao.readCountUp(p_no);
	list = dao.ProductQuestionList(p_no);
	UserListDTO userDTO = dao.userCheck(UID);

%>
<body>
<br />
<%if(dto.getP_finish() == 0){ %>	
	<table>
		<tr>
			<td rowspan="5"><img src="/teamProject/save/<%=dto.getP_img1()%>" width="300"/></td>
			<td>상품 제목 : <%=dto.getP_title() %></td>
			<td>조회수 : <%=dto.getP_readCount() %></td>
			<td>작성 일자 : <%=dto.getP_reg() %></td>
		</tr>
		<tr>
			<td>판매자 : <%=dto.getP_sellerId() %></td>
			<td>별점 : <%=userDTO.getUser_stars() %>/5</td>
			<td><button onclick="window.open('ReportForm.jsp?p_no=<%=p_no%>&p_sellerId=<%=dto.getP_sellerId()%>', '상품 신고', 'width=500, height=500, location=no, left=100, top=200')">신고하기</button></td>
		</tr>
<% 			if(dto.getP_status() == 0){%>
		<tr>
			<td colspan="3" align="left">가격 : <%=dto.getP_price() %></td>
		</tr>
		<tr>
			<td><button onclick="window.open('Wish.jsp?p_no=<%=dto.getP_no()%>', '찜', 'width=500, height=500, location=no, left=100, top=200')">찜하기</button></td>
			<td><button onclick="window.location='ProductDetailBuyPro.jsp?p_no=<%=dto.getP_no()%>&p_status=<%=dto.getP_status()%>'">구매하기</button></td>
		</tr>	
<%			}else{%>
		<form action="ProductDetailBuyPro.jsp" method="post">
		<input type="hidden" name="p_status" value="<%=dto.getP_status()%>" />
		<input type="hidden" name="p_no" value="<%=dto.getP_no()%>" />
		<tr>
			<td align="left">희망 입찰가 : <input type="text" name="b_bidding" /></td>
			<td align="left">상한가 : <%=dto.getP_maxPrice() %></td>
			<td align="left">하한가 : <%=dto.getP_minPrice() %></td>
		</tr>
		<tr>
			<td><input type="button" onclick="window.open('Wish.jsp?p_no=<%=dto.getP_no()%>', '찜', 'width=500, height=500, location=no, left=100, top=200')" value="찜하기"/></td>
			<td><input type="button" onclick="window.location='ProductDetailBuyPro.jsp?p_no=<%=dto.getP_no()%>&p_status=0'" value="즉시구매(상한가구매)"/></td>
			<td><input type="submit" value="입찰하기" /></td>
		</tr>
		</form>
<%			} %>
		<tr>
			<td><button onclick="window.location='ProductDetailBuyForm.jsp?pageNum=0&p_no=<%=p_no%>'">상품 정보</button></td>
			<td><button onclick="window.location='ProductDetailBuyForm.jsp?pageNum=1&p_no=<%=p_no%>'">상품 문의</button></td>
		</tr>
<%		if(pageNum.equals("0")){%>
		<tr>
			<td colspan="3">
				<img src="/teamProject/save/<%=dto.getP_img2() %>" />
				<img src="/teamProject/save/<%=dto.getP_img3() %>" />
				<img src="/teamProject/save/<%=dto.getP_img4() %>" /><br/>
				<textarea rows="50" cols="200" readonly><%=dto.getP_content() %></textarea>
			</td>
		</tr>
<%		}else{ %>
		<tr>
			<td colspan="3">
<%			if(list != null){
				for(int i = 0; i<list.size(); i++){
					ProductQuestionDTO que_dto = (ProductQuestionDTO)list.get(i);
				%>
					<h6><%=que_dto.getPq_title() %></h6>
					<textarea rows="10" cols="100"><%=que_dto.getPq_content() %></textarea>
					<h6>작성자 : <%=que_dto.getUser_id() %> &nbsp; 작성 시간 : <%=que_dto.getPq_writeReg() %></h6>
<%						if(que_dto.getPq_answer() != null){%>
							&nbsp;&nbsp;<textarea rows="20" cols="200" readonly><%=que_dto.getPq_answer() %></textarea>
							<h6>답변 시간 : <%=que_dto.getPq_answerReg() %></h6>
<%						} %>
<%				}%>
<%			}else{%>
				<h3>작성된 문의글이 없습니다!</h3>
<%			} %>
			</td>
		</tr>
<%		} %>
		<tr>
			<td colspan="2"><button onclick="window.open('ProductQuestion.jsp?p_no=<%=p_no%>&p_sellerId=<%=dto.getP_sellerId()%>&p_title=<%=dto.getP_title() %>', '상품 문의', 'width=500, height=500, location=no, left=100, top=200')">상품 문의하기</button></td>
			<td colspan="2"><button onclick="window.location='ProductList.jsp?ca_no=<%=dto.getCa_no() %>'">뒤로 가기</button></td>
		</tr>
	</table>	
<%}else if(dto.getP_finish() == 1){ %>
	<table>
		<tr>
			<td rowspan="5"><img src="/teamProject/save/<%=dto.getP_img1()%>" width="300"/></td>
			<td>상품 제목 : <%=dto.getP_title() %>&nbsp;(판매완료)</td>
			<td>조회수 : <%=dto.getP_readCount() %></td>
			<td>작성 일자 : <%=dto.getP_reg() %></td>
		</tr>
		<tr>
			<td>판매자 : <%=dto.getP_sellerId() %></td>
			<td>별점 : <%=userDTO.getUser_stars() %>/5</td>
			<td><button onclick="window.open('ReportForm.jsp?p_no=<%=p_no%>&p_sellerId=<%=dto.getP_sellerId()%>', '상품 신고', 'width=500, height=500, location=no, left=100, top=200')">신고하기</button></td>
		</tr>
<% 			if(dto.getP_status() == 0){%>
		<tr>
			<td colspan="3" align="left">가격 : <%=dto.getP_price() %></td>
		</tr>
		<tr>
			<td>판매가 완료된 상품입니다!</td>
			<td>판매가 완료된 상품입니다!</td>
		</tr>	
<%			}else{%>
		<form action="ProductDetailBuyPro.jsp" method="post">
		<input type="hidden" name="p_status" value="<%=dto.getP_status()%>" />
		<input type="hidden" name="p_no" value="<%=dto.getP_no()%>" />
		<tr>
			<td align="left">판매가 완료된 상품입니다!</td>
			<td align="left">상한가 : <%=dto.getP_maxPrice() %></td>
			<td align="left">하한가 : <%=dto.getP_minPrice() %></td>
		</tr>
		<tr>
			<td>판매가 완료된 상품입니다!</td>
			<td>판매가 완료된 상품입니다!</td>
			<td>판매가 완료된 상품입니다!</td>
		</tr>
		</form>
<%			} %>
		<tr>
			<td><button onclick="window.location='ProductDetailBuyForm.jsp?pageNum=0&p_no=<%=p_no%>'">상품 정보</button></td>
			<td><button onclick="window.location='ProductDetailBuyForm.jsp?pageNum=1&p_no=<%=p_no%>'">상품 문의</button></td>
		</tr>
<%		if(pageNum.equals("0")){%>
		<tr>
			<td colspan="3">
				<img src="/teamProject/save/<%=dto.getP_img2() %>" />
				<img src="/teamProject/save/<%=dto.getP_img3() %>" />
				<img src="/teamProject/save/<%=dto.getP_img4() %>" /><br/>
				<textarea rows="50" cols="200" readonly><%=dto.getP_content() %></textarea>
			</td>
		</tr>
<%		}else{ %>
		<tr>
			<td colspan="3">
<%			if(list != null){
				for(int i = 0; i<list.size(); i++){
					ProductQuestionDTO que_dto = (ProductQuestionDTO)list.get(i);
				%>
					<h6><%=que_dto.getPq_title() %></h6>
					<textarea rows="10" cols="100"><%=que_dto.getPq_content() %></textarea>
					<h6>작성자 : <%=que_dto.getUser_id() %> &nbsp; 작성 시간 : <%=que_dto.getPq_writeReg() %></h6>
<%						if(que_dto.getPq_answer() != null){%>
							&nbsp;&nbsp;<textarea rows="20" cols="200" readonly><%=que_dto.getPq_answer() %></textarea>
							<h6>답변 시간 : <%=que_dto.getPq_answerReg() %></h6>
<%						} %>
<%				}%>
<%			}else{%>
				<h3>작성된 문의글이 없습니다!</h3>
<%			} %>
			</td>
		</tr>
<%		} %>
		<tr>
			<td colspan="2">판매가 완료된 상품입니다!</td>
			<td colspan="2"><button onclick="window.location='ProductList.jsp?ca_no=<%=dto.getCa_no() %>'">뒤로 가기</button></td>
		</tr>
	</table>
<%}else{ %>
	<table>
		<tr>
			<td rowspan="5"><img src="/teamProject/save/<%=dto.getP_img1()%>" width="300"/></td>
			<td>상품 제목 : <%=dto.getP_title() %>&nbsp;(거래중지 상품)</td>
			<td>조회수 : <%=dto.getP_readCount() %></td>
			<td>작성 일자 : <%=dto.getP_reg() %></td>
		</tr>
		<tr>
			<td>판매자 : <%=dto.getP_sellerId() %></td>
			<td>별점 : <%=userDTO.getUser_stars() %>/5</td>
			<td><button onclick="window.open('ReportForm.jsp?p_no=<%=p_no%>&p_sellerId=<%=dto.getP_sellerId()%>', '상품 신고', 'width=500, height=500, location=no, left=100, top=200')">신고하기</button></td>
		</tr>
<% 			if(dto.getP_status() == 0){%>
		<tr>
			<td colspan="3" align="left">가격 : <%=dto.getP_price() %></td>
		</tr>
		<tr>
			<td>거래가 중지된 상품입니다!</td>
			<td>거래가 중지된 상품입니다!</td>
		</tr>	
<%			}else{%>
		<form action="ProductDetailBuyPro.jsp" method="post">
		<input type="hidden" name="p_status" value="<%=dto.getP_status()%>" />
		<input type="hidden" name="p_no" value="<%=dto.getP_no()%>" />
		<tr>
			<td align="left">거래가 중지된 상품입니다!</td>
			<td align="left">상한가 : <%=dto.getP_maxPrice() %></td>
			<td align="left">하한가 : <%=dto.getP_minPrice() %></td>
		</tr>
		<tr>
			<td>거래가 중지된 상품입니다!</td>
			<td>거래가 중지된 상품입니다!</td>
			<td>거래가 중지된 상품입니다!</td>
		</tr>
		</form>
<%			} %>
		<tr>
			<td><button onclick="window.location='ProductDetailBuyForm.jsp?pageNum=0&p_no=<%=p_no%>'">상품 정보</button></td>
			<td><button onclick="window.location='ProductDetailBuyForm.jsp?pageNum=1&p_no=<%=p_no%>'">상품 문의</button></td>
		</tr>
<%		if(pageNum.equals("0")){%>
		<tr>
			<td colspan="3">
				<img src="/teamProject/save/<%=dto.getP_img2() %>" />
				<img src="/teamProject/save/<%=dto.getP_img3() %>" />
				<img src="/teamProject/save/<%=dto.getP_img4() %>" /><br/>
				<textarea rows="50" cols="200" readonly><%=dto.getP_content() %></textarea>
			</td>
		</tr>
<%		}else{ %>
		<tr>
			<td colspan="3">
<%			if(list != null){
				for(int i = 0; i<list.size(); i++){
					ProductQuestionDTO que_dto = (ProductQuestionDTO)list.get(i);
				%>
					<h6><%=que_dto.getPq_title() %></h6>
					<textarea rows="10" cols="100"><%=que_dto.getPq_content() %></textarea>
					<h6>작성자 : <%=que_dto.getUser_id() %> &nbsp; 작성 시간 : <%=que_dto.getPq_writeReg() %></h6>
<%						if(que_dto.getPq_answer() != null){%>
							&nbsp;&nbsp;<textarea rows="20" cols="200" readonly><%=que_dto.getPq_answer() %></textarea>
							<h6>답변 시간 : <%=que_dto.getPq_answerReg() %></h6>
<%						} %>
<%				}%>
<%			}else{%>
				<h3>작성된 문의글이 없습니다!</h3>
<%			} %>
			</td>
		</tr>
<%		} %>
		<tr>
			<td colspan="2">거래가 중지된 상품입니다!</td>
			<td colspan="2"><button onclick="window.location='ProductList.jsp?ca_no=<%=dto.getCa_no() %>'">뒤로 가기</button></td>
		</tr>
	</table>
<%} %>	
<br />
</body>
</html>