<%@page import="team.project.dao.InstanceDAO"%>
<%@page import="team.project.model.AddressDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String uid = (String)session.getAttribute("UID");
	uid = "qwe8246";	//////////////////////////////////////////////////임시!
	String a_tag = request.getParameter("aTag");
	String a_name = request.getParameter("aname"); 
	String a_address = request.getParameter("address1");
	int a_zipcode = Integer.parseInt(request.getParameter("zipcode"));
	String a_address2 = request.getParameter("address2");
	String a_comment = request.getParameter("acomment");
	InstanceDAO dao = new InstanceDAO();
	AddressDTO address = new AddressDTO();
	address.setA_tag(a_tag);
	address.setA_name(a_name);
	address.setA_address(a_address);
	address.setA_zipCode(a_zipcode);
	address.setA_address2(a_address2);
	address.setA_comment(a_comment);
	address.setUser_id(uid);
	
	int result = dao.setAddress(address);
%>
<body>
<% if(result == 1){ %>
<script type="text/javascript">
opener.location.reload();
window.close();
</script>
<% } %>
</body>
</html>