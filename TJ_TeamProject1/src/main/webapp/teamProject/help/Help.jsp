<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>고객센터문의 페이지</title>
	<link href="../style.css" rel="stylesheet" type="text/css" />
	
<%
String id = null, pw = null, auto = null; 
Cookie[] coos = request.getCookies(); 
if(coos != null){
	for(Cookie c : coos) {
		
		if(c.getName().equals("autoId")) id = c.getValue();   
		if(c.getName().equals("autoPw")) pw = c.getValue();
		if(c.getName().equals("autoCh")) auto = c.getValue();
		System.out.println(id + pw + auto +"쿠키확인");
	}	
}

if(auto != null && id != null && pw != null){
	response.sendRedirect("Login/LoginPro.jsp");
}%>

<%request.setCharacterEncoding("UTF-8"); %>
<%id=(String)session.getAttribute("UID"); %>
	<h3 align="right"> 사용자: <%=id %></h3>
	
	<%if(session.getAttribute("UID") == null || session.getAttribute("UID") == "null" || session.getAttribute("UID") ==""){%>
		<script>
  		alert("로그인 후 사용가능한 서비스입니다.");
  		history.go(-1);
  		</script>
		
    <%}else{%>
    	<input type="button" value="로그아웃" onclick="window.location='../Login/Logout.jsp'" style="float: right;"/>
  		
    <%}%>
    
    
</head>
<body>
<br />
<h2 align="center">고객센터</h2>
<h2 align="center">무엇을 도와드릴까요?</h2>

<table>
	<tr>
		<td>
		<img onclick="location.href='http://localhost:8080/TJ_TeamProject1/teamProject/help/inquiry.jsp'" src="helpimg.jpg" width='150'/>
		
		</td>
		<td>
		<img onclick="location.href='http://localhost:8080/TJ_TeamProject1/teamProject/help/inquiryList.jsp'" src="helpimg2.jpg" width='150'/>
		
		</td>
		<td>
		<img onclick="location.href='http://localhost:8080/TJ_TeamProject1/teamProject/help/QnA.jsp'" src="helpimg3.png" width='150'/>
		
		</td>
	</tr>
	<tr>
		<td>
		1:1문의하기
		</td>
		<td>
		1:1문의내역
		</td>
		<td>
		Q n A
		</td>
	</tr>
	
</table>
	

</body>
</html>