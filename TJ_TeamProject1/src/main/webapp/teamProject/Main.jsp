<%@page import="team.project.dao.LeeDAO"%>
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
<title>장물아비 메인페이지</title>
<link href="style.css" rel="stylesheet" type="text/css" />

<%String id=(String)session.getAttribute("UID"); 
if((String)session.getAttribute("UID")!=null){%>
	<h3 align="right"> 사용자: <%=id %></h3>
<%}
System.out.println("id :"+id);

%>


<%if(session.getAttribute("UID") != null){%>
<input  type="button" value="로그아웃" onclick="window.location='Login/Logout.jsp'" style="float: right;"/>
<input  type="button" value="mypage" onclick="window.location='mypage/MyProductNow.jsp'" style="float: right;"/>
<input  type="button" value="알림" onclick="window.location='Notification/notificationList.jsp'" style="float: right;"/>
<%}else{%>
<input  type="button" value="로그인" onclick="window.location='Login/Login.jsp'" style="float: right;"/>	
<%}%>
<%
String uid = null;


if(session.getAttribute("UID") == null){ // 로그인 안했을때 
	uid=(String)session.getAttribute("UID");
	// 쿠키가 있는지 검사 
	String cid = null, pw = null, auto = null; 
	Cookie[] coos = request.getCookies(); 
	if(coos != null){
		for(Cookie c : coos) {
			// 쿠키가 있다면 쿠키에 저장된 값꺼내 변수에 담기
			if(c.getName().equals("autoId")) cid = c.getValue();   
			if(c.getName().equals("autoPw")) pw = c.getValue();
			if(c.getName().equals("autoCh")) auto = c.getValue(); 
		}
		System.out.println("main쿠키확인 :"+cid+pw+auto);
	}

 
	
	// 세개 변수에 값이 들어있을 경우 (쿠키 제대로 생성되서 다 갖고 있다.)
	if(auto != null && cid != null && pw != null){
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
	
	
	
	//상품리스트,이미지 불러오기
	LeeDAO daoL = new LeeDAO();
	List recentProductList = daoL.recentProductList(); 
	List viewsProductList =daoL.viewsProductList();
	
	
	
	
	
	%>

								
	</div>
	<div align="center">
		<a href="Main.jsp"><img alt="장물아비" src="logo.png" width="250px"></a>
		<h1 style="display: inline-block;"></h1>
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


<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>

.mySlides {display:none}
.w3-left, .w3-right, .w3-badge {cursor:pointer}
.w3-badge {height:13px;width:13px;padding:0}
</style>
<body>

<!-- 151~198 까지 슬라이쇼 복붙맨 -->
<div class="w3-container">
</div>
 <div style = "padding: 5px 1px 2px 3px;"></div>

<div class="w3-content w3-display-container" style="max-width:800px; padding: 15px 30px 30px 30px;" >
  <a href="selPage/ProductList.jsp"><img class="mySlides" src="img_nature_wide.jpg" style="width:100%"></a>
  <a href="selPage/ProductList.jsp"><img class="mySlides" src="img_snow_wide.jpg" style="width:100%"></a>
  <a href="selPage/ProductList.jsp"><img class="mySlides" src="img_mountains_wide.jpg" style="width:100%"></a>
  <div class="w3-center w3-container w3-section w3-large w3-text-white w3-display-bottommiddle" style="width:100%">
    <div class="w3-left w3-hover-text-khaki" onclick="plusDivs(-1)">&#10094;</div>
    <div class="w3-right w3-hover-text-khaki" onclick="plusDivs(1)">&#10095;</div>
    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(1)"></span>
    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(2)"></span>
    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(3)"></span>
  </div>
</div>

<script>
<%--슬라이드쇼 자바스크립트부분--%>
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function currentDiv(n) {
  showDivs(slideIndex = n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("demo");
  if (n > x.length) {slideIndex = 1}
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" w3-white", "");
  }
  x[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " w3-white";
}
</script>

<div style = "padding: 20px 300px 20px 300px;"><!-- 상품리스트 시작 -->
<table border="1" >
	<tr>
		<td><h3>상품-조회수</h3></td></tr>
		<tr>
		<%
			for(int i=0; i < recentProductList.size(); i++){
					ProductDTO dto = (ProductDTO)viewsProductList.get(i);
			
			if(i%4==0){%>
				<tr>
			<%} %>
			<td><a href="selPage/ProductDetailBuyForm.jsp?p_no=<%=dto.getP_no()%>"><%=dto.getP_title()%> &nbsp; &nbsp; &nbsp; &nbsp; <%=dto.getP_img1()%></a></td>
		<%
			
		}%>	
</table>
<br/>
<br/>
<table border="1" >
	<tr>
		<td><h3>상품-최신순</h3></td></tr>
		<tr>
		<%
			for(int i=0; i < recentProductList.size(); i++){
					ProductDTO dto = (ProductDTO)recentProductList.get(i);
			
			if(i%4==0){%>
				<tr>
			<%} %>
			<td><a href="window.location='selPage/ProductDetailBuyForm.jsp?p_no=<%=dto.getP_no()%>'"><%=dto.getP_title()%> &nbsp; &nbsp; &nbsp; &nbsp; <%=dto.getP_img1()%></a></td>
		<%
			
		}%>
		
</table>	
</div><!-- 상품리스트 끝 -->









</body>

</html> 





</body>
</html>