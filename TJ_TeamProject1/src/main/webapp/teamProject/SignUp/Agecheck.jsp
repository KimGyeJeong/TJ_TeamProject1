<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page='../Header.jsp'/>
<jsp:include page='../floatingAdvertisement.jsp'/>
<style>
	button{
	align-content: center;
	}
	.div{
		align-content: center;
	}
</style>
<br/>
<br/>
<br/>
<br/>
<h1 align="center">장물아비는 만 14이상 이용하실 수 있습니다.</h1>
<br/>
<h2 align="center">당신은 만 14세 이상입니까?</h2>
<br/>
<br/>
<br/>



<div align="center">
<button  onclick="window.location.href='SignUpForm.jsp'" style="width:200px; height:50px; " >예, 맞습니다</button>
<button onclick="window.location.href='https://jr.naver.com/'" style="width:200px; height:50px;" >아니오</button>
</div>


<br/>
<br/>
<br/>
<br/>





<%@ include file="../Footer.jsp" %>
</body>
</html>