<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.model.WishListDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찜한 상품들</title>
<jsp:include page="../UIDcheck.jsp"></jsp:include>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<jsp:include page="../Header.jsp"></jsp:include>
<jsp:include page='../floatingAdvertisement.jsp'/>
</head>

<%
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
InstanceDAO dao = new InstanceDAO();
List<WishListDTO> wList = dao.getWishList(uid);
SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");


%>



<body>
<jsp:include page="MyPageCategory.jsp" />
<div id="mypagebody" >
<fieldset>
	<legend>찜한 상품</legend>
	<% 	if(wList != null){ %>
			<div id="seller">
				<p>상품</a></p>
				<p>가격</p>
				<p>판매기간</p>
			</div>
		
		<% 	int [] biddingNum = new int[wList.size()];
			for(int i =0 ; i<wList.size() ; i++){
			ProductDTO product = dao.getProduct(wList.get(i).getP_no());  %>
			<div id="seller">
				<p> <img src="../save/<%= product.getP_img1() %>"> </p>
				<p><%= product.getP_no() %> <a href=""> <%= product.getP_title() %></a></p>
				<% if(product.getP_status() == 1){ %>
				<p>  <%= product.getP_minPrice() %> ~ <%= product.getP_maxPrice() %></p>
				<% }else{ %>
				<p> <%= product.getP_price() %></p>
				<% } %> 
				<p> <%= sdf.format(product.getP_start()) %> ~ <%= sdf.format(product.getP_end()) %> </p>
				<% if(product.getP_status() == 1){
					biddingNum[i] = dao.getBiddingNum(product.getP_no());
				  %> 
					<% if(biddingNum[i]==-1){ %>
				<p>경매 : 
					입찰완료
					<% }else{ %>
					경매
					<% } %> 
				</p> 
				<% } %>
				<form action="deleteWishList.jsp" method="post">
					<input type="hidden" value="<%= product.getP_no() %>" name="p_no" />
					<input type="submit" value="찜해제">
				</form>
			</div>
		<%	}	%>
	<% 	}else{ %>
			<p>찜한 상품이 없습니다.</p>
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
<jsp:include page="../Footer.jsp"></jsp:include>
</body>
</html>