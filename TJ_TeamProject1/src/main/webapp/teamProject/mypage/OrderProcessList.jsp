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
	</style>
	
	<script type="text/javascript">
		function address(){
			let properties = "top=100 , left=600 , width=500, height=800, "; 
				properties += "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no";
				window.open("transAddress.jsp","address",properties);
		}
		function detail(uri){
			let properties = "top=100 , left=600 , width=1000, height=800, "; 
				properties += "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no";
			window.open(uri,"OrderProInfo",properties);
		}
	</script>
	
	
	<% 
	String uid = (String)session.getAttribute("UID");
	uid = "18"; 					//	임시!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   
	request.setCharacterEncoding("UTF-8");
	SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
	InstanceDAO dao = new InstanceDAO();
	List<CategoryDTO> category = dao.getCategory();  
	List<OrderListDTO> orderlist = dao.getOrderList(uid);
	List<ProductDTO> productlist = dao.getProductList(orderlist);
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
	<legend>구입한 상품</legend>
	<div>
	<table>
		<tr>
			<td> 날짜 </td><td colspan="2">상품정보</td>  <td>상태</td> <td>상세</td>
		</tr>
	<%	if(orderlist != null){ 
			for(int i=0; i<productlist.size() ; i++){
				OrderListDTO order = orderlist.get(i);
				ProductDTO product = productlist.get(i); %>
				
				<tr>
					<td><%= sdf.format(order.getO_reg())  %></td>
					<td><a href="../selPage/ProductDetailBuyForm.jsp?p_no=<%= product.getP_no() %>"><img src="<%= product.getP_img1() %>"></a></td>
					<td><a href="../selPage/ProductDetailBuyForm.jsp?p_no=<%= product.getP_no() %>"> <%= product.getP_title() %> </a> </td>
					<% 	switch(order.getO_pro()) {
							case 0: %>
								<td>주문확인</td> 
								<td>
									 
									<a onclick="detail('OrderProInfo.jsp?ono=<%= order.getO_no() %>')"><button>상세보기</button></a> <br>
									<a> <button onclick="address()">배송지 변경</button> </a> <br>
									
									<button>구입취소</button> 	<%-- 방치중!!!!!!!!!!!! --%>
									
									
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
									<a onclick="confirmation()"><button>주문확정</button></a>
								</td>
							<%	break;
							case 3: %>
								<td>주문확정</td> 
								<td> 
									<a onclick="detail('OrderProInfo.jsp?ono=<%= order.getO_no() %>')"><button>상세보기</button></a> <br> 
								</td>
							<%	break;
							case 4: %>
								<td>반품수거</td> 
								<td> 
									<a onclick="detail('OrderProInfo.jsp?ono=<%= order.getO_no() %>')"><button>상세보기</button></a> <br>
									<a> <button onclick="address()">배송지 변경</button> </a>
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
		<p> 저 그런 상품 아닙니다 </p>	
	<%	}%>
	</table>
	</div>
	</fieldset>
</div>

</body>
</html>