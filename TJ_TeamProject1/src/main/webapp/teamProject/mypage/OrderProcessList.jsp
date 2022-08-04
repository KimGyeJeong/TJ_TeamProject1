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
	<jsp:include page='../floatingAdvertisement.jsp'/>
	<jsp:include page='../Header.jsp'/>
	<link href="../teamstyle.css" rel="stylesheet" type="text/css" />
	
	
	 
	
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
	<div class="mypagebody" >
	<jsp:include page="MyPageCategory.jsp" />
	<div class="mypageContent">
		<fieldset style=" border-width: 2px; border-style: groove; border-color: rgb(192, 192, 192); border-image: initial;">
		<legend>최근 3개월간 구입한 상품</legend>
			<div>
				<table class="ordertable" >
					<tr class="bodylist" >
				<%	if(orderlist != null){ %>
						<td> 날짜 </td><td style="width:50%;">상품정보</td>  <td>상태</td> <td>상세</td>
					</tr>
					<%	for(int i=0; i<productlist.size() ; i++){
							OrderListDTO order = orderlist.get(i);
							ProductDTO product = productlist.get(i); %>
							
						<tr>
							<td><%= sdf.format(order.getO_reg())  %></td>
							<td style="text-align: left;"><a href="../selPage/ProductDetailBuyForm.jsp?p_no=<%= product.getP_no() %>"><img src="../save/<%= product.getP_img1() %>" width="100px" height="100px"></a>
							&nbsp;&nbsp;<a href="../selPage/ProductDetailBuyForm.jsp?p_no=<%= product.getP_no() %>"> <%= product.getP_title() %> </a> </td>
						<% 	switch(order.getO_pro()) {
								case 0: %>
									<td>주문확인</td> 
									<td>
										<a href="javascript:detail('OrderProInfo.jsp','<%= order.getO_no() %>')"><button>상세보기</button></a> <br>
										<a href="javascript:address('transAddress.jsp','<%= order.getO_no() %>')" ><button>배송지변경</button></a><br>
										<form action="../selPage/CancelPurㅊchase.jsp" method="post">
											<input type="hidden" name="o_no" value="<%= order.getO_no()  %>">
											<input type="submit" value="취소하기">
										</form>
									</td>
								<%	break; 
								case 1: %>
									<td>배송중</td>
									<td>
										<a href="javascript:detail('OrderProInfo.jsp','<%= order.getO_no() %>')"><button>상세보기</button></a> <br>
									</td>
								<%	break; 
								case 2: %>
									<td>배송완료</td> 
									<td>
										<a href="javascript:detail('OrderProInfo.jsp','<%= order.getO_no() %>')"><button>상세보기</button></a> <br>
										<form action="../selPage/AddPayProductPro.jsp" method="post" onsubmit="return confirm('주문확정 하시겠습니까?');">
											<input type="hidden" value="<%= order.getO_no() %>" name="o_no">
											<input type="submit" value="주문확정"/>
										</form> 
										<form action="FinishFedex.jsp" method="post" onsubmit="return confirm('반품 하시겠습니까?');">
											<input type="hidden" value="<%= order.getO_no() %>" name="o_no" id="returnteakbae">
											<input type="hidden" value="4" name="o_pro">
											<input type="submit" value="반품하기">
										</form>
									</td>
								<%	break;
								case 3: %>
									<td>거래완료</td> 
									<td> 
										<a href="javascript:detail('OrderProInfo.jsp','<%= order.getO_no() %>')"><button>상세보기</button></a> <br>
									<% 	if(dao.writeReview(order.getP_no())<1){ 
											if(dao.getReviewCheck(uid,product.getP_no())==0){ %>
												<a href="javascript:writeReview('../selPage/Review.jsp','<%= order.getP_no() %>')" ><button>리뷰작성</button></a>
										<%	}
										}	%>
									</td>
								<%	break;
								case 4: %>
									<td>반송준비</td> 
									<td> 
										<a href="javascript:detail('OrderProInfo.jsp','<%= order.getO_no() %>')"><button>상세보기</button></a> <br>
										<a href="javascript:address('transAddress.jsp','<%= order.getO_no() %>')" ><button>수거지 변경</button> </a> <br>
										<form action="FinishFedex.jsp">
											<input type="hidden" name="o_no" value="<%= order.getO_no() %>">
											<input type="hidden" name="o_pro" value="5">
											<input type="submit" value="반송완료">
										</form>
									</td>
								<%	break; 
								case 5: %>
									<td>반송중</td> 
									<td> 
										<a href="javascript:detail('OrderProInfo.jsp','<%= order.getO_no() %>')"><button>상세보기</button></a> <br>
										<form action="FinishFedex.jsp">
											<input type="hidden" name="o_no" value="<%= order.getO_no() %>">
											<input type="hidden" name="o_pro" value="6">
											<input type="submit" value="배송완료">
										</form>
									</td>
								<%	break;
								case 6: %>
									<td>반송완료</td> 
									<td> 
										<a href="javascript:detail('OrderProInfo.jsp','<%= order.getO_no() %>')"><button>상세보기</button></a> <br>
									</td>
								<%	break;
								case 7: %>
									<td>환불완료</td> 
									<td> 
										<a href="javascript:detail('OrderProInfo.jsp','<%= order.getO_no() %>')"><button>상세보기</button></a> <br>
									</td>
								<%	break;
							} %>
							</tr>
					<%	}%>
				
				<%	}else{ %>
					<p> 구매한 상품이 없습니다. </p>	
				<%	} %>
				</table>
			</div>
		</fieldset>
	</div>
	</div>
</body>

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
		function detail(uri, ono){
			let properties = "top=100 , left=600 , width=1000, height=800, "; 
				properties += "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no";
			window.open("","OrderProInfo",properties);
			
			let f = document.createElement('form');

			let no;
			no = document.createElement('input');
			no.setAttribute('type', 'hidden');
			no.setAttribute('name', 'ono');
			no.setAttribute('value', ono);

			f.appendChild(no);
			f.setAttribute('method', 'post');
			f.setAttribute('action', uri );
			f.target = 'OrderProInfo';
			document.body.appendChild(f);
			f.submit();
		}
		function writeReview(uri , p_no) {
			
			let property = "top=100 , left=600 , width=1000, height=600, "; 
			property += "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no";
			addr = window.open("","reviewPop",property);
			
			let f = document.createElement('form');

			let no;
			no = document.createElement('input');
			no.setAttribute('type', 'hidden');
			no.setAttribute('name', 'p_no');
			no.setAttribute('value', p_no);

			f.appendChild(no);
			f.setAttribute('method', 'post');
			f.setAttribute('action', uri );
			f.target = 'reviewPop';
			document.body.appendChild(f);
			f.submit();
		}
</script>

<jsp:include page='../Footer.jsp'/>
</html>