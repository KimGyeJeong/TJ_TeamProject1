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
	<title>판매중인 상품</title>
	<jsp:include page="../UIDcheck.jsp"></jsp:include>
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<jsp:include page="../Header.jsp"></jsp:include>
	<jsp:include page='../floatingAdvertisement.jsp'/>
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
	</style>

	<%
	request.setCharacterEncoding("UTF-8");
	String uid = (String)session.getAttribute("UID");
	
	
	InstanceDAO dao = new InstanceDAO();
	List<CategoryDTO> category = dao.getCategory(); 
	List<ProductDTO> sellerProduct = dao.getSellerProduct(uid);
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
	
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
  <li><a href="../help/inquiryList.jsp"> 나의 문의사항 </a></li>
  <li><a href="../hlep/Help.jsp"> 고객센터 </a></li>
</ul>
<div id="mypagebody" >
<fieldset>
	<legend>나의 판매중인 상품</legend>
	<% 	if(sellerProduct != null){ %>
		<div id="seller">
			<p>상품</a></p>
			<p>가격</p>
			<p>판매기간</p>
		</div>
	
		<%	for(int i =0 ; i<sellerProduct.size() ; i++){
			ProductDTO product = sellerProduct.get(i); %>
			<div id="seller">
				<p> <img src="<%= product.getP_img1() %>"> </p>
				<p><%= product.getP_no() %> <a href=""> <%= product.getP_title() %></a></p>
				<p>  <%= product.getP_minPrice() %> ~ <%= product.getP_maxPrice() %></p>
				<p> <%= sdf.format(product.getP_start()) %> ~ <%= sdf.format(product.getP_end()) %> </p>
				<% if(product.getP_status() == 1){ %> 
				<p>경매 : 
					<% if(dao.getBiddingNum(product.getP_no())==-1){ %>
					입찰완료
					<% }else{ %>
					<%= dao.getBiddingNum(product.getP_no()) %>
					<% } %> 
				</p> 
				<% } %>
				<form action="ProductCancelPro.jsp" onSubmit="return deleteProductCheck()" method="post">
					<input type="hidden" name="p_no" value="<%= product.getP_no() %>">
					<input type="submit" value="등록취소">
				</form>
				<form action="ProductModifyForm.jsp" method="post">
					<input type="hidden" name="p_no" value="<%= product.getP_no() %>">
					<input type="submit" value="수정하기">
				</form>
			</div>
	<%		}
		}else{ %>
			<h3>등록된 상품이 없습니다</h3>
			<h3> <button onclick="window.location='../selPage/ProductSellSelect.jsp'"> 등록하러가기</button> </h3>
	<% 	} %>
	<div></div>
</fieldset>
</div>
<script type="text/javascript">
function deleteProductCheck(){
	let confirmValue = confirm("등록된 상품을 취소하시겠습니까?");
	console.log(confirmValue);
	return confirmValue;
}
</script>
<jsp:include page="../Footer.jsp" />
</body>
</html>