<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반/경매 확인 페이지</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String UID = (String)session.getAttribute("UID");
%>
<style>
#fox{
	display: block;
	margin-left: 25%;
	margin-top: 3%;
;
}
</style>
<body>
<jsp:include page='../Header.jsp'/>
<%if(UID != null){ %>
<div align="center">
<h1 align="center">일반/경매 판매 선택 페이지</h1>
<table id='fox'>
	<tr>
		<td><button onclick="window.location='ProductSelling.jsp?p_status=1'" style="width:400px; height:100px; ">입찰 판매</button> &nbsp;<button onclick="window.location='ProductSelling.jsp?p_status=0'" style="width:400px; height:100px; ">일반 판매</button></td>
	</tr>


</table>
</div>
<br/>
<br/>
<br/>
<div align="center">
<button  onclick="history.go(-1)" style="width:250px; height:50px; ">돌아가기</button>
</div>
<%}else{%>
		<script>
			alert("로그인 후 이용해 주세요!");
			window.location.assign("../Login/Login.jsp");
		</script>
<%	}%>
 <jsp:include page='../floatingAdvertisement.jsp'/>
	
	<br/>
	<br/>
	<br/>
<%@ include file="../Footer.jsp" %>
</body>
</html>