<%@page import="team.project.model.BiddingDTO"%>
<%@page import="team.project.dao.BeomSuDAO"%>
<%@page import="team.project.model.ProductDTO"%>
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
	Integer b_no = Integer.parseInt(request.getParameter("b_no"));
	Integer p_no = Integer.parseInt(request.getParameter("p_no"));
%>
<body>
<%
	if(UID != null && b_no != null && p_no != null){
		BeomSuDAO dao = new BeomSuDAO();
		ProductDTO proDTO = dao.productDetailBuy(p_no);
		BiddingDTO bidDTO = dao.ConfirmationBidding(b_no);
%>
		<table>
			<tr>
				<td colspan="2">정말로 낙찰하시겠습니까?</td>
			</tr>
			<tr>
				<td>상품 제목</td>
				<td><%=proDTO.getP_title() %></td>
			</tr>
			<tr>
				<td>입찰자</td>
				<td><%=bidDTO.getUser_id() %></td>
			</tr>
			<tr>
				<td>입찰 금액</td>
				<td><%=bidDTO.getB_bidding() %></td>
			</tr>
			<tr>
				<td>입찰 시간</td>
				<td><%=bidDTO.getB_reg() %></td>
			</tr>
			<tr>
				<td><button onclick="opener.parent.location='ProductBiddingconfirmationPro.jsp?b_no=<%=b_no%>&p_no=<%=p_no %>', window.close()">낙찰 확정</button></td>
				<td><button onclick="opener.parent.location.reload(), window.close()">낙찰 취소</button></td>
			</tr>
		</table>
<%	}else{ %>
		<script type="text/javascript">
			alert("잘못된 접근입니다!");
			window.location.assign("../Main.jsp");
		</script>
<%	} %>
</body>
</html>