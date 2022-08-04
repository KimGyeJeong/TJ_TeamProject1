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
	<link href="../teamstyle.css" rel="stylesheet" type="text/css" />
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
<div class="mypageContent">
<jsp:include page="MyPageCategory.jsp" />
	<div class="mypagebody" >
		<fieldset style="width: 55%; margin: auto;">
			<form action="modifyProfilePro.jsp" method="post" enctype="multipart/form-data" >
			
				ID : <%= profile.getUser_id() %>  <br> <br> 
				<details id="detail">  
					<summary> <button type="button" onclick="modify()">비밀번호 변경</button></summary>
			  		<p>
					비밀번호  <input type="password" name="modifyPW" value="">  <br><br>
					비밀번호 확인  <input type="password" name="modifyPWcheck" value="">  <br>
			  		</p>
				</details> <br>
				이름  <input type="text" name="username" value="<%= profile.getUser_name() %>">  <br><br>
				프로필 사진 <img src="../save/<%= profile.getUser_img() %>" width="200px" height="200px;"> <br><br> 
				<input type="file" name="profileIMG"> <br> <br>  
				E-Mail  <input type="text" name="email" value="<%= profile.getUser_email() %>"> <br><br>
				전화번호  <input type="text" name="phone" value="<%= profile.getUser_phone() %>"> <br><br>
				<br>
				<input type="submit" value="수정하기">
				<button type="button" onclick="window.location = 'MyPageInfo.jsp'">돌아가기</button>
				<button type="button" onclick="location='deleteAccount.jsp'" style="float: right;">회원탈퇴</button>
			</form>	
		</fieldset>
	</div>
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