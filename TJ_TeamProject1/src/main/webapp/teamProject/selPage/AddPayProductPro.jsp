<%@page import="team.project.model.BiddingDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.model.OrderListDTO"%>
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
	int o_no = Integer.parseInt(request.getParameter("o_no"));
	int o_pro = 3;
	BeomSuDAO dao = new BeomSuDAO();
	OrderListDTO orderDTO = dao.orderListGet(o_no);
	int result = 0;
	if(orderDTO.getO_pro() == 0 || orderDTO.getO_pro() == 1 || orderDTO.getO_pro() == 2){
		result = dao.updateOrderConfirmation(o_no);
		
	}
	ProductDTO proDTO =  dao.productDetailBuy(orderDTO.getP_no());
	
	
%>
<body>
<%if(UID != null){
	if(result == 1 && orderDTO.getP_status() == 0){
		int result2 = dao.userMoneyUpdate(proDTO.getP_price(), proDTO.getP_sellerId());
		if(result2 == 1){%>
			<script type="text/javascript">
				alert("거래가 완료되었습니다!");
				window.location.assign("../mypage/OrderProcessList.jsp);
			</script>
<%		}else{%>
			<script type="text/javascript">
				alert("에러발생!");
				window.location.assign("../Main.jsp");
			</script>
<%		} %>
<% 	}else if(result == 1 && orderDTO.getP_status() == 1){
		BiddingDTO bidDTO = dao.biddingGet(orderDTO.getP_no(), UID);
		int result3 = dao.userMoneyUpdate(bidDTO.getB_bidding(), proDTO.getP_sellerId());
		if(result3 == 1){%>
		<script type="text/javascript">
			alert("거래가 완료되었습니다!");
			window.location.assign("../mypage/OrderProcessList.jsp);
		</script>
<%		}else{%>
		<script type="text/javascript">
			alert("에러발생!");
			window.location.assign("../Main.jsp");
		</script>
<%		}
	} 
}else{%>
	<script>
		alert("잘못된 접근입니다!");
		window.location.assign("../Login/Login.jsp");
	</script>
<%} %>
</body>
</html>