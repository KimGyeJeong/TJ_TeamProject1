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
	String b_bid = request.getParameter("b_bidding");
	if(b_bid == null){
		b_bid = "0";
	}
	int b_bidding = Integer.parseInt(b_bid);
	BeomSuDAO dao = new BeomSuDAO();

	if(p_status == 1){
		dao.biddingInput(UID, b_bidding, p_no);
	}
%>
<body>

</body>
</html>