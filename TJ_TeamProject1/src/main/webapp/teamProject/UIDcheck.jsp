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
String uid = (String)session.getAttribute("UID");
if(uid==null){ %>
	<script type="text/javascript">
		alert("로그인후 이용가능합니다.");
		window.location.href="/TJ_TeamProject1/teamProject/Main.jsp";
	</script>
<%}%>
</body>
</html>