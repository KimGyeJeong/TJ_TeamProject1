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
	int p_status = Integer.parseInt(request.getParameter("p_status"));
	int p_no = Integer.parseInt(request.getParameter("p_no"));
	String b_bid = request.getParameter("b_bidding");
	if(b_bid == null){
		b_bid = "0";
	}
	UserListDTO userDTO = null;
	int b_bidding = Integer.parseInt(b_bid);
	BeomSuDAO dao = new BeomSuDAO();
	userDTO = dao.userCheck(UID);
	int result = dao.userMoneyCheck(p_no, UID, userDTO.getUser_money());
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
			proResult = dao.productBuy(p_no);
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
%>
</body>
</html>