<%@page import="team.project.dao.GyeJeongDAO"%>
<%@page import="team.project.model.UserListDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AddMyMoney</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

</head>
<body>
	<%
	//이 페이지는 로그인 한사람만 들어와야함.
	//1. 세션값or 쿠키값 확인
	//2. 로그인한 이력 없으면 로그인이 필요한 페이지입니다 alert 출력후 로그인창 이동

	request.setCharacterEncoding("UTF-8");

	String uid = (String) session.getAttribute("UID");

	//로그인하지 않으면 빈페이지 출력중.
	if (uid != null) {

		GyeJeongDAO dao = new GyeJeongDAO();
		UserListDTO dto = dao.getUserProfile(uid);
	%>

	<script type="text/javascript"
		src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script type="text/javascript"
		src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<h2><%=dto.getUser_id() %></h2>

	<div id="addMoney">
		<form action="AddMyMoneyPro.jsp" method="post">
			<table>
				<tr style="display: none">
					<td><input type="hidden" name="user_id" id="user_id"
						value="<%=dto.getUser_id()%>"></td>
				</tr>
				<tr>
					<td>돈 충전하기</td>
				</tr>
				<tr>
					<td>현재 잔액 : <%=dto.getUser_money() %></td>
				</tr>
				<tr>
					<td>현재 사용가능한 금액 : <%=dto.getUser_usemoney() %></td>
				</tr>
				<tr>
					<%-- 
					<td><input type="radio" name="money" id="money" value="5000">5000원
						<input type="radio" name="money" id="money" value="10000">10000원
						<input type="radio" name="money" id="money" value="30000">30000원
						<input type="radio" name="money" id="money" value="50000">50000원
					</td>--%>

					<td><select id="money" name="money">
							<option value="3000">3000원</option>
							<option value="5000">5000원</option>
							<option value="10000">10000원</option>
							<option value="30000">30000원</option>
							<option value="50000">50000원</option>
					</select></td>

				</tr>
				<tr>
					<td>
						<button id="iamportPayment" type="button">결제하기</button>
					</td>
				</tr>
				<tr>
					<td><input type="text" value="충전된금액" id="aftermoney"
						name="aftermoney"></td>
				</tr>
			</table>
		</form>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			$("#iamportPayment").click(function() {
				iamport();
			});
		})

		function iamport() {
			//가맹점 식별코드
			IMP.init('imp23568852');
			IMP.request_pay({
				pg : 'kcp',
				pay_method : 'card',
				merchant_uid : 'merchant_' + new Date().getTime(),
				name : '충전하기', //결제창에서 보여질 이름
			//	amount : document.getElementById("money").value, //실제 결제되는 가격
				amount : document.getElementById("money").value,
				buyer_email : '<%=dto.getUser_email()%>',
				buyer_name : '<%=dto.getUser_name()%>',
				buyer_tel : '<%=dto.getUser_phone()%>',
				buyer_addr : '서울 강남구 도곡동',
				buyer_postcode : '123-456'
			}, function(rsp) { //call back 함수. 고객이 결제를 완료했을때 실행
				console.log(rsp);
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
					msg += '고유ID : ' + rsp.imp_uid;
					msg += '상점 거래ID : ' + rsp.merchant_uid;
					msg += '결제 금액 : ' + rsp.paid_amount;
					msg += '카드 승인번호 : ' + rsp.apply_num;
					
					document.getElementById('aftermoney').value = rsp.paid_amount;
					//location.href="AddMyMoneyPro.jsp";
					sendData('AddMyMoneyPro.jsp', {user_id: '<%=dto.getUser_id()%>',
						aftermoney: document.getElementById('aftermoney').value});
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
				}
				alert(msg);
			});
		}
		
		function sendData(path, parameters, method='post') {

			  const form = document.createElement('form');
			  form.method = method;
			  form.action = path;
			  document.body.appendChild(form);

			  for (const key in parameters) {
			      const formField = document.createElement('input');
			      formField.type = 'hidden';
			      formField.name = key;
			      formField.value = parameters[key];

			      form.appendChild(formField);
			  }
			  form.submit();
			}

			
	</script>

	<%
	//if(uid!=null닫기)
	}else{
		%>
		<script type="text/javascript">
		alert("로그인이 필요한 페이지입니다.\n로그인 페이지로이동합니다.");
		location.href='../Login/Login.jsp';
		</script>
		<%
	}
	%>
</body>
</html>