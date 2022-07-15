<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%if(session.getAttribute("u_id")==null){%>
		<script>
			alert("로그인 상태가 아닙니다.");
			history.go(-1);
		</script>
	<%  }%>
<%
	session.removeAttribute("u_id");
	System.out.println("로그아웃됨");
	
	response.sendRedirect("../Main.jsp");
%>

</body>
</html>