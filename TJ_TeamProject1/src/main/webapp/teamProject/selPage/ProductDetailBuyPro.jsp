<%@page import="team.project.model.ProductDTO"%>
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
	BeomSuDAO dao = new BeomSuDAO();
	int p_status = Integer.parseInt(request.getParameter("p_status"));
	int p_no = Integer.parseInt(request.getParameter("p_no"));
	Integer b_bidding = 0;
	int result = 0;
	ProductDTO dto = null;
	dto = dao.productDetailBuy(p_no);
	
%>
<body>

<%
if(UID != null){
	if(p_status == 1){
		b_bidding = Integer.parseInt(request.getParameter("b_bidding"));
		if(!dto.getP_sellerId().equals(UID)){
			result = dao.productBiddingSet(p_no, UID);
		}else{%>
			<script>
				alert("본인이 등록한 상품은 입찰할 수 없습니다!");
				window.location.assign("ProductDetailBuyForm.jsp?p_no="+<%=p_no%>);
			</script>	
<%		}
		
	}else{
		if(!dto.getP_sellerId().equals(UID)){
			result = dao.productBuyerSet(p_no, UID);
		}else{%>
			<script>
				alert("본인이 등록한 상품은 구매할 수 없습니다!");
				window.location.assign("ProductDetailBuyForm.jsp?p_no="+<%=p_no%>);
			</script>	
<%		}
	}
	
		if(result == 1){
			if(p_status == 1){%>
			<script>
				window.location.assign("PayProduct.jsp?p_no="+<%=p_no%>+"&p_status="+<%=p_status%>+"&b_bidding="+<%=b_bidding%>);
			</script>
<%			}else{ %>
			<script>
				window.location.assign("PayProduct.jsp?p_no="+<%=p_no%>+"&p_status="+<%=p_status%>);
			</script>
<%			} %>
<%		}else{ %>
			<script>
				alert("문제발생!!");
				window.location.assign("ProductDetailBuyForm.jsp?p_no="+<%=p_no%>);
			</script>
<%		} 
	}else{%>
		<script>
			alert("로그인 후 이용해 주세요!");
			window.location.assign("../Login/Login.jsp");
		</script>
<%	} %>

</body>
</html>