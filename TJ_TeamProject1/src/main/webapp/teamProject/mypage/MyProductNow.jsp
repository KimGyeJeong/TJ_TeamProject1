<%@page import="team.project.dao.BeomSuDAO"%>
<%@page import="team.project.model.AddressDTO"%>
<%@page import="team.project.model.OrderListDTO"%>
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
	<link href="../teamstyle.css" rel="stylesheet" type="text/css" />
	<jsp:include page="../Header.jsp"></jsp:include>
	<jsp:include page='../floatingAdvertisement.jsp'/>
	<%
	request.setCharacterEncoding("UTF-8");
	String uid = (String)session.getAttribute("UID");
	
	
	InstanceDAO dao = new InstanceDAO();
	List<CategoryDTO> category = dao.getCategory(); 
	List<ProductDTO> sellerProduct = dao.getSellerProduct(uid);
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
	
	%>
</head>

<body>
<div class="mypageContent">
	<jsp:include page="MyPageCategory.jsp" />
	<div class="mypagebody" >
		<fieldset>
		<legend>나의 상품 판매</legend>
			<table class="ordertable">
			<% 	if(sellerProduct != null){ %>
				<tr class="bodylist">
					<div id="seller">
						<td style="width: 50%;">상품</td>
						<td>가격</td>
						<td>판매기간</td>
						<td colspan="2">상태</td> 
					</div>
				</tr>
				
				<%	int n=0;
					for(int i =0 ; i<sellerProduct.size() ; i++){
					ProductDTO product = sellerProduct.get(i); %>
					<tr>
					<div>
						<td> 
							<a href="../selPage/ProductDetailBuyForm.jsp?p_no=<%= product.getP_no() %>" style="float: left; line-height: 100px;">
								<%= product.getP_no() %>
							</a>  &nbsp;&nbsp;
							<img src="../save/<%= product.getP_img1() %>" style="width: 100px; height :100px; float: left;"> &nbsp;&nbsp;
							<a href="../selPage/ProductDetailBuyForm.jsp?p_no=<%= product.getP_no() %>" style="line-height: 100px;">
								<%= product.getP_title() %>	
							</a> 
						</td>
						<td>
							<% if(product.getP_status() == 1){ %>
								<p>  <%= product.getP_minPrice() %> ~ <%= product.getP_maxPrice() %></p>
							<% }else{ %>
								<p> <%= product.getP_price() %></p>
							<% } %>
						</td>
						<td>
						<p> <%= sdf.format(product.getP_start()) %> ~ <%= sdf.format(product.getP_end()) %> </p>
						</td>
						<td>
						<% int biddingHeadCount = dao.getBiddingNum(product.getP_no()); %>
						<% if(product.getP_status() == 1){ %> 
							<p>경매 : 
							<% if(biddingHeadCount==-1){ %>
								입찰완료
								</p>
							<% }else{ %>
								<%= biddingHeadCount %>
								</p>
							<% } %>
						<% } %>
						</td>
						<td>
					<%	if(product.getP_finish() == 0 ){
						
							if(biddingHeadCount == 0) {	%>
							
								<form action="ProductCancelPro.jsp" onSubmit="return deleteProductCheck()" method="post">
									<input type="hidden" name="p_no" value="<%= product.getP_no() %>">
									<input type="submit" value="등록취소">
								</form>
								<form action="../selPage/ProductModifyForm.jsp" method="post">
									<input type="hidden" name="p_no" value="<%= product.getP_no() %>">
									<input type="submit" value="수정하기">
								</form>
							<% } %>
							
							<% 	if(biddingHeadCount > 0){ %>
									<form action="../selPage/ProductBiddingconfirmation.jsp" method="post">
										<input type="hidden" name="p_no" value="<%= product.getP_no() %>">
										<input type="submit" value="입찰자 선택하기">
									</form>
							<% 	} %>
					<%	}else if(product.getP_finish() == 1){ %>
							<% OrderListDTO order = dao.getOrderList(product.getP_no(), product.getP_sellerId(), product.getP_buyerId()); %>
							<% AddressDTO address = dao.getaddress(order.getA_no()); %>
								<% 	if(order.getO_pro()==0){ %>
										택배 준비 
										<form name="Fedex" id="Fedex" action="setFedex.jsp" target="Fedex" method="post">
											<input type="hidden" value="<%= order.getO_no() %>" name="o_no" />
											<input type="hidden" value="<%= address.getA_no() %>" name="a_no" /> 
											<input type="submit" value="운송장 번호입력" onClick="setFedex()">
										</form>
								<% 	}else if(order.getO_pro()==1){ %>
										배송중
										<form action="FinishFedex.jsp">
											<input type="hidden" name="o_no" value="<%= order.getO_no() %>">
											<input type="hidden" name="o_pro" value="2">
											<input type="submit" value="배송완료">
										</form>
								<%	}else if(order.getO_pro()==2){ %>
										배송완료
								<%	}else if(order.getO_pro()==3){ %>
										거래완료
								<%	}else if(order.getO_pro()==4){ %>
										반품수거
								<%	}else if(order.getO_pro()==5){ %>
										반송중
								<%	}else if(order.getO_pro()==6){ %>
										반송완료
										<button type="button" onclick="cancel()" value="환불하기" />
										<% 	BeomSuDAO bsdao = new BeomSuDAO(); %>
										<script type="text/javascript">
										function cancel() {
										<%	if(order.getP_status()==1){
												//	경매 입찰
												int refund = bsdao.cancelPurchase(dao.getBidding(product.getP_no()).getB_bidding(), order.getO_buyerId());
												refund += dao.updateO_pro(order.getO_no(), 7); 
												if(refund == 2){
													String message = product.getP_title()+" 상품의 환불이 완료되었습니다.";
													dao.insertNotification(order.getO_buyerId(), "2", message);
												}
											}else{
												//	일반구매
												int refund = bsdao.cancelPurchase( product.getP_price() , order.getO_buyerId());
												refund += dao.updateO_pro(order.getO_no(), 7); 
												if(refund == 2){
													String message = product.getP_title()+" 상품의 환불이 완료되었습니다.";
													dao.insertNotification(order.getO_buyerId(), "2", message);
												}
											}	%>
										}
										</script>
								<%	}else if(order.getO_pro()==7){ %>
										환불완료
								<% 	} %>
								</td> 
							<tr>
							<% if( order.getO_pro()<=0 && order.getO_pro()<3 ) %>
							<td colspan="5" style="height: 30px !important">
							<details name="detail" style="width: 500px; text-align: left;">  
								<summary> <button type="button" onclick="modify(<%= n++ %>)" style="width: 120px;">배송지 정보</button></summary>
						  		<p> 
								받는분 : <%= address.getA_name() %> <br>
								주소 : (<%= address.getA_zipCode() %>)<%= address.getA_address() %> <br>
								상세 주소 : <%= address.getA_address2() %> <br>
								배송시 요청사항 : 
								<% 	if(address.getA_comment() != null){%><%= address.getA_comment() %><% } %> <br>
								
								<% 	if(order.getO_trackingNo() != 0){ %>
										택배사 : <%= order.getO_fedexName() %> <br>
										운송장번호 : <%= order.getO_trackingNo() %>
								<% 	} %>
						  		</p>
							</details>
					<%	}else if(product.getP_finish() == 2){ %>
							판매중지
					<%	}else if(product.getP_finish() == 3){ %>
							판매준비
					<%	} %>
						</td>
					</tr>
					</div>
				<%	}
				}else{ %>
					<h3>등록된 상품이 없습니다</h3>
					<h3> <button onclick="window.location='../selPage/ProductSellSelect.jsp'"> 등록하러가기</button> </h3>
			<% 	} %>
			</table>
		</fieldset>
	</div>
</div>
<script type="text/javascript">
function deleteProductCheck(){
	let confirmValue = confirm("등록된 상품을 취소하시겠습니까?");
	console.log(confirmValue);
	return confirmValue;
}
function modify(n) {
	if(document.getElementsByName("detail")[n].open===true){
		document.getElementsByName("detail")[n].open = false;
	}else{
		document.getElementsByName("detail")[n].open = true;
	}
}
function setFedex() {
	let properties = "top=100 , left=300 , width=500, height=800, "; 
	properties += "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no";
  	window.open("","Fedex",properties);
}

</script>
<jsp:include page="../Footer.jsp" />
</body>
</html>