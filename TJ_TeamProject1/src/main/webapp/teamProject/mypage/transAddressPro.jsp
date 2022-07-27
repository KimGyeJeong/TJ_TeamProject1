<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="team.project.model.AddressDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<jsp:include page="../UIDcheck.jsp"></jsp:include>
</head>
<% 
request.setCharacterEncoding("UTF-8");
String uid= (String)session.getAttribute("UID");
uid = "qwe8246";
int result = -100;
String ano = request.getParameter("ano");
String ono = request.getParameter("ono");
InstanceDAO dao = new InstanceDAO();
List<AddressDTO> addresslist = dao.getaddressList(uid);
Integer [] anolist = new Integer[addresslist.size()];
for(int i = 0 ; i<addresslist.size();i++){
	anolist[i] = addresslist.get(i).getA_no();
}
Map<Integer,String> commentlist = new HashMap<Integer,String>();
for(int i=0 ; i<addresslist.size() ; i++){
	String commentNum = ""+addresslist.get(i).getA_no();
	String comment = request.getParameter(commentNum).trim();
	commentlist.put(anolist[i], comment);
}
dao.setAddressAllComment(anolist,commentlist);
if(ono == null || ono.equals("") || ono.equals("null")){ %>
<script type="text/javascript">
window.close();
</script>
<% }else{
result= dao.setAddressNum(ano,ono);
}


%>
<body>
<% if(result == 2){ %>
<script type="text/javascript">
window.opener.alert("배송지가 변경되었습니다.");
window.close();
</script>
<% } %>
</body>
</html>