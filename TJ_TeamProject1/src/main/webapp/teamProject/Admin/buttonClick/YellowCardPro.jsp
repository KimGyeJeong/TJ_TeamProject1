<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../AdminSessionCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YellowCardPro</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String reset_id = request.getParameter("user_id");
	int date = Integer.parseInt(request.getParameter("day"));

	GyeJeongDAO dao = new GyeJeongDAO();
	int result = dao.setYellowCard(reset_id, date);
	%>

	<h4><%=reset_id%></h4>
	<h4><%=date%></h4>
	<h4><%=result%></h4>

	<script type="text/javascript">
		opener.parent.location.reload();
		window.close();
	</script>

</body>
</html>