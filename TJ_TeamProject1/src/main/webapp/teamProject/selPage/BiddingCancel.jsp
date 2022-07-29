<%@page import="team.project.model.UserListDTO"%>
<%@page import="team.project.dao.BeomSuDAO"%>
<%@page import="team.project.model.BiddingDTO"%>
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
	int b_no = Integer.parseInt(request.getParameter("b_no"));
	BeomSuDAO dao = new BeomSuDAO();
	BiddingDTO bidDTO = dao.ConfirmationBidding(b_no);
	if(bidDTO != null){
		if(UID.equals(bidDTO.getUser_id())){
			int b_bidding = bidDTO.getB_bidding();
			int result = dao.biddingDelete(b_no);
				
		
%>
<body>
<%			if(result == 1){
				dao.userMoneyReturn(UID, b_bidding);
			}else{ %>
				<script type="text/javascript">
					alert("에?러");
					window.location.assign("../Main.jsp");
				</script>
<%			} %>
<%		}else{ %>
			<script type="text/javascript">
				alert("권한이 없습니다!");
				window.location.assign("../Main.jsp");
			</script>
<%		}
	}else{%>
		<script type="text/javascript">
			alert("잘못된 접근입니다!");
			window.location.assign("../Main.jsp");
		</script>
<%	} %>
</body>
</html>