<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminHelp</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");

String uq_no = request.getParameter("uq_no");
%>

<h4><%=uq_no %></h4>
<%-- 답변하기 --%>

</body>
</html>