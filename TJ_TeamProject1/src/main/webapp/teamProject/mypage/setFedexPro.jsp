<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.model.OrderListDTO"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<jsp:include page="../UIDcheck.jsp"/>

</head>
<%
request.setCharacterEncoding("UTF-8");
String fedexName = request.getParameter("o_fedexName");
String trackingNo = request.getParameter("o_trackingNo");
String ono = request.getParameter("o_no");
InstanceDAO dao = new InstanceDAO();
int result = dao.setFedex(fedexName, trackingNo , ono);


%>
<body>
<%
	if(result == 1){ 
		int processUpdateSuccess = dao.updateO_pro(Integer.parseInt(ono), 1);
		if(processUpdateSuccess != 1){
			System.out.println("setFedexPro.jsp updateO_pro = fail");
		}
		String productTitle = dao.getProduct(dao.getOrder(ono).getP_no()).getP_title();
		String message = productTitle+"의 상품 배송이 시작되었습니다.";
		dao.insertNotification(dao.getOrder(ono).getO_buyerId(), "2", message);
		%>
		
		<script type="text/javascript">
			alert("배송시작");
			opener.location.reload();
			window.close();
		</script>
<%	}
%>
</body>
</html>