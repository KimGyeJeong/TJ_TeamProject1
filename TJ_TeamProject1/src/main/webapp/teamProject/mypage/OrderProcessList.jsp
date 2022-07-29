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
	<title>구입한 상품</title>
	<jsp:include page="../UIDcheck.jsp"></jsp:include>
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<jsp:include page='../floatingAdvertisement.jsp'/>
	<jsp:include page='../Header.jsp'/>
	
	
	
	 <style type="text/css">
	 	#bodylist * {
	 		width : 80px;
	 		align:"center";
	 	}
		#mypagelist {
			list-style: none;
			display: inline-block;
		}
		#mypagelist li{
			margin: 20px;
			font-size: 18px;
		}
		#mypagebody{
			width: 480px;
			position: relative;
			left: 50px;
			display:inline-block;
		}
		#seller p {
			display: inline;
		}
		#ordertable {
			margin: 10px;
		}
	</style> 
	<% 
	String uid = (String)session.getAttribute("UID");
	request.setCharacterEncoding("UTF-8");
	SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
	InstanceDAO dao = new InstanceDAO();
	List<CategoryDTO> category = dao.getCategory();  
	List<OrderListDTO> orderlist = dao.getOrderList(uid);
	List<ProductDTO> productlist = dao.getProductList(orderlist);
	%>
</head>
<body>
<h1 style="padding-bottom: 50px; ">&nbsp;</h1>

<ul id="mypagelist">
  <li><a href="OrderProcessList.jsp"> 구입한 상품 </a></li>
  <li><a href="MyProductNow.jsp"> 나의 상품 판매 </a></li>
  <li><a href="MyWishList.jsp"> 찜 </a></li>
  <li><a href="MyReview.jsp"> 나의 후기 </a></li>
  <li><a href="AddMyMoney.jsp"> 잔액충전 </a></li>
  <li><a href="MyPageInfo.jsp"> 계정설정 </a></li>
  <li><a href="../help/inquiryList.jsp"> 나의 문의사항 </a></li>
  <li><a href="../help/Help.jsp"> 고객센터 </a></li>
</ul>
<div id="mypagebody" >
	<fieldset>
	<legend>구입한 상품</legend>
	<div>
	<table id="ordertable" >
		<tr id=bodylist >
	<%	if(orderlist != null){ %>
			<td> 날짜 </td><td colspan="2">상품정보</td>  <td>상태</td> <td>상세</td>
		</tr>
		<%	for(int i=0; i<productlist.size() ; i++){
				OrderListDTO order = orderlist.get(i);
				ProductDTO product = productlist.get(i); %>
				
			<tr>
				<td><%= sdf.format(order.getO_reg())  %></td>
				<td><a href="../selPage/ProductDetailBuyForm.jsp?p_no=<%= product.getP_no() %>"><img src="../save/<%= product.getP_img1() %>"></a></td>
				<td><a href="../selPage/ProductDetailBuyForm.jsp?p_no=<%= product.getP_no() %>"> <%= product.getP_title() %> </a> </td>
			<% 	switch(order.getO_pro()) {
					case 0: %>
						<td>주문확인</td> 
						<td>
							<a onclick="detail('OrderProInfo.jsp?ono=<%= order.getO_no() %>')"><button>상세보기</button></a> <br>
							<a> <button onclick="address('transAddress.jsp?ono=<%= order.getO_no() %>')">배송지 변경</button> </a> <br>
							<form action="../selPage/CancelPurchase.jsp" method="post">
								<input type="hidden" name="o_no" value="<%= order.getO_no()  %>">
								<input type="submit" value="취소하기">
							</form>
						</td>
					<%	break; 
					case 1: %>
						<td>배송중</td>
						<td> 
							<a onclick="detail('OrderProInfo.jsp?ono=<%= order.getO_no() %>')"><button>상세보기</button></a> <br>
						</td>
					<%	break; 
					case 2: %>
						<td>배송완료</td> 
						<td> 
							<a onclick="detail('OrderProInfo.jsp?ono=<%= order.getO_no() %>')"><button>상세보기</button></a> <br>
							<form action="../selPage/AddPayProductPro.jsp" method="post">
								<input type="hidden" value="<%= order.getO_no() %>" name="o_no">
								<input type="submit" value="주문확정">
							</form> 
							<form action="FinishFedex.jsp" method="post">
								<input type="hidden" value="<%= order.getO_no() %>" name="o_no">
								<input type="hidden" value="4" name="o_pro">
								<input type="submit" value="반품하기">
							</form>
						</td>
					<%	break;
					case 3: %>
						<td>거래완료</td> 
						<td> 
							<a onclick="detail('OrderProInfo.jsp?ono=<%= order.getO_no() %>')"><button>상세보기</button></a> <br>
						<% 	if(dao.writeReview(order.getP_no())<1){ %>
								<form name ="writeReview" id ="writeReview" action="/TJ_TeamProject1/teamProject/selPage/Review.jsp" target="writeReview" method="post">
									<input type="hidden" value="<%= order.getP_no() %>" name="p_no" />
									<input type="submit" value="리뷰작성" onClick="writeReview()">
								</form>
								<a onclick="detail('/TJ_TeamProject1/teamProject/selPage/Review.jsp?p_no=<%= order.getP_no()%>')"><button>리뷰작성</button></a> <br> 
						<%	}	%>
						</td>
					<%	break;
					case 4: %>
						<td>반품수거</td> 
						<td> 
							<a onclick="detail('OrderProInfo.jsp?ono=<%= order.getO_no() %>')"><button>상세보기</button></a> <br>
							<a> <button onclick="address('transAddress.jsp?ono=<%= order.getO_no() %>')">수거지 변경</button> </a>
						</td>
						
					<%	break; 
					case 5: %>
						<td>반송중</td> 
						<td> 
							<a onclick="detail('OrderProInfo.jsp?ono=<%= order.getO_no() %>')"><button>상세보기</button></a> <br> 
						</td>
					<%	break;
					case 6: %>
						<td>반송완료</td> 
						<td> 
							<a onclick="detail('OrderProInfo.jsp?ono=<%= order.getO_no() %>')"><button>상세보기</button></a> <br>
						</td>
					<%	break;
					case 7: %>
						<td>환불완료</td> 
						<td> 
							<a onclick="detail('OrderProInfo.jsp?ono=<%= order.getO_no() %>')"><button>상세보기</button></a> <br>
						</td>
					<%	break;
				} %>
				</tr>
		<%	}%>
	
	<%	}else{ %>
		<p> 구매한 상품이 없습니다. </p>	
	<%	}%>
	</table>
	</div>
	</fieldset>
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
			property += "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no";
		  	window.open("",form.target,property);
		}
</script>

<jsp:include page='../Footer.jsp'/>
</html>