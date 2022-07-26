<%@page import="team.project.model.UserListDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.model.BiddingDTO"%>
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
	Integer b_no = Integer.parseInt(request.getParameter("b_no"));
	Integer p_no = Integer.parseInt(request.getParameter("p_no"));
	if(UID != null && b_no != null && p_no != null){
	BeomSuDAO dao = new BeomSuDAO();
	dao.biddingStatusSet(p_no, b_no);
	int result = dao.confirmation(b_no);
	
	
%>
<body>
<%	if(result == 1){ 
		
		List bidList = dao.completionBidding(p_no, b_no);
		for(int i = 0; i<bidList.size(); i++){
			BiddingDTO bidDTO = (BiddingDTO)bidList.get(i);
			UserListDTO userDTO = dao.userCheck(bidDTO.getUser_id());
			dao.userMoneyReturn(userDTO.getUser_id(), bidDTO.getB_bidding());
		}
%>
		<script type="text/javascript">
			alert("낙찰을 완료했습니다!!");
			window.location.assign("../Main.jsp");
		</script>
<%	}else{ %>
		<script type="text/javascript">
			alert("에러!");
			window.location.assign("../Main.jsp");
		</script>
<%	} %>


<%}else{ %>
	<script>
		alert("잘못된 접근입니다!");
		window.location.assign("../Main.jsp");
	</script>
<%} %>
</body>
</html>