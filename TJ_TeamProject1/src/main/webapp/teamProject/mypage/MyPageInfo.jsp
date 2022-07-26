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
	<title>Insert title here</title>
	<link href="../style.css" rel="stylesheet" type="text/css" />
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
uid = "qwe8246";
InstanceDAO dao = new InstanceDAO();
List<CategoryDTO> category = dao.getCategory();  
GyeJeongDAO gjdao = new GyeJeongDAO();
UserListDTO profile = gjdao.getUserProfile(uid);
SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");


%>
<div style="display: block; margin: 10px 20% 10px;" align="right" >
		<a href="window.location.href='Login.jsp'" style="width:50px; height: 20px;" >로그인 </a> &nbsp;
		<a href="window.location.href=" style="width:50px; height: 20px; " >회원가입 </a>&nbsp;
		<a href="" style="width:50px; height: 20px; " >알림</a>
								
	</div>
	<div align="center">
		<a href="../Main.jsp"><img alt="장물아비" src="image/logo.png" width="50px"></a>
		<h1 style="display: inline-block;">장물아비</h1>
		<form action="../MainSearchPro.jsp" style="display: inline-block;">
			<input type="text" name="searchword">
			<input type="image" name="submit" src="image/logo.png" alt="검색" width="30px" height="30px" />
		</form>
		<button onclick="window.location.href='../ProductSellSelect.jsp'" style="width:45px; height: 40px;" >판매하기</button>
		<button onclick="window.location.href='/TJ_TeamProject1/teamProject/mypage/OrderProcessList.jsp'" style="width:45px; height: 40px; font-size: 8.5px;" >내정보</button>
		<button onclick="window.location.href=" style="width:45px; height: 40px; font-size: 8.5px;" >게시판</button>
		<div style=" margin-right: 300px;">
	<form action="" name="ca" method="post">
		<select name = "cano" onchange="window.location.href=document.ca.cano.value" style="width: 150px;">
			<option>카테고리</option>
		<%	for(int i = 0; i<category.size() ; i++){
				CategoryDTO ca = category.get(i);
				if(ca.getCa_level()==0){ %>
					<optgroup label="<%= ca.getCa_name() %>"></optgroup>
				<%	for(int j = 0; j<category.size(); j++){
						CategoryDTO dto = category.get(j);
						if(dto.getCa_level()==1 && dto.getCa_grp()==ca.getCa_grp()){
							%>
								<option value="../selPage/ProductList.jsp?ca_no=<%= dto.getCa_no() %>"><%= dto.getCa_name() %></option>
							<%
						}
					}
				}
			}
		%>
		</select>
	</form>
		</div>
	</div>
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
	<table>
		<tr>
			<td>ID : </td> <td> <%= profile.getUser_id() %> </td>
		</tr>
		<tr>
			<td>이름 : </td> <td> <%= profile.getUser_name() %> <img src="<%= profile.getUser_img() %>"></td>  
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
	<br>
	<div>
		<button type="button" onclick="location='PasswordConfirm.jsp'">정보수정</button>
	</div>
</fieldset>
</div>
</body>
</html>