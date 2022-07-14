<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminLogin</title>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>

	<h1>장물아비 어드민 페이지</h1>

	<form action="AdminLoginPro.jsp" method="post">
		<table>
			<tr>
				<td>AdminId :</td>
				<td><input type="text" name="id"></td>
			</tr>
			<tr>
				<td>AdminPw :</td>
				<td><input type="password" name="pw"></td>
			</tr>
			<tr>
				<td ><input type="submit" value="login"> <input
					type="button" value="go Main" onclick="location.href='../Main.jsp'">
				</td>
			</tr>
		</table>
	</form>


</body>
</html>