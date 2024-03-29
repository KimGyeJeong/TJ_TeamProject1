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

SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
if(order.getP_status()==1){
	bidding = dao.getBidding(order.getP_no());
	System.out.println(bidding);
}
%>
<body>
<h1>주문 상세</h1>
주문번호 : <%= ono %> <br>
<div> <% if(order.getP_status()==1){ %><%= sdf.format(bidding.getB_reg()) %><%}else{%><%= sdf.format(order.getO_reg()) %><%} %>&nbsp;구입 </div>
결제금액 : <% if(order.getP_status()==1){ %><%= bidding.getB_bidding() %><%}else{%><%= product.getP_price() %><%} %> &nbsp;원
<br> <br>
<h3> 배송지명 : <%= address.getA_tag() %></h3>
<h4> 구매자 : <%= address.getUser_id() %></h4>
<h4> 받는분 :&nbsp;<%= address.getA_name() %></h4>
(<%= address.getA_zipCode() %>)<%= address.getA_address()%>&nbsp;<%= address.getA_address2() %>
<div>배송시 요청사항 : &nbsp;<% if(address.getA_comment()!=null){ %> <%= address.getA_comment() %> <% } %> </div>
	<div>
		<p> <img src="../save/<%= product.getP_img1() %>" width="300px"> </p>
		<p> 상품 번호 : <a href="../selPage/ProductDetailBuyForm.jsp?<%= order.getP_no() %>"><%= product.getP_no() %> </p>  
		<p> <%= product.getP_title() %></a></p>
		<% if(order.getP_status() == 1) {%>
		<p>  <%= dao.getBidding(order.getP_no()).getB_bidding() %></p>
		<% }else{ %>
		<p> 구입가격 : <%= product.getP_price() %> 원</p>
		<% } %>
		<p> 판매기간 :  <%= sdf.format(product.getP_start()) %> ~ <%= sdf.format(product.getP_end()) %> </p>
	</div>
	<tr> 상태 : 
	<% 	switch(order.getO_pro()) {
			case 0: %>
			<td>주문확인</td>  <br>
			<td>
				<a href="javascript:address('transAddress.jsp','<%= order.getO_no() %>')" ><button>배송지 변경</button> </a>
				<form action="../selPage/CancelPurchase.jsp" method="post">
					<input type="hidden" name="o_no" value="<%= order.getO_no()  %>">
					<input type="submit" value="취소하기">
				</form>
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
				<form action="../selPage/AddPayProductPro.jsp" method="post">
					<input type="hidden" value="<%= order.getO_no() %>" name="o_no">
					<input type="submit" value="거래완료">
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
		<%	break;
		case 4: %>
			<td>반품수거</td> 
			<td> 
				<a href="javascript:address('transAddress.jsp','<%= order.getO_no() %>')" ><button>수거지 변경</button> </a>
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
	function address(uri,o_no){
		let properties = "top=100 , left=600 , width=500, height=800, "; 
			properties += "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no";
			addr = window.open("","address",properties);
			
			let f = document.createElement('form');

			let no;
			no = document.createElement('input');
			no.setAttribute('type', 'hidden');
			no.setAttribute('name', 'o_no');
			no.setAttribute('value', o_no);

			f.appendChild(no);
			f.setAttribute('method', 'post');
			f.setAttribute('action', uri );
			f.target = 'address';
			document.body.appendChild(f);
			f.submit();
	}
</script>
</body>
</html>