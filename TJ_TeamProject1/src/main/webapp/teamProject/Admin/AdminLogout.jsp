<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminLogout</title>
</head>
<body>

<jsp:include page='AdminSessionCheck.jsp' />


<%
request.setCharacterEncoding("UTF-8");

session.removeAttribute("adminId");
%>
<script type="text/javascript">
alert("Admin 로그아웃완료!\n장물아비메인페이지로돌아갑니다.");
location.href="/TJ_TeamProject1/teamProject/Main.jsp";
</script>

<h4>여기서는 로그아웃을 할겁니다.</h4>
</body>
</html>