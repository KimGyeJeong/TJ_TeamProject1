<%@page import="java.sql.Timestamp"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.model.UserListDTO"%>
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
	int p_status = Integer.parseInt(request.getParameter("p_status"));
	int p_no = Integer.parseInt(request.getParameter("p_no"));
	String b_bid = request.getParameter("b_bidding");
	int a_no = Integer.parseInt(request.getParameter("ano"));
	if(b_bid == null){
		b_bid = "0";
	}
	UserListDTO userDTO = null;
	int b_bidding = Integer.parseInt(b_bid);
	BeomSuDAO dao = new BeomSuDAO();
	userDTO = dao.userCheck(UID);
	int result = 0;
	if(p_status == 0){
		result = dao.userMoneyCheck(p_no, UID, userDTO.getUser_money());
	}else{
		if((userDTO.getUser_money() - b_bidding) > 0){
			result = 1;
		}else{
			result = -1;
		}
	}
	int proResult = 0;
	
%>
<body>
<%
	if(result == 1){
		if(p_status == 1){
			dao.biddingInput(UID, b_bidding, p_no);%>
			<script>
				alert("입찰이 완료 되었습니다!");
				window.location.assign("ProductDetailBuyForm.jsp?p_no="+<%=p_no%>);
			</script>
<%		}else{
			ProductDTO proDTO = dao.productDetailBuy(p_no);
			dao.orderList(p_no, proDTO.getP_sellerId(), proDTO.getP_buyerId(), a_no, p_status);
			dao.productBuy(p_no);
%>
			<script>
				alert("구매가 완료 되었습니다!");
				window.location.assign("ProductDetailBuyForm.jsp?p_no="+<%=p_no%>);
			</script>
<%		}
	}else if(result == -1){%>
		<script>
			alert("현재 충전된 잔액이 부족합니다!");
			window.location.assign("ProductDetailBuyForm.jsp?p_no="+<%=p_no%>);
		</script>
<%	}else{%>
		<script>
			alert("에?러");
			window.location.assign("ProductDetailBuyForm.jsp?p_no="+<%=p_no%>);
		</script>
<%	}
	}else{%>
	<script>
		alert("로그인 후 이용해 주세요!");
		window.location.assign("../Login/Login.jsp");
	</script>
<%	}
%>
</body>
</html>