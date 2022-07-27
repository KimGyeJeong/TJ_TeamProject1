<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<jsp:include page="../UIDcheck.jsp"></jsp:include>
</head>
<body>
<%
response.setCharacterEncoding("UTF-8");

String id = request.getParameter("user_id"); 
String aftermoney = request.getParameter("aftermoney");

GyeJeongDAO dao = new GyeJeongDAO();
int result = dao.addMyMoney(id, aftermoney);
%>

<h4><%=id%></h4>
<h4><%=aftermoney%></h4>
<h4><%=result %></h4>

<%
response.sendRedirect("../Main.jsp");
%>



</body>
</html>