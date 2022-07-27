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
<body>
<% 
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
int pno = Integer.parseInt(request.getParameter("p_no")); 
InstanceDAO dao = new InstanceDAO();
int result = dao.deleteWishList(pno, uid);
if(result == 1){
	response.sendRedirect("MyWishList.jsp");
}
%>
</body>
</html>