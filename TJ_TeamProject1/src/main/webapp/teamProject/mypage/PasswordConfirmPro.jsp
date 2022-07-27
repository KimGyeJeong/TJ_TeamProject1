<%@page import="team.project.dao.LeeDAO"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<jsp:include page="../UIDcheck.jsp"></jsp:include>
</head>
<%
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
String pw = request.getParameter("pw");
uid = "qwe8246";
LeeDAO dao = new LeeDAO();
int result = dao.idpwChkUser(uid, pw);
if(result>0){
	response.sendRedirect("modifyProfile.jsp");
}else{
	response.sendRedirect("PasswordConfirm.jsp");
}
%>
<body>

</body>
</html>