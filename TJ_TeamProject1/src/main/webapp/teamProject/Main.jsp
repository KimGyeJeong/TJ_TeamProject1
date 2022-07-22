<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.model.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<%
String uid = null;


if(session.getAttribute("UID") == null){ // 로그인 안했을때 
	uid=(String)session.getAttribute("UID");
	// 쿠키가 있는지 검사 
	String id = null, pw = null, auto = null; 
	Cookie[] coos = request.getCookies(); 
	if(coos != null){
		for(Cookie c : coos) {
			// 쿠키가 있다면 쿠키에 저장된 값꺼내 변수에 담기
			if(c.getName().equals("autoId")) id = c.getValue();   
			if(c.getName().equals("autoPw")) pw = c.getValue();
			if(c.getName().equals("autoCh")) auto = c.getValue(); 
		}
		System.out.println("main쿠키확인 :"+id+pw+auto);
	}

 
	
	// 세개 변수에 값이 들어있을 경우 (쿠키 제대로 생성되서 다 갖고 있다.)
	if(auto != null && id != null && pw != null){
		// 로그인 처리되도록 loginPro.jsp 처리 페이지로 이동시키기 
		response.sendRedirect("loginPro.jsp");
	}
}



%>


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
			left: 50px;
			display:inline-block;
		}
		#seller p {
			display: inline;
		}
	</style>

	<%
	request.setCharacterEncoding("UTF-8");
	InstanceDAO dao = new InstanceDAO();
	List<CategoryDTO> category = dao.getCategory(); 
	List<ProductDTO> sellerProduct = dao.getSellerProduct(uid);
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
	
	%>
	<div style="display: block; margin: 10px 20% 10px;" align="right" >
		<a href="Login/Login.jsp"  width: 50px; height: 20px;" >로그인 </a> &nbsp;
		<a href="SignUp/SignUpForm.jsp"  width: 50px; height: 20px; " >회원가입 </a>&nbsp;
		<a href="Notification/notificationList.jsp" style="width:50px; height: 20px; " >알림</a>
								
	</div>
	<div align="center">
		<a href="Main.jsp"><img alt="장물아비" src="mypage/image/logo.png" width="30px"></a>
		<h1 style="display: inline-block;">장물아비</h1>
		<form action="../MainSearchPro.jsp" style="display: inline-block;">
			<input type="text" name="searchword" >
			<input type="image" name="submit" src="mypage/image/logo.png" alt="검색" width="40px"  />
		</form>
		
		<button onclick="window.location.href='selPage/ProductSellSelect.jsp'" style="width:70px;" >판매하기</button>
		<button onclick="window.location.href='http://localhost:8080/TJ_TeamProject1/teamProject/mypage/MyProductNow.jsp'" style="width:60px;  " >내정보</button>
		<button onclick="window.location.href=" style="width:60px;  " >게시판</button>
		<div style=" margin-right: 300px;">
	<form action="" name="ca">
		<select name = "cano" onchange="window.location.href=document.ca.cano.value" style="width: 150px;">
			<option>카테고리</option>
		<%	for(int i = 0; i<category.size() ; i++){
				CategoryDTO ca = category.get(i);
				if(ca.getCa_level()==0){ %>
					<optgroup label="<%= ca.getCa_name() %>"></optgroup>
				<%	for(int j = 0; j<category.size(); j++){
						CategoryDTO dto = category.get(j);
						if(dto.getCa_level()==1 && dto.getCa_grp()==ca.getCa_grp()){
							%>
								<option value="selPage/ProductList.jsp?ca_no=<%= dto.getCa_no() %>"><%= dto.getCa_name() %></option>
							<%
						}
					}
				}
			}
		%>
		</select>
	</form>
		</div>
	</div>
</head>





<body>
<h1>메인</h1>
<%String id=(String)session.getAttribute("UID"); 
System.out.println("id :"+id);
%>
<h3 align="right"> 사용자: <%=id %></h3>

<%if(session.getAttribute("UID") != null){%>
<input  type="button" value="로그아웃" onclick="window.location='Login/Logout.jsp'" style="float: right;"/>
<%}else{%>
	
<%}%>





</body>
</html>