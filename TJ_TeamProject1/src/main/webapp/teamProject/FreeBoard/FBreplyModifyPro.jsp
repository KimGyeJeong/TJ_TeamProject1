<%@page import="team.project.dao.LeeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>reply modify pro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
	int cno = Integer.parseInt(request.getParameter("cno"));
	int rno = Integer.parseInt(request.getParameter("rno"));
	String reply = request.getParameter("reply");
	
	LeeDAO dao = new LeeDAO();
	dao.updateReply(rno, reply);  
	
	response.sendRedirect("FBcontent.jsp?cno=" + cno + "&pageNum=" + pageNum);
%>

<body>

</body>
</html>