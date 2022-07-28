<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminHelpPro</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");

int uq_no = Integer.parseInt(request.getParameter("uq_no"));
String text = request.getParameter("uqa_content");

GyeJeongDAO dao = new GyeJeongDAO();
int result = dao.updateUserQuestion(uq_no, text); 

response.sendRedirect("AdminHelpList.jsp");
%>

<h4><%=uq_no %></h4>
<h4><%=text %></h4>

</body>
</html> 