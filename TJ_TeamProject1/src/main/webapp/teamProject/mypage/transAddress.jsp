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
<title>배송지 선택</title>
<jsp:include page="../UIDcheck.jsp"></jsp:include>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
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
		left: -20px;
		display: inline;
	}
	`
</style>
<script type="text/javascript">
function addAddress(uri) {
	let properties = "top=100 , left=600 , width=800, height=600, "; 
	properties += "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no";
	window.open(uri,"배송지 추가하기",properties);
}
</script>
<%
String ono = request.getParameter("ono");	
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
InstanceDAO dao = new InstanceDAO();
List<AddressDTO> address = dao.getaddressList(uid);
%>

</head>

<body>
<div style="margin-top : 15px;">
<h1 style="margin-left : 25px ;  display: inline; ">배송지</h1>
<button id="add" onclick="addAddress('addAddress.jsp')" >배송지 추가하기</button>
</div>
<h3>&nbsp;</h3>
	<form action="transAddressPro.jsp" id="addressform" method="post">
	<input type="hidden" value="<%= ono %>" id="ono" name="ono"> 
<% 	for(int i=0 ; i<address.size() ; i++) {
		AddressDTO dto = address.get(i);  %>
	  	<fieldset>
		<input type="radio" name="ano" value="<%= dto.getA_no() %>" onclick="selectAno()" <% if(i==0){%>checked="checked"<%} %>> 
		<p style="display: inline-block; width: 300px; margin: 8px; "><%= dto.getA_tag() %> </p>
		<div id="modify">
			<button type="button" onclick="addAddress('addAddress.jsp?modifyAno=<%= dto.getA_no() %>')">수정</button>
			<button type="button" onclick="confirmation('<%= dto.getA_tag() %>','<%= dto.getA_no() %>')">삭제</button>
			<script type="text/javascript">
			
			</script>
			
		</div> <br>
		<input type="text" value="<%= dto.getA_name() %>" readonly> <br>
		<input type="text" value="(<%= dto.getA_zipCode() %>)<%= dto.getA_address() %>" readonly> <br>
		<input type="text" value="<%= dto.getA_address2() %>" readonly> <br>
		
		<input type="text" name="<%= dto.getA_no() %>" value="<% if(dto.getA_comment()!=null){%><%= dto.getA_comment() %> <%} %>" placeholder="배송시 요청사항"> <br>
		</fieldset>
		<br>
<% 	} %>
	</form>
<div id="wrapper"> <div style="display: block; width: 100% ; height: 7.5%;">
	<button type="submit" form="addressform" id="choose" >선택하기</button>
</div></div>

</body>
<script type="text/javascript">
	function selectAno(){
		let getano = document.getElementsByName('ano');
		for(var i=0; i<getano.length ; i++){
			if(getano[i].checked){
				opener.document.getElementById('ano').value = getano[i].value;
				alert(opener.document.getElementById('ano').value);
				break;
			}
		}
	}
function confirmation(tag,ano){
	let confirmValue = confirm(tag+" 를 삭제하시겠습니까?");
	console.log(confirmValue);
	if(confirmValue==true){ 
	window.location="addAddressPro.jsp?deleteAno="+ano;
	}
}
</script>
</html>