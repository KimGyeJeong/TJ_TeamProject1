<%@page import="team.project.model.OrderListDTO"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../UIDcheck.jsp" />
<%
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
String o_no = request.getParameter("o_no");
String o_pro = request.getParameter("o_pro");
int result = -100;
	if(o_no != null && o_pro != null){
		int ono = Integer.parseInt(o_no);
		int opro = Integer.parseInt(o_pro);
		InstanceDAO dao = new InstanceDAO();
		result = dao.updateO_pro(ono, opro);
		
		if(result == 1 && opro == 2){
			OrderListDTO order = dao.getOrder(o_no);
			String producttitle = dao.getProduct(order.getP_no()).getP_title();
			String message = producttitle+" 상품의 배송이 완료 되었습니다.";
			dao.insertNotification(order.getO_buyerId(), "2", message);
		}
		if(result == 1 && opro == 4){
			OrderListDTO order = dao.getOrder(o_no);
			String producttitle = dao.getProduct(order.getP_no()).getP_title();
			String message = producttitle+" 상품을 "+order.getO_buyerId()+" 님이반품 하셨습니다.";
			dao.insertNotification(order.getO_sellerId(), "1", message);
		}
		if(result == 1 && opro == 5){
			OrderListDTO order = dao.getOrder(o_no);
			String producttitle = dao.getProduct(order.getP_no()).getP_title();
			String message = producttitle+" 반품상품의 배송시작하였습니다.";
			dao.insertNotification(order.getO_sellerId(), "1", message);
		}
		if(result == 1 && opro == 6){
			OrderListDTO order = dao.getOrder(o_no);
			String producttitle = dao.getProduct(order.getP_no()).getP_title();
			String message = producttitle+" 반품상품의 배송완료하였습니다.";
			dao.insertNotification(order.getO_sellerId(), "1", message);
		}
	}else{ %>
	<script type="text/javascript">
		alert("잘못된 접근");
		history.go(-1);
	</script>
<% 	} %>
<% 
	if(result == 1){ %>
		<script type="text/javascript">
		location=document.referrer;
		</script>
<%	} %>
 	
</body>
</html>