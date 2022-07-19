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
	int b_bidding = Integer.parseInt(request.getParameter("b_bidding"));
	
	BeomSuDAO dao = new BeomSuDAO();
	int result = dao.productBuyerSet(p_no, UID);
%>
<body>

<%
		if(result == 1){%>
			<script>
				window.location="PayProduct.jsp?p_no=<%=p_no%>&p_status=<%=p_status%>&b_bidding=<%=b_bidding%>";
			</script>
<%		}else{ %>
			<script>
				alert("문제발생!!");
				window.location="ProductDetailBuyForm.jsp?p_no=<%=p_no%>";
			</script>
<%		} %>

</body>
</html>