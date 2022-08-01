<%@page import="team.project.model.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
	<meta charset="UTF-8">
	<title>확인</title>
	<jsp:include page="../UIDcheck.jsp"></jsp:include>
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">	
	<style type="text/css">
		#mypagebody{
			position: relative;
			left: 50px;
			display:inline-block;
		}
		fieldset {
			display: inline-block;
			width: 500px;	
		}	
	</style>
<%
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
InstanceDAO dao = new InstanceDAO();
List<CategoryDTO> category = dao.getCategory();  

%>
<jsp:include page="../Header.jsp"></jsp:include>
</head>
<body>
<jsp:include page="MyPageCategory.jsp" />
<div id="mypagebody" >
	
	<table>
		<tr>
			<td>비밀번호확인</td>
		</tr>
		<tr>
			<td>
				<form action="PasswordConfirmPro.jsp" method="post">
					<input type="password" name="pw"> <br>
					<input type="submit" value="확인">
					<button type="button" onclick="history.go(-1)">돌아가기</button>
				</form>
			</td>
		</tr>
	</table>
</div>
<jsp:include page="../Footer.jsp"></jsp:include>
</body>
</html>