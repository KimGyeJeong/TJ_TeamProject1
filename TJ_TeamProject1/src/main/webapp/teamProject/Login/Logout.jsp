<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%if(session.getAttribute("UID")==null){%>
		<script>
			alert("로그인 상태가 아닙니다.");
			history.go(-1);
		</script>
	<%  }%>
<%
	session.removeAttribute("UID");
	System.out.println("로그아웃됨");
	
	Cookie[] cs=request.getCookies();
	if(cs != null){
		for(Cookie c: cs){
			if(c.getName().equals("autoId")||c.getName().equals("autoPw")||c.getName().equals("autoCh")){
				c.setMaxAge(0);
				response.addCookie(c);
			}
		}
		
	}
	
	
	response.sendRedirect("../Main.jsp");
%>

</body>
</html>