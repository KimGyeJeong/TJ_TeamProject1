<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<%
if(session.getAttribute("UID") == null){ // 로그인 안했을때 
	
	// 쿠키가 있는지 검사 
	String id = null, pw = null, auto = null; 
	Cookie[] coos = request.getCookies(); 
	if(coos != null){
		for(Cookie c : coos) {
			// 쿠키가 있다면 쿠키에 저장된 값꺼내 변수에 담기
			if(c.getName().equals("autoId")) id = c.getValue();   
			if(c.getName().equals("autoPw")) pw = c.getValue();
			if(c.getName().equals("autoCh")) auto = c.getValue(); 
		}
		System.out.println("main쿠키확인 :"+id+pw+auto);
	}

 
	
	// 세개 변수에 값이 들어있을 경우 (쿠키 제대로 생성되서 다 갖고 있다.)
	if(auto != null && id != null && pw != null){
		// 로그인 처리되도록 loginPro.jsp 처리 페이지로 이동시키기 
		response.sendRedirect("loginPro.jsp");
	}
}



%>
</head>
<body>
<h1>메인</h1>
<%String id=(String)session.getAttribute("UID"); 
System.out.println("id :"+id);
%>
<h3 align="right"> 사용자: <%=id %></h3>

<%if(session.getAttribute("UID") != null){%>
<input  type="button" value="로그아웃" onclick="window.location='Login/Logout.jsp'" style="float: right;"/>
<%}else{%>
	<script>
		
		
	</script>
<%}%>




<input type="button" value="logout" onclick="location.href='Login/Logout.jsp'"/>
</body>
</html>