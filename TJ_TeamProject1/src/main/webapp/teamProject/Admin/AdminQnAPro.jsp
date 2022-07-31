<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="AdminSessionCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminQnAPro</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");

	int q_no = Integer.parseInt(request.getParameter("q_no"));
	String q_title = request.getParameter("q_title");
	String q_questionContent = request.getParameter("q_questionContent");
	String q_answerContent = request.getParameter("q_answerContent");
	
	
	GyeJeongDAO dao = new GyeJeongDAO();
	int result = -1;
	
	result = dao.updateQnA(q_title, q_questionContent, q_answerContent, q_no);
	
	response.sendRedirect("AdminQnAList.jsp");

	%>
	<%-- 
	<h4><%=q_no %></h4>
	<h4><%=q_title%></h4>
	<h4><%=q_questionContent%></h4>
	<h4><%=q_answerContent%></h4>
	--%>
</body>
</html>