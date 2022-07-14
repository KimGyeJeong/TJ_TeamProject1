<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminLoginPro</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id").trim();
String pw = request.getParameter("pw").trim();

GyeJeongDAO dao	= new GyeJeongDAO();
int result = dao.idpwChk(id, pw);

if(result > 0){		//result == 1	>> success
	System.out.println("SUCCESS");
}else if(result<0){	//result == -1	>> DAO ERR
	
}else{				//result == 0	>> Failed
	
}
%>

</body>
</html>