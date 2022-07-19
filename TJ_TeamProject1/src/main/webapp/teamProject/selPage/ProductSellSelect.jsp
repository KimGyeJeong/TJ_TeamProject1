<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반/경매 확인 페이지</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String UID = (String)session.getAttribute("UID");
%>
<body>
<table>
	<tr>
		<td><button onclick="window.location='ProductSelling.jsp?p_status=1'">경매로 판매</button></td>
		<td><button onclick="window.location='ProductSelling.jsp?p_status=0'">일반 판매</button></td>
		<td><button onclick="history.go(-1)">취소</button></td>
	</tr>
</table>
</body>
</html>