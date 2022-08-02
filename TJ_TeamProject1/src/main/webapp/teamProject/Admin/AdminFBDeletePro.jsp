<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminFBDeletePro</title>
</head>
<body>

<jsp:include page='AdminSessionCheck.jsp' />

	<h4>DeletePro</h4>
	<%
	request.setCharacterEncoding("UTF-8");

	String cno = request.getParameter("cno");
	GyeJeongDAO dao = new GyeJeongDAO();

	int result = dao.deleteFB(Integer.parseInt(cno));

	response.sendRedirect("AdminFBList.jsp");
	%>
	<h4>
		cno =
		<%=cno%></h4>
	<h4>
		result =
		<%=result%></h4>

</body>
</html>