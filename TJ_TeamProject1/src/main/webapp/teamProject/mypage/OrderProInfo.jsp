<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.model.OrderListDTO"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OrderProInfo.jsp</title>
</head>
<%
request.setCharacterEncoding("UTF-8");
String ono = request.getParameter("ono");
InstanceDAO dao = new InstanceDAO();
OrderListDTO order = dao.getOrder(ono);
ProductDTO product = dao.getProduct(order.getP_no());
%>
<body>
<h2>주문 상세</h2>

</body>
</html>