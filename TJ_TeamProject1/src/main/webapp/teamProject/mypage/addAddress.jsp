<%@page import="team.project.model.AddressDTO"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<% 
String ano = request.getParameter("modifyAno");
InstanceDAO dao = new InstanceDAO();
AddressDTO address = dao.getaddress(Integer.parseInt(ano));
%>
<body>
<h1>배송지 추가하기</h1>
<form action="addAddressPro.jsp" method="post">
<% 	if(ano!=null){ %>
<input type="hidden" value="<%= ano %>" name="ano">
<%	} %>
배송지명
<input type="text" name="aTag" value=<%if(ano!=null){%>"<%=address.getA_tag()%>"<%}%>> <br>
받으시는분
<input type="text" name="aname" value=<%if(ano!=null){%>"<%=address.getA_name()%>"<%}%>> <br>
주소
<input type="text" name="address1" id="address" value=<%if(ano!=null){%>"<%=address.getA_address()%>"<%}%>> 
<input type="text" name="zipcode" id="zipcode" value=<%if(ano!=null){%>"<%=address.getA_zipCode()%>"<%}%>>  
<input type="button" onclick="seachzipcode()" value="주소찾기"><br>
상세주소<input type="text" name="address2" value=<%if(ano!=null){%>"<%=address.getA_address2()%>"<%}%>> <br>
배송시 요청사항
<input type="text" name="acomment" value=<%if(ano!=null){%>"<%=address.getA_comment()%>"<%}%>> <br>
<input type="submit" value=<%if(ano!=null){ %>"수정하기"<%}else{%>"추가하기"<%}%> > <input type="reset" value="리셋"> 
<button type="button" onclick="window.close()" >취소</button>
</form>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
        function seachzipcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    document.querySelector("#zipcode").value = data.zonecode;
                    document.querySelector("#address").value = data.address;
                }
            }).open();
        }
	</script>
</body>
</html>