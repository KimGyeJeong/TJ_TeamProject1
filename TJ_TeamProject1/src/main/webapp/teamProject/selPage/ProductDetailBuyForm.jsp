<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/TJ_TeamProject1/teamProject/style.css" rel="stylesheet" type="text/css" />
</head>
<%
	request.setCharacterEncoding("utf-8");
	int p_no = Integer.parseInt((String)session.getAttribute("p_no"));
%>
<body>
<br />
	<h1 align="center"> 글 내용 </h1>
	
	<br />
</body>
</html>