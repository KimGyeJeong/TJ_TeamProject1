<%@page import="team.project.dao.InstanceDAO"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.model.UserListDTO"%>
<%@page import="team.project.dao.BeomSuDAO"%>
<%@page import="team.project.model.OrderListDTO"%>
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
	int o_no = Integer.parseInt(request.getParameter("o_no"));
	BeomSuDAO dao = new BeomSuDAO();
	InstanceDAO instanceDao = new InstanceDAO();
	OrderListDTO orDTO = dao.orderListGet(o_no);
	if(UID.equals(orDTO.getO_buyerId())){
		if(orDTO.getO_pro() == 0){
			ProductDTO proDTO = dao.productDetailBuy(orDTO.getP_no());
			//구매취소? 유저 돈 추가..
			int result = dao.cancelPurchase(proDTO.getP_price(), UID);
			//물건 상태 p_finish 값 0으로 돌리기
			dao.productCancelPurchase(proDTO.getP_no());
			//주문 취소
			dao.deleteOrder(o_no);
			String message = proDTO.getP_title()+" 상품이 취소되었습니다.";
			instanceDao.insertNotification(orDTO.getO_sellerId(), "1", message);
			
%>
<body>
			<script type="text/javascript">
				alert("성공적으로 취소했습니다!");

				window.location.assign("/TJ_TeamProject1/teamProject/mypage/OrderProcessList.jsp");

			</script>
<%		}else{%>
			<script type="text/javascript">
				alert("배송이 시작된 상품은 취소할 수 없습니다!");

				window.location.assign("/TJ_TeamProject1/teamProject/mypage/OrderProcessList.jsp");


			</script>	
<% 		}		
	}else{ %>
		<script type="text/javascript">
			alert("권한이 없습니다!");
			//window.location.assign("../Main.jsp");
			//location.reload();
			window.location.assign("../mypage/OrderProcessList.jsp");
		</script>
<%	} %>
</body>
</html>