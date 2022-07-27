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
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">	
	<style type="text/css">
		#mypagelist {
			list-style: none;
			display: inline-block;
		}
		#mypagelist li{
			margin: 20px;
			font-size: 18px;
		}
		#mypagebody{
			position: relative;
			left: 50px;
			display:inline-block;
		}
		#seller p {
			display: inline;
		}
		fieldset {
			display: inline-block;
			width: 500px;	
		}	
	</style>
<%
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
InstanceDAO dao = new InstanceDAO();
List<CategoryDTO> category = dao.getCategory();  

%>
<jsp:include page="../Header.jsp"></jsp:include>
</head>
<body>
	<h1 style="padding-bottom: 50px; ">&nbsp;</h1>
	
	<ul id="mypagelist">
	  <li><a href="OrderProcessList.jsp"> 구입한 상품 </a></li>
	  <li><a href="MyProductNow.jsp"> 나의 판매중인 상품 </a></li>
	  <li><a href="MyWishList.jsp"> 찜 </a></li>
	  <li><a href="MyReview.jsp"> 나의 후기 </a></li>
	  <li><a href="AddMyMoney.jsp"> 잔액충전 </a></li>
	  <li><a href="MyPageInfo.jsp"> 계정설정 </a></li>
	  <li><a href=""> 나의 문의사항 </a></li>
	  <li><a href="MyHelp.jsp"> 고객센터 </a></li>
	</ul>
<div id="mypagebody" >
	
	<table>
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
<jsp:include page="../Footer.jsp"></jsp:include>
</body>
</html>