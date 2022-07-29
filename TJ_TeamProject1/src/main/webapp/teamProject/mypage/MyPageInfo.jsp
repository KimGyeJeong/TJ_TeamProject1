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
	<title>계정 설정</title>
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
GyeJeongDAO gjdao = new GyeJeongDAO();
UserListDTO profile = gjdao.getUserProfile(uid);
SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");


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
	  <li><a href="../help/inquiryList.jsp"> 나의 문의사항 </a></li>
	  <li><a href="../help/Help.jsp"> 고객센터 </a></li>
	</ul>
<div id="mypagebody" >
<fieldset>
	<table>
		<tr>
			<td style="width: 700px;">
				<table>
					<tr>
						<td>ID : </td> <td> <%= profile.getUser_id() %> </td>
					</tr>
					<tr>
						<td>이름 : </td> <td> <%= profile.getUser_name() %> </td>
						
					</tr>
					<tr>
						<td>잔액 : </td> <td> <%= profile.getUser_usemoney() %>&nbsp; 원</td>
					</tr>
					<tr>
						<td>평점 : </td> <td> <%= profile.getUser_stars() %> / 5</td>
					</tr>
					<tr>
						<td>E-Mail : </td> <td> <%= profile.getUser_email() %> </td>
					</tr>
					<tr>
						<td>전화번호 : </td> <td> <%= profile.getUser_phone() %> </td>
					</tr>
					<tr>
						<td>가입일 : </td> <td> <%= sdf.format(profile.getUser_reg())  %> </td>
					</tr>
				<% 	if(profile.getUser_report()==1){ %>
					<tr>
						<td>상태 : 활동정지</td> <td> 
					</tr>
					<tr>
						<td>기간 : </td> <td><%= sdf.format(profile.getUser_activeReg()) %></td> 
					</tr>
				<% 	} %>
				</table>
			</td>
			<td>
				<img src="../save/<%= profile.getUser_img() %>" width="200px">  
			</td>
		</tr>
	</table> 
	<br>
	<div>
		<button type="button" onclick="location='PasswordConfirm.jsp'">정보수정</button>
		<button type="button" onclick="address('transAddress.jsp')">배송지 수정하기</button>
	</div>
</fieldset>
</div>
<jsp:include page="../Footer.jsp"></jsp:include>
<script type="text/javascript">
function address(uri){
	let properties = "top=100 , left=600 , width=500, height=800, "; 
		properties += "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no";
		addr = window.open(uri,"address",properties);
}
</script>
</body>
</html>