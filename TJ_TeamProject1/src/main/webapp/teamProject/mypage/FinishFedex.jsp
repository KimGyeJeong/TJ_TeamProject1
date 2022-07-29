<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../UIDcheck.jsp" />
<%
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
String o_no = request.getParameter("o_no");
int result = -100;
	if(o_no != null){
		int ono= Integer.parseInt(o_no);
		InstanceDAO dao = new InstanceDAO();
		result = dao.updateO_pro(ono, 2);
	}else{ %>
	<script type="text/javascript">
		alert("잘못된 접근");
		history.go(-1);
	</script>
<% 	} %>
<% 
	if(result == 1){
		response.sendRedirect("MyProductNow.jsp");
		return;
 	} %>
 	
</body>
</html>