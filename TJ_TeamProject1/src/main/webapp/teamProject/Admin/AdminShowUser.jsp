<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminShowUser</title>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");

	String pageNum = request.getParameter("pageNum");
	String search = request.getParameter("search");
	String user_id = request.getParameter("user_id");
	%>

	<h1>
		A.S.U TEST pageNum =
		<%=pageNum%>, search =
		<%=search%>, user_id =
		<%=user_id%></h1>


</body>
</html>