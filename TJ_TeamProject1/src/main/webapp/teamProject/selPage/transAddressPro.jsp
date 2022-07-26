<%@page import="team.project.dao.BeomSuDAO"%>
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
<title>Insert title here</title>
</head>
<% 
request.setCharacterEncoding("UTF-8");
String uid= (String)session.getAttribute("UID");
int result = -100;
int p_status = Integer.parseInt(request.getParameter("p_status"));
int p_no = Integer.parseInt(request.getParameter("p_no"));
String b_bid = request.getParameter("b_bidding");
if(b_bid == null){
	b_bid = "0";
}
int b_bidding = Integer.parseInt(b_bid);
String ano = request.getParameter("ano");
InstanceDAO dao = new InstanceDAO();
BeomSuDAO bsDAO = new BeomSuDAO();
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
result= bsDAO.setAddressNum(ano);


%>
<body>
<div id="ano" value="<%=ano %>" style="display:none"/>
<% if(result == 1){ %>
<script type="text/javascript">
opener.parent.location='PayProduct.jsp?p_no=<%=p_no %>&p_status=<%=p_status %>&b_bidding=<%=b_bidding %>&a_no=<%=ano%>';
window.opener.alert("배송지가 변경되었습니다.");
window.close();
</script>
<% } %>
</body>
</html>