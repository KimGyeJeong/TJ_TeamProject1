<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>writeForm</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
<% String id=(String)session.getAttribute("UID");%>

	
</head>
<body>
	<br /> 
	<h1 align="center"> Write Article </h1>
	<form action="FBwritePro.jsp" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>제  목</td>
				<td><input type="text" name="subject" /></td>
			</tr>		
			<tr>
				<td>작성자</td>
				<td><%=id %></td>
			</tr>		
			<tr>
				<td>내  용</td>
				<td><textarea rows="15" cols="50" name="content"></textarea></td>
			</tr>		
			<tr>
				<td>이미지</td>
				<td><input type="file" name="img" /></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="저장" />
					<input type="button" value="취소"  onclick="window.location='../Main.jsp'" />
				</td>
			</tr>
		</table>
	</form>





</body>
</html>