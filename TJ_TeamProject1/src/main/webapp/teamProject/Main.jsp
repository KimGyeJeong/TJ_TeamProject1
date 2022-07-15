<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
</head>
<body>
<h1>메인</h1>
<%String id=(String)session.getAttribute("u_id"); 
System.out.println("id :"+id);
%>

<input type="button" value="logout" onclick="location.href='Login/Logout.jsp'"/>
</body>
</html>