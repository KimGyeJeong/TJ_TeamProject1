<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ResetYellowCardPro</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("user_id");

	GyeJeongDAO dao = new GyeJeongDAO();
	int result = dao.resetYellowCard(id);
	%>

	<h4><%=id%></h4>
	<h4><%=result%></h4>

	<script type="text/javascript">
		opener.parent.location.reload();
		window.close();
	</script>
</body>
</html>