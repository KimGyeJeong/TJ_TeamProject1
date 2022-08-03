<%@page import="team.project.model.AddressDTO"%>
<%@page import="team.project.model.ProductDTO"%>
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
	System.out.println(UID);
	Integer b_no = Integer.parseInt(request.getParameter("b_no"));
	Integer p_no = Integer.parseInt(request.getParameter("p_no"));
	if(UID != null && b_no != null && p_no != null){
	BeomSuDAO dao = new BeomSuDAO();
	
	//입찰차에서 낙찰자(구매할수있는 권한)로 바뀌는 곳. 여기서 구매자에게 알림 넣어주기
	int result = dao.confirmation(b_no);
	BiddingDTO bidDTO = dao.ConfirmationBidding(b_no);
	AddressDTO addDTO = dao.addressCheck(bidDTO.getUser_id());
	System.out.println(addDTO);
%>
<body>
<%	if(result == 1){ 
		
		List bidList = dao.completionBidding(p_no, b_no);
		
		//입찰자에서 유찰자(구매하지 못하는)로 바뀌는 곳. 여기서 구매자 알림 넣어주기
		dao.biddingStatusSet(p_no, b_no);
		//상품 테이블에 판매자 넣어주는곳... 여기서 입찰자 알림 넣어줘도..?
		dao.buyerSet(p_no, bidDTO.getUser_id());
		ProductDTO proDTO = dao.productDetailBuy(p_no);
		dao.orderList(p_no, proDTO.getP_sellerId(), proDTO.getP_buyerId(), addDTO.getA_no());
		if(bidList != null){
			for(int i = 0; i<bidList.size(); i++){
				bidDTO = (BiddingDTO)bidList.get(i);
				UserListDTO userDTO = dao.userCheck(bidDTO.getUser_id());
				dao.userMoneyReturn(userDTO.getUser_id(), bidDTO.getB_bidding());
			}
		}
		dao.productBuy(p_no, bidDTO.getUser_id());
		dao.endDateUpdate(p_no);
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
		window.close();
	</script>
<%} %>
</body>
</html>