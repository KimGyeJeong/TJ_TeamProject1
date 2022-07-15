<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String auto = request.getParameter("auto");
	
	GyeJeongDAO dao = new GyeJeongDAO();
	int result = dao.idpwChk(id,pw);
	if(result == 0 & result == -1){%>
	<script>
		alert("존재하지 않는 id 또는 pw 입니다...");
		history.go(-1);
	</script>
<%}else{
	//로그인 처리!!
	session.setAttribute("memId", id);
	



%>
	<script>
		alert("로그인 성공!!!!");
		window.location="main.jsp";
		
	
	</script>
	
<%}%>
</body>
</html>