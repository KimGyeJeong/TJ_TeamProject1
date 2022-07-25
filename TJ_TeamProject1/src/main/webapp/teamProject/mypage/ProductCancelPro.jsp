<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
request.setCharacterEncoding("UTF-8");
String pno = request.getParameter("p_no");
InstanceDAO dao = new InstanceDAO();


int result = dao.deleteProduct(pno);

if(result == 1){
	response.sendRedirect("MyProductNow.jsp");
}

%>
<body>

</body>
</html>