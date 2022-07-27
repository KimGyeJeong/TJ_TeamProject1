<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team.project.model.UserListDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@page import="team.project.model.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>정보 수정</title>
	<jsp:include page="../UIDcheck.jsp"></jsp:include>
	<jsp:include page="../Header.jsp"></jsp:include>
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
GyeJeongDAO gjdao = new GyeJeongDAO();
UserListDTO profile = gjdao.getUserProfile(uid);
SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");


%>
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
<fieldset>
	<form action="modifyProfilePro.jsp" method="post" enctype="multipart/form-data">
	
		ID : <%= profile.getUser_id() %>  <br> <br> 
		<details id="detail">  
			<summary> <button type="button" onclick="modify()">비밀번호 변경</button></summary>
	  		<p>
			비밀번호  <input type="password" name="modifyPW" value="">  <br><br>
			비밀번호 확인  <input type="text" name="modifyPWcheck" value="">  <br>
	  		</p>
		</details> <br>
		이름  <input type="text" name="username" value="<%= profile.getUser_name() %>">  <br><br>
		프로필 사진 <img src="../save/<%= profile.getUser_img() %>" width="200px"> <input type="file" name="profileIMG"> <br> <br>  
		E-Mail  <input type="text" name="email" value="<%= profile.getUser_email() %>"> <br><br>
		전화번호  <input type="text" name="phone" value="<%= profile.getUser_phone() %>"> <br><br>
	<br>
		<input type="submit" value="수정하기">
	</form>	
		<button type="button" onclick="window.location = 'MyPageInfo.jsp'">돌아가기</button>
		<div align="right" style="display: inline-block; ">
		<button type="button" onclick="location='deleteAccount.jsp'">회원탈퇴</button>
		</div>
</fieldset>
</div>
<script type="text/javascript">
function modify() {
	if(document.getElementById("detail").open===true){
		document.getElementById("detail").open = false;
	}else{
		document.getElementById("detail").open = true;
	}
}
</script>
</body>
</html>