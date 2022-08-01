<%@page import="team.project.dao.LeeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>reply delete</title>
</head>
<%
	int rno = Integer.parseInt(request.getParameter("rno"));
	int cno = Integer.parseInt(request.getParameter("cno"));
	String pageNum = request.getParameter("pageNum");
	
	LeeDAO dao = new LeeDAO(); 
	dao.deleteReply(rno); 
	
	response.sendRedirect("FBcontent.jsp?cno=" + cno + "&pageNum=" + pageNum);
	
%>


<body>

</body>
</html>