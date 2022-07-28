<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.model.UserListDTO"%>
<%@page import="team.project.model.BiddingDTO"%>
<%@page import="java.util.List"%>
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
	int p_no = Integer.parseInt(request.getParameter("p_no"));
	BeomSuDAO dao = new BeomSuDAO();
	ProductDTO proDTO = dao.productDetailBuy(p_no);
	if(UID.equals(proDTO.getP_sellerId())){
		int result = dao.productDelete(p_no);
		List bidList = dao.completionBidding(p_no);
		if(bidList != null){
			dao.biddingStatusSet(p_no);
			for(int i = 0; i<bidList.size(); i++){
				BiddingDTO bidDTO = (BiddingDTO)bidList.get(i);
				UserListDTO userDTO = dao.userCheck(bidDTO.getUser_id());
				dao.userMoneyReturn(userDTO.getUser_id(), bidDTO.getB_bidding());
			}
		}
%>
<body>
<%		if(result == 1){ %>
			<script type="text/javascript">
				alert("게시글을 삭제했습니다!");
				window.location.assign("../Main.jsp");
			</script>
<%		}else{ %>
			<script type="text/javascript">
				alert("에?러");
				window.location.assign("../Main.jsp");
			</script>
<%		} %>
<%	}else{ %>
	<script type="text/javascript">
		alert("권한이 없습니다!");
		window.location.assign("../Main.jsp");
	</script>
<%	} %>
</body>
</html>