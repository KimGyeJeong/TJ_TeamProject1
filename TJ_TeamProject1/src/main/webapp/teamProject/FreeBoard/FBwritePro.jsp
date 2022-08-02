<%@page import="team.project.dao.LeeDAO"%>
<%@page import="team.project.model.ContentDTO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>writePro</title>
	<% String id=(String)session.getAttribute("UID"); %>
	<h3 align="right"> 사용자: <%=id %></h3>
	
</head>
<%
	request.setCharacterEncoding("UTF-8");
	ContentDTO article = new ContentDTO(); 
	
	String path = request.getRealPath("/teamProject/save"); 
	System.out.println(path);
	int max = 1024*1024*5; 
	String enc = "UTF-8"; 
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	
	// subject, writer, content, img, email, bpw 
	article.setC_title(mr.getParameter("subject"));
	article.setUser_id(id);
	article.setC_content(mr.getParameter("content"));
	article.setC_img(mr.getFilesystemName("img"));   
	 
	System.out.println("김범수수수:"+article.getC_img());
	LeeDAO dao = new LeeDAO(); 
	dao.insertContent(article);    
	
	response.sendRedirect("FreeBoard.jsp");
	
%>

<body>

</body>
</html>