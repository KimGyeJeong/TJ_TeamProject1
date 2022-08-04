<%@page import="java.util.List"%>
<%@page import="team.project.model.CategoryDTO"%>
<%@page import="team.project.model.BiddingDTO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.model.UserListDTO"%>
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
	if(UID != null){
	int p_status = Integer.parseInt(request.getParameter("p_status"));
	int p_no = Integer.parseInt(request.getParameter("p_no"));
	String p_p = request.getParameter("p_price");
	if(p_p == null){
		p_p = "0";
	}
	int p_price = Integer.parseInt(p_p);
	
	String b_bid = request.getParameter("b_bidding");
	int a_no = Integer.parseInt(request.getParameter("ano"));
	if(b_bid == null){
		b_bid = "0";
	}
	UserListDTO userDTO = null;
	int b_bidding = Integer.parseInt(b_bid);
	BeomSuDAO dao = new BeomSuDAO();
	ProductDTO proDTO = dao.productDetailBuy(p_no);
	userDTO = dao.userCheck(UID);
	int result = 0;
	int result2 = 0;
	if((userDTO.getUser_usemoney() - p_price) > 0){
		result = 1;
		
	}else{
		result = -1;
		result2 = 1;
	}
	if(result2 == 0){
		if((userDTO.getUser_usemoney() - b_bidding) > 0){
			result = 1;	
		}else{
			result = -1;	
		}
	}
	int proResult = 0;
	BiddingDTO bidDTO = dao.biddingGet(p_no, UID);
	
%>
<body>
<%
	if(result == 1){
		if(p_status == 1){
		//p_status==1 입찰 거래
			if(bidDTO.getB_bidding() == 0){		//입찰가격이 없으면 (입찰비 : 0원)
				dao.userMoneydelete(UID, b_bidding);	//입찰금액 마이너스
				dao.biddingInput(UID, b_bidding, p_no);	//입찰테이블에 데이터 생성
				//biddingInput하면서 판매자에게 입찰알림 넣어주기
			}else{
				dao.userMoneydelete(UID, b_bidding);
				dao.biddingModify(UID, b_bidding, p_no);

			}
			%>
			<script>
				alert("입찰이 완료 되었습니다!");
				window.location.assign("ProductDetailBuyForm.jsp?p_no="+<%=p_no%>+"&ca_no="+<%=proDTO.getCa_no()%>);
			</script>
<%		}else{
		//p_status==0 일반 거래
				
			//주문리스트에 추가 0803 오더리스트에 들어가면서 알람설정해주기.
			dao.orderList(p_no, proDTO.getP_sellerId(), proDTO.getP_buyerId(), a_no, p_status);
			//물건이 팔려서 물건상태 바뀜
			dao.productBuy(p_no);
			List bidList = dao.completionBidding(p_no);
			dao.userMoneydelete(UID, p_price);
			
			if(bidList != null){
				dao.biddingStatusSet(p_no);
				for(int i = 0; i<bidList.size(); i++){
					bidDTO = (BiddingDTO)bidList.get(i);
					userDTO = dao.userCheck(bidDTO.getUser_id());
					dao.userMoneyReturn(userDTO.getUser_id(), bidDTO.getB_bidding());
				}
			}
%>
			<script>
				alert("구매가 완료 되었습니다!");
				window.location.assign("ProductDetailBuyForm.jsp?p_no="+<%=p_no%>+"&ca_no="+<%=proDTO.getCa_no()%>);
			</script>
<%		}
	}else if(result == -1){%>
		<script>
			
			var con_test = confirm("현재 충전된 잔액이 부족합니다! 충전하러 가시겠습니까?");
			if(con_test == true){
				window.location.assign("../mypage/AddMyMoney.jsp");	
			}else if(con_test == false){
				window.location.assign("ProductDetailBuyForm.jsp?p_no="+<%=p_no%>+"&ca_no="+<%=proDTO.getCa_no()%>);
			}
			
			
		</script>
<%	}else{%>
		<script>
			alert("에?러");
			window.location.assign("ProductDetailBuyForm.jsp?p_no="+<%=p_no%>+"&ca_no="+<%=proDTO.getCa_no()%>);
		</script>
<%	}
	}else{%>
	<script>
		alert("로그인 후 이용해 주세요!");
		window.location.assign("../Login/Login.jsp");
	</script>
<%	}
%>
</body>
</html>