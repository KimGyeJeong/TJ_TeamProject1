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
	session.setAttribute("adminId", id);
	
	response.sendRedirect("AdminMain.jsp");
}else if(result<0){	//result == -1	>> DAO ERR
	%>
	<script type="text/javascript">
	alert("오류 발생..\n메인으로 돌아갑니다.");
	location.replace('../Main.jsp');
	</script>
	<%
}else{				//result == 0	>> Failed
	%>
	<script type="text/javascript">
	alert("아이디나 비밀번호가 일치하지않습니다.\n로그인페이지로 돌아갑니다.");
	location.replace('AdminLogin.jsp');
	</script>
	<%
}
%>

</body>
</html>