<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>고객센터문의 페이지</title>
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">	
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
	
	
	
  	<style>
  	td{
  		size: 150px;
  	}
  	#box{
	display: block;
	margin-left: 30%;
	margin-top: 3%;
	
	}
  	
  	</style>
</head>
<body>
<jsp:include page='../Header.jsp'/>
<jsp:include page='../floatingAdvertisement.jsp'/>
<br />
<br />
<br />
<h2 align="center">고객센터</h2>
<h2 align="center">무엇을 도와드릴까요?</h2>

<table id='box'>
	<tr>
		<td>
		<img onclick="location.href='/TJ_TeamProject1/teamProject/help/inquiry.jsp'" src="helpimg.jpg" width='200px'/>
		
		</td>
		<td>
		<img onclick="location.href='/TJ_TeamProject1/teamProject/help/inquiryList.jsp'" src="helpimg2.jpg" width='200px'/>
		</td>
		
		<td>
		<img onclick="location.href='/TJ_TeamProject1/teamProject/help/QnA.jsp'" src="helpimg3.png" width='200px'/>
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
<br />
<br />
<br />
<%@ include file="../Footer.jsp" %>

</body>
</html>