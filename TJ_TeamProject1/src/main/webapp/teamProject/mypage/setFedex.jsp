<%@page import="team.project.model.UserListDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@page import="team.project.model.OrderListDTO"%>
<%@page import="team.project.model.AddressDTO"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>운송장번호 입력</title>
</head>
<body>

<%
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
String ono = request.getParameter("o_no");
String ano = request.getParameter("a_no");
%>
<jsp:include page="../UIDcheck.jsp"/>
<% 
if(ono==null || ano == null){ %>
	<script type="text/javascript">
	alert("잘못된 접근");
	window.close();
	</script>	<%
}
InstanceDAO dao = new InstanceDAO();
OrderListDTO order = dao.getOrder(ono);
AddressDTO address = dao.getaddress(Integer.parseInt(ano));
GyeJeongDAO gjdao = new GyeJeongDAO();
UserListDTO user = gjdao.getUserProfile(uid);
%>
<h1>보내실 주소</h1>
받는분 : <%= address.getA_name() %> <br>
주소 : (<%= address.getA_zipCode() %>)<%= address.getA_address() %> <br>
상세 주소 : <%= address.getA_address2() %> <br>
배송시 요청사항 : <% if(address.getA_comment() != null){%><%= address.getA_comment() %><% } %> <br>  
전화번호 : <%= user.getUser_phone() %> <br> <br>
<form action="setFedexPro.jsp" method="post">
	<h3>택배사</h3> 
	<input type="radio" name = "o_fedexName" value="한진택배" required/>한진택배
	<input type="radio" name = "o_fedexName" value="CJ대한통운">CJ대한통운
	<input type="radio" name = "o_fedexName" value="우체국택배">우체국택배
	<input type="radio" name = "o_fedexName" value="로젠택배">로젠택배
	<input type="radio" name = "o_fedexName" value="롯데택배">롯데택배
	<h3>운송장 번호</h3>
	<input type="text" name = "o_trackingNo" placeholder="운송장 번호" required>
	<input type="hidden" name="o_no" value="<%= order.getO_no() %>">
	<input type="submit" value="입력">
</form>
</body>
</html>