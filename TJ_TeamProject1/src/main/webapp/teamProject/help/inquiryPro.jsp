<%@page import="team.project.dao.LeeDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="inquiry" class="team.project.model.UserQuestionDTO"/>
</head>
<body>
<% request.setCharacterEncoding("UTF-8");
	String path =application.getRealPath("teamProject/save"); 
	System.out.println(path);
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp =new DefaultFileRenamePolicy();
	MultipartRequest mr =new MultipartRequest(request, path, max, enc, dp);

	inquiry.setUser_id((String)session.getAttribute("u_id")); 
	inquiry.setUq_title(mr.getParameter("subject"));
	inquiry.setUq_cat(mr.getParameter("category"));
	inquiry.setUq_content(mr.getParameter("content"));
	inquiry.setUq_img1(mr.getParameter("img1"));
	inquiry.setUq_img2(mr.getParameter("img2"));
	inquiry.setUq_img3(mr.getParameter("img3"));
	
	LeeDAO dao = new LeeDAO();
	int result =dao.insertinquiry(inquiry); 
	System.out.println("inquiry:"+inquiry);
	
	response.sendRedirect("Help.jsp");
	
	
	

%>



</body>
</html>