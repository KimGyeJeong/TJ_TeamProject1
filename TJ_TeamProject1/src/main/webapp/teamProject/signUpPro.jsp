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
<% 
	request.setCharacterEncoding("UTF-8"); 

%>
<jsp:useBean id="member" class="team.project.model.UserListDTO"/>
<jsp:useBean id="member_add" class="team.project.model.AddressDTO"/>
</head>
<body>
<% 
	String path =request.getRealPath("save");
	System.out.println(path);
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp =new DefaultFileRenamePolicy();
	MultipartRequest mr =new MultipartRequest(request, path, max, enc, dp);

	
	member.setUser_id(mr.getParameter("id"));
	member.setUser_pw(mr.getParameter("pw"));
	member.setUser_email(mr.getParameter("email"));
	member.setUser_name(mr.getParameter("name"));
	member.setUser_phone(mr.getParameter("phone"));
	member.setUser_img(mr.getParameter("photo"));
	
	member_add.setA_tag(mr.getParameter("addressName"));
	member_add.setA_zipCode(Integer.parseInt(mr.getParameter("zipcode")));
	member_add.setA_address(mr.getParameter("address1"));
	member_add.setA_address2(mr.getParameter("address2"));
	
	LeeDAO dao = new LeeDAO();
	dao. insertNewUser(member, member_add);
	
	
	
	//db  가서 저장해
	//ImgSignupDAO dao = new ImgSignupDAO();
	//dao.insertMember(member);
	

	response.sendRedirect("main.jsp");
	
	
%>


</body>
</html>