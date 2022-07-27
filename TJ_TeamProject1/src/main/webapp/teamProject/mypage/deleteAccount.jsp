<%@page import="team.project.model.UserListDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<%
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");

uid = "qwe8246"; //	임시!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

%>
<style>
	#header * {
		display: inline-block;
	}
</style>
<body>
<jsp:include page="../Header.jsp"></jsp:include>
<p> 주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들
주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들
주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들주의 사항들 </p>
<form action="deleteAccountPro.jsp" method="post">
아이디 : <%= uid %> 비밀번호 : <input type="text" name="pw" placeholder="Password"> <br>
<input type="text" name="confirm" placeholder="확인하였습니다">
<h4>유의사항을 모두 확인하셨고 탈퇴를 원하시면 위 항목에 "확인하였습니다" 를 입력해주세요</h4>
<input type="button" value="취소" onclick="window.location='MyPageInfo.jsp'">
<input type="submit" value="탈퇴하기"> 
</form>
<jsp:include page="../Footer.jsp"></jsp:include>
</body>
</html>