<%@page import="team.project.dao.InstanceDAO"%>
<%@page import="team.project.model.UserListDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
uid = "qwe8246"; //	임시!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
String pw = request.getParameter("pw");
String confirm = request.getParameter("confirm");
GyeJeongDAO gjdao = new GyeJeongDAO();
InstanceDAO dao = new InstanceDAO();
UserListDTO dto = gjdao.getUserProfile(uid); 
%>

<body>
<%	int ok = 0;
	if(dto.getUser_pw().equals(pw)){ 
		ok += 1;
	}else{ %>
		<script type="text/javascript">
			window.location="deleteAccount.jsp";
			alert("비밀번호가 다릅니다.");
		</script>
<%	}
	if(confirm.equals("확인하였습니다")){
		ok += 1;
	}else{ %>
	<script type="text/javascript">
		window.location="deleteAccount.jsp";
		alert("확인 문자가 일치하지 않습니다.");
	</script>
<%	} 
	if(ok==2){
		int result = dao.deleteUser(uid);
		if(result==1){ %>
			<script type="text/javascript">
				window.location="../Main.jsp";
				alert("탈퇴처리 되었습니다.");
			</script>
	<%	}
	}%>
</body>
</html>