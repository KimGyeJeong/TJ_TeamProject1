<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminInsertCategoryPro</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");

	String grp = request.getParameter("grp");
	String level = request.getParameter("level");
	String type = request.getParameter("type");
	%>

	<%-- 테스트용 출력 --%>
	<h4>
		grp :
		<%=grp%></h4>
	<h4>
		level :
		<%=level%></h4>
	<h4>
		type :
		<%=type%></h4>
</body>
</html>