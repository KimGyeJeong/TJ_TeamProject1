<%@page import="team.project.model.AddressDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.model.OrderListDTO"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#wrapper{
	  height: auto;
	  min-height: 100%;
	  padding-bottom: 7.5%;
	}
	#choose {
		font-size : 20px;
		width : 100%;
		height : 7.5%;
		position : fixed;
		left: 0;
		bottom : 0;
		display: block;
	}
	#add {
		position : relative;
		bottom : 2px;
		left : 175px;
		font-size : 18px;
		width : 180px;
		height : 50px;
		display: inline;
	}
	#modify{
		position: relative;
		left: 15px;
		display: inline;
	}
	
</style>
<script type="text/javascript">
function addAddress() {
	let properties = "top=100 , left=600 , width=500, height=800, "; 
	properties += "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no";
	window.open("addAddress.jsp","배송지 추가하기",properties);
}
function getcomment(id) {
	let comm = document.getElementById(id).value;
	alert(comm);
	return comm;
}
</script>
<%
String ono = request.getParameter("ono");	
if(ono == null){ %>
	<script type="text/javascript">
		alert("우중한 접근");
		location.href='../Login/Login.jsp'
	</script>
<%}
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
uid = "qwe8246";
InstanceDAO dao = new InstanceDAO();
List<AddressDTO> address = dao.getaddressList(uid);
%>
<script type="text/javascript">
	function selectAno(){
		let getano = document.getElementsByName('check_a_no');
		for(var i=0; i<getano.length ; i++){
			if(getano[i].checked){
				window.document.getElementById('ano').value = getano[i].value;
				alert(window.document.getElementById('ano').value);
				break;
			}
		}
	}
	function selectComment(name) {
		let getcomment = document.getElementById(name);
		if(getcomment.value){
			document.getElementsByName(name).value = getcomment.value;
			alert(window.document.getElementsByName(name).value);
		}
	}
</script>
</head>

<body>
<div style="margin-top : 15px;">
<h1 style="margin-left : 25px ;  display: inline; ">배송지</h1>
<button id="add" onclick="addAddress()" >배송지 추가하기</button>
</div>
<h3>&nbsp;</h3>

		<form action="transAddressPro.jsp" id="addressform" method="get">
		<input type="hidden" value="" id="ano" name="ano">
		<input type="hidden" value="<%= ono %>" id="ono" name="ono"> 
		<% for(int j=0 ; j<address.size() ; j++) {
			  AddressDTO addressinput = address.get(j); %>
		<input type="hidden" value="<%= addressinput.getA_comment() %>" name="comment<%= addressinput.getA_no() %>">
		<% }%>
		</form>
	<% 	for(int i=0 ; i<address.size() ; i++) {
		  AddressDTO dto = address.get(i);  %>
		  	<fieldset>
			<input type="radio" name="check_a_no" value="<%= dto.getA_no() %>" onclick="selectAno()" <% if(i==0){%>checked="checked"<%} %>> 
			<p style="display: inline-block; width: 300px; margin: 8px; "><%= dto.getA_tag() %> </p>
			<div id="modify">
				<button onclick="AddressModify.jsp?a=<%= dto.getA_no() %>">수정</button>
				<button onclick="AddressDelete.jsp?a=<%= dto.getA_no() %>">삭제</button>
			</div> <br>
			<input type="text" value="<%= dto.getA_name() %>" readonly> <br>
			<input type="text" value="(<%= dto.getA_zipCode() %>)<%= dto.getA_address() %>" readonly> <br>
			<input type="text" value="<%= dto.getA_address2() %>" readonly> <br>
			
			<input type="text" id="comment<%= dto.getA_no() %>" value="<% if(dto.getA_comment()!=null){%><%= dto.getA_comment() %> <%} %>" onchange="selectComment('comment<%= dto.getA_no() %>')" placeholder="배송시 요청사항"> <br>
			</fieldset>
			
<% 	} %>

<div id="wrapper"> <div style="display: block; width: 100% ; height: 7.5%;"><button type="submit" form="addressform" id="choose" >선택하기</button></div></div>

</body>
</html>