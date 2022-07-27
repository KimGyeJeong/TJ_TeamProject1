<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminQnADelete</title>
</head>
<body>
	<%
	//QnA(수정. q_no값이 0이 아닌 애들), QnAList에서 삭제버튼 눌러서 넘어온 값
	request.setCharacterEncoding("UTF-8");

	int q_no = Integer.parseInt(request.getParameter("q_no"));
	
	GyeJeongDAO dao = new GyeJeongDAO();
	
	int result = dao.deleteQnA(q_no);
	
	response.sendRedirect("AdminQnAList.jsp");
	%>
	<h4><%=q_no %></h4>
	<h4><%=result %></h4>

</body>
</html>