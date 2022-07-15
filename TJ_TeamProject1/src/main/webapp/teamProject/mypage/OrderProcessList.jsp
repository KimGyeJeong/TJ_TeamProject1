<%@page import="team.project.model.OrderListDTO"%>
<%@page import="team.project.model.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../style.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		#mypagelist {
			list-style: none;
			display: inline-block;
		}
		#mypagelist li{
			margin: 20px;
			font-size: 18px;
		}
		#mypagebody{
			position: relative;
			bottom: 400px;
			left: 50px;
			display:inline-block;
		}
	</style>

<% 
	String uid = (String)session.getAttribute("UID");
	request.setCharacterEncoding("UTF-8");
	InstanceDAO dao = new InstanceDAO();
	List<CategoryDTO> category = dao.getCategory();  
	List<OrderListDTO> orderlist = dao.getOrderList(uid);
	%>
	<div style="display: block; margin: 10px 20% 10px;" align="right" >
		<a href="window.location.href='Login.jsp'" style="width:50px; height: 20px;" >로그인</a> &nbsp; 
		<a href="window.location.href=" style="width:50px; height: 20px; " >회원가입 </a>&nbsp;
		<a href="" style="width:50px; height: 20px; " >알림</a>
								
	</div>
	<div align="center">
		<a href="../Main.jsp"><img alt="장물아비" src="image/logo.png" width="50px"></a>
		<h1 style="display: inline-block;">장물아비</h1>
		<form action="../MainSearchPro.jsp" style="display: inline-block;">
			<input type="text" name="searchword">
			<input type="image" name="submit" src="image/logo.png" alt="검색" width="30px" height="30px" />
		</form>
		<button onclick="window.location.href='../ProductSellSelect.jsp'" style="width:45px; height: 40px;" >판매하기</button>
		<button onclick="window.location.href='http://localhost:8080/TJ_TeamProject1/teamProject/mypage/MyProductNow.jsp'" style="width:45px; height: 40px; font-size: 8.5px;" >내정보</button>
		<button onclick="window.location.href=" style="width:45px; height: 40px; font-size: 8.5px;" >게시판</button>
		<div style=" margin-right: 300px;">
		<select onchange="window.location.href='value'" style="width: 150px;">
			<option>카테고리</option>
		<%	for(int i = 0; i<category.size() ; i++){
				CategoryDTO ca = category.get(i);
				if(ca.getCa_level()==0){ %>
					<optgroup label="<%= ca.getCa_name() %>"></optgroup>
				<%	for(int j = 0; j<category.size(); j++){
						CategoryDTO dto = category.get(j);
						if(dto.getCa_level()==1 && dto.getCa_grp()==ca.getCa_grp()){
							%>
								<option value="<%= dto.getCa_no() %>"><%= dto.getCa_name() %></option>
							<%
						}
					}
				}
			}
		%>
		</select>
		</div>
	</div>
</head>
<body>
<h1 style="padding-bottom: 50px; ">&nbsp;</h1>

<ul id="mypagelist">
  <li><a href="OrderProcessList.jsp"> 구입한 상품 </a></li>
  <li><a href="MyProductNow.jsp"> 나의 판매중인 상품 </a></li>
  <li><a href="WishList.jsp"> 찜 </a></li>
  <li><a href="MyReview.jsp"> 나에 대한 후기 </a></li>
  <li><a href=""> 구매후기 등록 및 목록 </a></li>	//	위랑 겹치는거 같은데?
  <li><a href="AddMyMoney.jsp"> 잔액충전 </a></li>
  <li><a href="MyPageInfo.jsp"> 계정설정 </a></li>
  <li><a href=""> 나의 문의사항 </a></li>	//	고객센터에 있음
  <li><a href="MyHelp.jsp"> 고객센터 </a></li>
</ul>
<div id="mypagebody" >
	<fieldset>
	<legend>구입한 상품</legend>
	<div>
	<%	if(orderlist != null){ %>
			오더리스트 이미지가 없어! 상품테이블하고 주문내역이랑 엮어야함
	<%	}else{ %>
		<p> 최근 구입한 상품이 없습니다.</p>	
	<%	}%>
	</div>
	</fieldset>
</div>

</body>
</html>