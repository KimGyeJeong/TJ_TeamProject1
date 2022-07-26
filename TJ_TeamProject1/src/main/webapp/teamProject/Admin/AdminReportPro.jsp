<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminReportPro</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");

	String rp_no = request.getParameter("rp_no");
	String rp_pro = request.getParameter("rp_pro");

	GyeJeongDAO dao = new GyeJeongDAO();
	int result = dao.updateReportPro(Integer.parseInt(rp_no), Integer.parseInt(rp_pro));
	
	response.sendRedirect("AdminReportList.jsp");
	%>
	<h4><%=rp_no%></h4>
	<h4><%=rp_pro%></h4>

</body>
</html>