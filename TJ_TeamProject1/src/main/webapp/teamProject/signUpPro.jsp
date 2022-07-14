<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<% 
	request.setCharacterEncoding("UTF-8"); 
	//이미지때문에 multipart/form-data 이거 써야하고... SETPROPERTY가 안된다 ㅠㅠ
%>
<jsp:useBean id="member" class="team.project.dao.LeeDAO"/>
</head>
<body>
<%
	String path =request.getRealPath("save");
	System.out.println(path);
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp =new DefaultFileRenamePolicy();
	MultipartRequest mr =new MultipartRequest(request, path, max, enc, dp);
	
	member.setId(mr.getParameter("id"));
	member.setPw(mr.getParameter("pw"));
	member.setName(mr.getParameter("name"));
	member.setGender(mr.getParameter("gender"));
	member.setEmail(mr.getParameter("email"));
	
	member.setPhoto(mr.getFilesystemName("photo"));
	
	//db  가서 저장해
	ImgSignupDAO dao = new ImgSignupDAO();
	dao.insertMember(member);
	
	response.sendRedirect("main.jsp");
	
	
%>


</body>
</html>