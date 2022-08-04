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
	<link href="../teamstyle.css" rel="stylesheet" type="text/css" />
<%
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
InstanceDAO dao = new InstanceDAO();
List<CategoryDTO> category = dao.getCategory();  

%>
<jsp:include page="../Header.jsp"></jsp:include>
</head>
<body>
<div class="mypageContent">
	<jsp:include page="MyPageCategory.jsp" />
	<div class="mypagebody" >
		<table style="margin: auto;">
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
</div>
<jsp:include page="../Footer.jsp"></jsp:include>
</body>
</html>