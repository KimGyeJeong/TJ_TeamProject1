<%@page import="java.util.ArrayList"%>
<%@page import="team.project.model.BiddingDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.model.OrderListDTO"%>
<%@page import="team.project.model.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>입찰한 상품</title>
	<jsp:include page="../UIDcheck.jsp"></jsp:include>
	<jsp:include page='../floatingAdvertisement.jsp'/>
	<jsp:include page='../Header.jsp'/>
	<link href="../teamstyle.css" rel="stylesheet" type="text/css" />
	
	
	<style type="text/css">
	#notThing{
		margin-top : 50px;
		text-align: center;
		font-size: 24px;
	}
	</style> 
<% 
	String uid = (String)session.getAttribute("UID");
	request.setCharacterEncoding("UTF-8");
	SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
	InstanceDAO dao = new InstanceDAO();
	List<BiddingDTO> biddinglist = dao.getBiddigList(uid);
	List<ProductDTO> productlist = dao.getProductList((ArrayList<BiddingDTO>)biddinglist);
	
%>
</head>
<body>
<div class="mypageContent">
	<jsp:include page="MyPageCategory.jsp" />
	<div class="mypagebody" >
		<fieldset>
		<legend>입찰한 상품</legend>
			<table class="ordertable" >
				<tr class="bodylist" >
			<%	if(productlist != null){ %>
					<td width="300px">상품정보</td>  <td>기간</td> <td>상태</td>
				</tr>
				<%	for(int i=0; i<productlist.size() ; i++){
						ProductDTO product = productlist.get(i); 
						BiddingDTO bidding = biddinglist.get(i); %>
						
					<tr>
						<td><a href="../selPage/ProductDetailBuyForm.jsp?p_no=<%= product.getP_no() %>"><img src="../save/<%= product.getP_img1() %>"  width="100px" height="100px"/></a>
						&nbsp;&nbsp;<a href="../selPage/ProductDetailBuyForm.jsp?p_no=<%= product.getP_no() %>"> <%= product.getP_title() %> </a> </td>
						<td> <%= sdf.format(product.getP_start())  %> ~ <%= sdf.format(product.getP_end()) %></td>
						<td>
						<% 	if(bidding.getB_status() == 0){ %>
								입찰 대기중
						<% 	}else if(bidding.getB_status() == 1){ %>
								낙찰
						<% 	}else if(bidding.getB_status() == 2){ %>
								유찰
						<%	} %>
						</td>
						</tr>	
						
				<%	}%>
			
			<%	}else{ %>
				<p id="notThing"> 구매한 상품이 없습니다. </p>	
			<%	} %>
			</table>
		</fieldset>
	</div>
</div>	
</body>

<script type="text/javascript">
		function address(uri){
			let properties = "top=100 , left=600 , width=500, height=800, "; 
				properties += "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no";
				addr = window.open(uri,"address",properties);
		}
		function detail(uri){
			let properties = "top=100 , left=600 , width=1000, height=800, "; 
				properties += "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no";
			window.open(uri,"OrderProInfo",properties);
		}
		function writeReview() {
			let property = "top=100 , left=300 , width=1000, height=800, "; 
			property += "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no ";
		  	window.open('_blank',"writeReview",property);
		}
</script>

<jsp:include page='../Footer.jsp'/>
</html>