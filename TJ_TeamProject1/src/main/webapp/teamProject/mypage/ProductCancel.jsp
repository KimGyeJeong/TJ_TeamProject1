<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@page import="team.project.dao.BeomSuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<% 
int pno = Integer.parseInt(request.getParameter("p_no"));
String ono = request.getParameter("o_no");
String o_buyerId = request.getParameter("o_buyerId");
String p_status = request.getParameter("p_status");
BeomSuDAO bsdao = new BeomSuDAO(); 
InstanceDAO dao = new InstanceDAO();
ProductDTO product = dao.getProduct(pno);
%>
</head>		
<body>
<%	if(p_status=="1"){
		//	경매 입찰
		int refund = bsdao.cancelPurchase(dao.getBidding(pno).getB_bidding(), o_buyerId);
		int sum = refund + dao.updateO_pro(Integer.parseInt(ono), 7); 
		if(sum == 2){
			String message = product.getP_title()+" 상품의 환불이 완료되었습니다.";
			dao.insertNotification(o_buyerId, "2", message);
			response.sendRedirect("MyProductNow.jsp");
		}
	}else{
		//	일반구매
		int refund = bsdao.cancelPurchase( product.getP_price() , o_buyerId);
		int sum = refund + dao.updateO_pro(Integer.parseInt(ono), 7); 
		if(sum == 2){
			String message = product.getP_title()+" 상품의 환불이 완료되었습니다.";
			dao.insertNotification(o_buyerId, "2", message);
			response.sendRedirect("MyProductNow.jsp");
		}
	}	%>
	

</body>
</html>
