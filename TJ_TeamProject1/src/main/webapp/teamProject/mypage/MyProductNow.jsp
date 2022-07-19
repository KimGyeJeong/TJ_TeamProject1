<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@page import="team.project.model.CategoryDTO"%>
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
			bottom: 400px;
			left: 50px;
			display:inline-block;
		}
		#seller p {
			display: inline;
		}
	</style>

	<%
	request.setCharacterEncoding("UTF-8");
	String uid = (String)session.getAttribute("UID");
	
	
	uid = "17"; 		//	임시!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	InstanceDAO dao = new InstanceDAO();
	List<CategoryDTO> category = dao.getCategory(); 
	List<ProductDTO> sellerProduct = dao.getSellerProduct(uid);
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
	
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
		<button onclick="window.location.href='http://localhost:8080/TJ_TeamProject1/teamProject/mypage/MyProductNow.jsp'" style="width:45px; height: 40px; font-size: 8.5px;" >내정보</button>
		<button onclick="window.location.href=" style="width:45px; height: 40px; font-size: 8.5px;" >게시판</button>
		<div style=" margin-right: 300px;">
	<form action="" name="ca">
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
  <li><a href="WishList.jsp"> 찜 </a></li>
  <li><a href="MyReview.jsp"> 나의 후기 </a></li>
  <li><a href="AddMyMoney.jsp"> 잔액충전 </a></li>
  <li><a href="MyPageInfo.jsp"> 계정설정 </a></li>
  <li><a href=""> 나의 문의사항 </a></li>
  <li><a href="MyHelp.jsp"> 고객센터 </a></li>
</ul>
<div id="mypagebody" >
<fieldset>
	<legend>나의 판매중인 상품</legend>
		<div id="seller">
			<p>상품</a></p>
			<p>가격</p>
			<p>판매기간</p>
		</div>
	<% 	for(int i =0 ; i<sellerProduct.size() ; i++){
		ProductDTO product = sellerProduct.get(i); %>
		<div id="seller">
			<p> <img src="<%= product.getP_img1() %>"> </p>
			<p><%= product.getP_no() %> <a href=""> <%= product.getP_title() %></a></p>
			<p>  <%= product.getP_minPrice() %> ~ <%= product.getP_maxPrice() %></p>
			<p> <%= sdf.format(product.getP_start()) %> ~ <%= sdf.format(product.getP_end()) %> </p>
			<form action="ProductCancel.jsp" method="post">
				<input type="hidden" name="P_no" value="<%= product.getP_no() %>">
				<input type="submit" value="등록취소"> 
			</form>
		</div>
<%		}
		%>
	<div></div>
</fieldset>
</div>
	
</body>
</html>