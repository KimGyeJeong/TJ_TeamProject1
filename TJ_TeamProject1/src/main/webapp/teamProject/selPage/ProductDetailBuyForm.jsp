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
	String UID = (String)session.getAttribute("UID");
	
	String pageNum = (String)request.getAttribute("pageNum");
	if(pageNum == null || pageNum == "" || pageNum == "null"){
		pageNum = "0";
	}
	request.setCharacterEncoding("utf-8");
	int p_no = Integer.parseInt((String)session.getAttribute("p_no"));
	
	BeomSuDAO dao = new BeomSuDAO();
	ProductDTO dto = null;
	List list = null;
	dto = dao.productDetailBuy(p_no);
	ProductQuestionDTO que_dto = new ProductQuestionDTO();
	list = dao.ProductQuestionList(p_no);

%>
<body>
<br />
	<img src="/teamProject/save/<%=dto.getP_img1()%>" width="300"/>
	<table>
		<tr>
			<td><%=dto.getP_title() %></td>
			<td>조회수 : <%=dto.getP_readCount() %></td>
			<td>작성 일자 : <%=dto.getP_reg() %></td>
		</tr>
		<tr>
			<td><%=dto.getP_sellerId() %></td>
			<td>별점 : <%=dto.getP_start() %>/5</td>
			<td><button onclick="window.location='/teamProject/selPage/ReportForm.jsp?p_sellerId=<%=dto.getP_sellerId()%>'">신고하기</button></td>
		</tr>
<% 			if(dto.getP_status() == 0){%>
		<tr>
			<td colspan="3">가격 : <%=dto.getP_price() %></td>
		</tr>
		<tr>
			<td><button onclick="window.location='/teamProject/selPage/Wish.jsp?p_no=<%=dto.getP_no()%>'">찜하기</button></td>
			<td><button onclick="window.location='/teamProject/selPage/ProductDetailBuyPro.jsp?p_no=<%=dto.getP_no()%>'">구매하기</button></td>
		</tr>	
<%			}else{%>
		<form action="/teamProject/selPage/ProductDetailBuyPro.jsp" method="post">
		<tr>
			<td>희망 입찰가 : <input type="text" name="b_bidding" /></td>
			<td>상한가 : <%=dto.getP_maxPrice() %></td>
			<td>하한가 : <%=dto.getP_minPrice() %></td>
		</tr>
		<tr>
			<td><input type="button" onclick="window.location='/teamProject/selPage/Wish.jsp?p_no=<%=dto.getP_no()%>'" value="찜하기"/></td>
			<td><input type="button" onclick="window.location='/teamProject/selPage/ProductDetailBuyPro.jsp?p_no=<%=dto.getP_no()%>'" value="즉시구매(상한가구매)"/></td>
			<td><input type="submit" name="입찰하기" />
		</tr>
		</form>
<%			} %>
		<tr>
			<td><button onclick="window.location='ProductDetailBuyForm.jsp?pageNum=0'">상품 정보</button></td>
			<td><button onclick="window.location='ProductDetailBuyForm.jsp?pageNum=1'">상품 문의</button></td>
		</tr>
<%		if(pageNum.equals("0")){%>
		<tr>
			<td colspan="3">
				<img src="/teamProject/save/<%=dto.getP_img2() %>" />
				<img src="/teamProject/save/<%=dto.getP_img3() %>" />
				<img src="/teamProject/save/<%=dto.getP_img4() %>" /><br/>
				<textarea rows="50" cols="200"><%=dto.getP_content() %></textarea>
			</td>
		</tr>
<%		}else{ %>
		<tr>
			<td colspan="3">
		
			</td>
		</tr>
<%		} %>
		<tr>
			<td><button onclick="window.open("ProductQuestion.jsp", "상품 문의", "width=500, height=500, location=no" left=100, top=200)">상품 문의하기</button></td>
		</tr>
	</table>	
	
<br />
</body>
</html>