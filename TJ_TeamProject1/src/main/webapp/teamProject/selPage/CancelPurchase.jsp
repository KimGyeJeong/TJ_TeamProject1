<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.model.UserListDTO"%>
<%@page import="team.project.dao.BeomSuDAO"%>
<%@page import="team.project.model.OrderListDTO"%>
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
	BeomSuDAO dao = new BeomSuDAO();
	OrderListDTO orDTO = dao.orderListGet(o_no);
	if(UID.equals(orDTO.getO_buyerId())){
		if(orDTO.getO_pro() == 0){
			orDTO.setO_pro(7);
			ProductDTO proDTO = dao.productDetailBuy(orDTO.getP_no());
			if(proDTO.getP_status() == 0){
				int result = dao.cancelPurchase(proDTO.getP_price(), UID);
				dao.productCancelPurchase(proDTO.getP_no());
			
			
%>
<body>
<%			}else{%>
				<script type="text/javascript">
					alert("입찰한 상품은 취소할 수 없습니다!");
					window.location.assign("../Main.jsp");
				</script>
<% 			} %>

<%		}else{%>
			<script type="text/javascript">
				alert("배송이 시작된 상품은 취소할 수 없습니다!");
				window.location.assign("../Main.jsp");
			</script>	
<% 		}		
	}else{ %>
		<script type="text/javascript">
			alert("권한이 없습니다!");
			window.location.assign("../Main.jsp");
		</script>
<%	} %>
</body>
</html>