<%@page import="team.project.model.AddressDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team.project.model.BiddingDTO"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.model.OrderListDTO"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OrderProInfo.jsp</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<%
request.setCharacterEncoding("UTF-8");
String uid =(String)session.getAttribute("UID");
String ono = request.getParameter("ono");
InstanceDAO dao = new InstanceDAO();
OrderListDTO order = dao.getOrder(ono);
ProductDTO product = dao.getProduct(order.getP_no());
AddressDTO address = dao.getaddress(order.getA_no());
BiddingDTO bidding = null;

SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH시 mm분");
if(order.getP_status()==1){
	bidding = dao.getBidding(order.getP_no());
	System.out.println(bidding);
}
%>
<body>
<h1>주문 상세</h1>
주문번호 : <%= ono %> <br>
<div> <% if(order.getP_status()==1){ %><%= sdf.format(bidding.getB_reg()) %><%}else{%><%= sdf.format(order.getO_reg()) %><%} %>&nbsp;구입 </div>
결재금액 : <% if(order.getP_status()==1){ %><%= bidding.getB_bidding() %><%}else{%><%= product.getP_price() %><%} %> &nbsp;원
<br> <br>
<h3><%= address.getA_tag() %></h3>
<h4> 받는분 :&nbsp;<%= address.getA_name() %></h4>
(<%= address.getA_zipCode() %>)<%= address.getA_address()%>&nbsp;<%= address.getA_address2() %>
<div>배송시 요청사항 : &nbsp;<% if(address.getA_comment()!=null){ %> <%= address.getA_comment() %> <% } %> </div>
	<div>
		<p> <img src="../save/<%= product.getP_img1() %>"> </p>
		<p><%= product.getP_no() %> <a href=""> <%= product.getP_title() %></a></p>
		<% if(order.getP_status() == 1) {%>
		<p>  <%= product.getP_minPrice() %> ~ <%= product.getP_maxPrice() %></p>
		<% }else{ %>
		<p>  <%= product.getP_price() %></p>
		<% } %>
		<p> <%= sdf.format(product.getP_start()) %> ~ <%= sdf.format(product.getP_end()) %> </p>
	</div>
	<tr>
	<% 	switch(order.getO_pro()) {
			case 0: %>
				<td>주문확인</td> 
				<td>
					<a> <button onclick="address('transAddress.jsp?ono=<%= order.getO_no() %>')">배송지 변경</button> </a> <br>
					
					<button>구입취소</button> 	<%-- 방치중!!!!!!!!!!!! --%>
				</td>
			<%	break; 
			case 1: %>
				<td>배송중</td>
				<td> 
				</td>
			<%	break; 
			case 2: %>
				<td>배송완료</td> 
				<td> 
					<a onclick="confirmation()"><button>주문확정</button></a>
				</td>
			<%	break;
			case 3: %>
				<td>주문확정</td> 
				<td> 
					<script type="text/javascript">
					function confirmation(){
						let confirmValue = confirm("주문을 완료하시겠습니까?");
						console.log(confirmValue);
						if(confirmValue==true){ 
						<%	dao.updateOrderConfirmation(order.getO_no()); %>
						location.reload();
						}
					}
					</script>
				</td>
			<%	break;
			case 4: %>
				<td>반품수거</td> 
				<td> 
					<a> <button onclick="address('transAddress.jsp?ono=<%= order.getO_no() %>')">배송지 변경</button> </a>
				</td>
			<%	break; 
			case 5: %>
				<td>반송중</td> 
			<%	break;
			case 6: %>
				<td>반송완료</td> 
			<%	break;
			case 7: %>
				<td>환불완료</td> 
			<%	break;
		} %>
	</tr>
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
</script>
</body>
</html>