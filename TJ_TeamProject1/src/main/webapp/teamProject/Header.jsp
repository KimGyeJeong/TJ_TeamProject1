<%@page import="team.project.dao.InstanceDAO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.model.CategoryDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>


<style type="text/css">
		header{
		
		
		}
		td{
			width: 150px;
			align:"center";
		}
		table{
			margin: auto;
			width: 80%;
		}
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
	

<%String id=(String)session.getAttribute("UID"); 
if((String)session.getAttribute("UID")!=null){%>
	<h3 align="right"> 사용자: <%=id %></h3>
<%}
System.out.println("id :"+id);

%>

<%if(session.getAttribute("UID") != null){%>
<input  type="button" value="로그아웃" onclick="window.location='/TJ_TeamProject1/teamProject/Login/Logout.jsp'" style="float: right;"/>
<input  type="button" value="mypage" onclick="window.location='/TJ_TeamProject1/teamProject/mypage/MyProductNow.jsp'" style="float: right;"/>
<input  type="button" value="알림" onclick="window.location='/TJ_TeamProject1/teamProject/Notification/notificationList.jsp'" style="float: right;"/>
<%}else{%>
<input  type="button" value="로그인" onclick="window.location='/TJ_TeamProject1/teamProject/Login/Login.jsp'" style="float: right;"/>	
<input  type="button" value="회원가입" onclick="window.location='/TJ_TeamProject1/teamProject/SignUp/Agecheck.jsp'" style="float: right;"/>	
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
	request.setCharacterEncoding("UTF-8");
	InstanceDAO dao = new InstanceDAO();
	
	
	List<CategoryDTO> category = dao.getCategory(); 

%>


	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		td{
			width: 150px;
			align:"center";
		}
		table{
			margin: auto;
			width: 80%;
		}
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
	
</div>
	<div align="center">
		<a href="/TJ_TeamProject1/teamProject/Main.jsp"><img alt="장물아비" src="/TJ_TeamProject1/teamProject/logo.png" width="250px"></a>
		<h1 style="display: inline-block;"></h1>
		<form action="/TJ_TeamProject1/teamProject/AllProductList.jsp" style="display: inline-block;">
			<select>
				<option value="content" selected>내용</option> 
				<option value="writer">작성자</option>
			</select>
			<input type="text" name="search" >
			<input type="image" name="submit" src="/TJ_TeamProject1/teamProject/mypage/image/logo.png" alt="검색" width="40px"  />
		</form>
		
		<button onclick="window.location.href='/TJ_TeamProject1/teamProject/selPage/ProductSellSelect.jsp'" style="width:70px;" >판매하기</button>

		<button onclick="window.location.href='/TJ_TeamProject1/teamProject/mypage/OrderProcessList.jsp'" style="width:60px;  " >내정보</button>
		<button onclick="window.location.href='/TJ_TeamProject1/teamProject/help/Help.jsp'" style="width:60px;  " >고객센터</button>

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
								<option value="/TJ_TeamProject1/teamProject/selPage/ProductList.jsp?ca_no=<%= dto.getCa_no() %>"><%= dto.getCa_name() %></option>
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





</body>
</html>