<%@page import="team.project.model.BiddingDTO"%>
<%@page import="team.project.model.AddressDTO"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.BeomSuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String UID = (String)session.getAttribute("UID");
	int p_status = Integer.parseInt(request.getParameter("p_status"));
	int p_no = Integer.parseInt(request.getParameter("p_no"));
	String b_bid = request.getParameter("b_bidding");
	UID = "18";
	String a_n = request.getParameter("a_no");
	int a_no = 0;
	if(b_bid == null){
		b_bid = "0";
	}
	int b_bidding = Integer.parseInt(b_bid);
	ProductDTO proDTO = null;
	AddressDTO addDTO = null;
	
	BeomSuDAO dao = new BeomSuDAO();
	proDTO = dao.productDetailBuy(p_no);
	if(a_n == null){
		a_n = "0";
		addDTO = dao.addressCheck(UID);
	}else{
		a_no = Integer.parseInt(a_n);
		addDTO = dao.addressCheck(UID, a_no);
	}
%>
<body>
	<table>
		<tr>
			<td>주문결제</td>
			<td><button onclick="value">배송지 변경</button></td>
		</tr>
		<tr>
			<td>구매하시는 분 : <%=proDTO.getP_buyerId() %></td>
<%			if(a_n.equals("0")){ %>
				<td>받으시는 분 : <%=proDTO.getP_buyerId() %></td>
<%			}else{ %>
				<td>받으시는 분 : <%=addDTO.getA_name() %></td>
<%			} %>
		</tr>
		<tr>
			<td colspan="2">받는분 주소 : <%=addDTO.getA_zipCode() %>)&nbsp;<%=addDTO.getA_address() %>&nbsp;<%=addDTO.getA_address2() %></td>
		</tr>
		<tr>
			<td colspan="2"><textarea rows="2" cols="20">배송시 요청사항</textarea></td>
		</tr>
	</table>
	<form action="PayProductPro.jsp" method="post">
	<input type="hidden" name="p_no" value="<%=p_no %>" />
	<input type="hidden" name="p_status" value="<%=p_status %>" />
	<input type="hidden" name="a_no" value="<%=addDTO.getA_no() %>" />
		<table>
			<tr>
				<td>상품 제목 : <%=proDTO.getP_title() %></td>
			</tr>
			<tr>
				<td><%=proDTO.getP_img1() %></td>
			</tr>
			<tr>
<%			if(p_status == 1){ %>
				<td>희망 입찰가<br/>
				<input type="text" name="b_bidding" value="<%=b_bidding %>"></td>
			</tr>
			<tr>
				<td><input type="submit" value="입찰하기" /></td>
			</tr>
<%			}else{ %>
			<td>희망 구매가<br/>
				<input type="text" name="p_price" value="<%=proDTO.getP_price() %>" readonly></td>
			</tr>
			<tr>
				<td><input type="submit" value="구매하기" /></td>
			</tr>
<%			} %>
		</table>
	</form>
</body>
</html>