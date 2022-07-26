<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.model.BiddingDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.BeomSuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String UID = (String)session.getAttribute("UID");
	if(UID != null){
	int p_no = Integer.parseInt(request.getParameter("p_no"));
	BeomSuDAO dao = new BeomSuDAO();
	List bidList = dao.biddingGet(p_no);
	
%>
<body>
<form action="">
	<table>
		<tr>
				<td>상품 제목</td>
				<td>입찰자 ID</td>
				<td>입찰 금액</td>
				<td>입찰 시간</td>
		</tr>
<%
	if(bidList != null && UID != null){
		for(int i = 0; i<bidList.size(); i++){
			BiddingDTO bidDTO = (BiddingDTO)bidList.get(i);
			ProductDTO proDTO = dao.productDetailBuy(bidDTO.getP_no());%>
			<tr>
				<td><%=proDTO.getP_title() %></td>
				<td><%=bidDTO.getUser_id() %></td>
				<td><%=bidDTO.getB_bidding() %></td>
				<td><%=bidDTO.getB_reg() %></td>
				<td><button onclick="window.open('Confirmation.jsp?b_no=<%=bidDTO.getB_no()%>&p_no=<%=p_no %>', '낙찰확인', 'width=500, height=500, location=no, left=20, top=40')">낙찰하기</button></td>
			</tr>
<%		}
	}
	}else{
%>
		<script>
		alert("잘못된 접근입니다!");
		window.location.assign("../Main.jsp");
		</script>
<%	} %>
	</table>
</form>
</body>
</html>