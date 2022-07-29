<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<jsp:include page="../UIDcheck.jsp"/>

</head>
<%
request.setCharacterEncoding("UTF-8");
String fedexName = request.getParameter("o_fedexName");
String trackingNo = request.getParameter("o_trackingNo");
String ono = request.getParameter("o_no");
InstanceDAO dao = new InstanceDAO();
int result = dao.setFedex(fedexName, trackingNo , ono);


%>
<%= trackingNo %>
<body>
<%
	if(result == 1){ %>
		<script type="text/javascript">
			alert("배송시작");
			opener.location.reload();
			window.close();
		</script>
<%	}
%>
</body>
</html>