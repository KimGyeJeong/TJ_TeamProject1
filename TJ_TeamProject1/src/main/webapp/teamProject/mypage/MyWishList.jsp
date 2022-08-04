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
<jsp:include page="../Header.jsp"></jsp:include>
<jsp:include page='../floatingAdvertisement.jsp'/>
<link href="../teamstyle.css" rel="stylesheet" type="text/css" />
</head>

<%
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
InstanceDAO dao = new InstanceDAO();
List<WishListDTO> wList = dao.getWishList(uid);
SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");


%>



<body>
<div class="mypageContent">
<jsp:include page="MyPageCategory.jsp" />
	<div class="mypagebody" >
		<fieldset>
		<legend>찜한 상품</legend>
	<% 	if(wList != null){ %>
			<table class="ordertable">
				<tr class="bodylist">
					<td>상품</td>
					<td>가격</td>
					<td>판매기간</td>
					<td>상태</td>
					<td>&nbsp;</td>
				</tr>
		
			<% 	int [] biddingNum = new int[wList.size()];
				for(int i =0 ; i<wList.size() ; i++){
				ProductDTO product = dao.getProduct(wList.get(i).getP_no());  %>
				<tr>
					<td> <img src="../save/<%= product.getP_img1() %>" width="100px" height="100px"> 
				<%= product.getP_no() %>&nbsp;&nbsp;<%= product.getP_title() %></td>
				<% 	if(product.getP_status() == 1){ %>
					<td>  <%= product.getP_minPrice() %> ~ <%= product.getP_maxPrice() %></td>
				<%	}else{ %>
					<td> <%= product.getP_price() %></td>
					<% } %> 
					<td> <%= sdf.format(product.getP_start()) %> ~ <%= sdf.format(product.getP_end()) %> </td>
				<% 	if(product.getP_status() == 1){
						biddingNum[i] = dao.getBiddingNum(product.getP_no()); %>
					<% 	if(biddingNum[i]==-1){ %>
						<td>
							경매 : 
							입찰완료
						</td>	
							<% }else{ %>
						<td>	
							경매
						</td>	
					<% 	} %> 
				<% 	} %>
					<td>
						<form action="deleteWishList.jsp" method="post">
							<input type="hidden" value="<%= product.getP_no() %>" name="p_no" />
							<input type="submit" value="찜해제">
						</form>
					</td>
				</tr>
			<%	}	%>
			</table>
	<% 	}else{ %>
			<p>찜한 상품이 없습니다.</p>
	<% 	} %>
		</fieldset>
	</div>
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