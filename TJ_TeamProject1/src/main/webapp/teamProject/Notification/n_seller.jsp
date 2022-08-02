<%@page import="team.project.model.NotificationDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.LeeDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team.project.model.UserQuestionDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<style>
#box{
	display: block;
	margin-left: 30%;
	margin-top: 3%;
	
}

</style>

<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../style.css" rel="stylesheet" type="text/css" />
<head>
<jsp:include page='../Header.jsp'/>
<jsp:include page='../floatingAdvertisement.jsp'/>

<br />
<h1 align="center">알림 페이지-판매자 알림</h1>
<table id='box'>
	<tr>
		<td><input type='button' name='seller' value="판매자알림" onclick="location.href='http://localhost:8080/TJ_TeamProject1/teamProject/Notification/n_seller.jsp'"></td>
		<td><input type='button' name='buyer' value="구매자알림" onclick="location.href='http://localhost:8080/TJ_TeamProject1/teamProject/Notification/n_buyer.jsp'"></td>
		<td><input type='button' name='warning' value="경고" onclick="location.href='http://localhost:8080/TJ_TeamProject1/teamProject/Notification/n_warning.jsp'"></td>
		<td><input type='button' name='all' value="전체보기" onclick="location.href='http://localhost:8080/TJ_TeamProject1/teamProject/Notification/notificationList.jsp'"></td>
	</tr>
</table>

<%
String id = null, pw = null, auto = null; 
Cookie[] coos = request.getCookies(); 
if(coos != null){
	for(Cookie c : coos) {
		
		if(c.getName().equals("autoId")) id = c.getValue();   
		if(c.getName().equals("autoPw")) pw = c.getValue();
		if(c.getName().equals("autoCh")) auto = c.getValue();
		System.out.println(id + pw + auto +"쿠키확인");
	}	
}
if(auto != null && id != null && pw != null){
	session.setAttribute("uri", "../notification/notificationList.jsp");
	response.sendRedirect("Login/LoginPro.jsp");
}
%>

<%request.setCharacterEncoding("UTF-8"); %>
<%  id=(String)session.getAttribute("UID"); %>
<h3 align="right">사용자:<%=id %></h3>

	<%if(session.getAttribute("UID") == null || session.getAttribute("UID") == "null" || session.getAttribute("UID") ==""){%>
		<script>
  		alert("로그인 후 사용가능한 서비스입니다.");
  		location.href="../Main.jsp";
  		</script>

	<%}else{%>
	<input type="button" value="로그아웃" onclick="window.location='../Login/Logout.jsp'" style="float: right;" />

	<%}%>

	<%
 	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){ 
		pageNum = "1";   
	}
	System.out.println("pageNum : " + pageNum);
	
	int pageSize = 5;   
	int currentPage = Integer.parseInt(pageNum);  
	int startRow = (currentPage - 1) * pageSize + 1; 
	int endRow = currentPage * pageSize; 
 	LeeDAO dao = new LeeDAO();
 	
 	int count=0;
 	List NotificationList = null; 	
 	count = dao.notificationListCount2(id);
 
 	
 	
 	
 	if(count >0){
 		NotificationList=dao.getNotificationList2(startRow, endRow, id);
 	}
 
 	
 	System.out.println("notificationListCount  : " + count);
 
	
	int number = count - (currentPage - 1) * pageSize;

	
	
 	%>

</head>
<body>
	
	<div>
	
	<% if(count == 0){ // 글이 없으면  %>
	
		<table>
			<tr>
				<td colspan="5">게시글이 없습니다.</td>
			</tr>
		</table>
	
	<%}else{ // 글이 하나라도 있으면 %>
		<br />
	
		<div id='box'>
		<table>
			<tr>
				<td>no.</td>
				<td>알림 타입 및 내용</td>
				<td>시간</td>
				<td>확인여부</td>
				<td colspan="2">읽음으로 체크 </td>
				
			</tr>
			<% String notType =null;%>
			<%
			for(int i=0; i < NotificationList.size(); i++){
				NotificationDTO dto = (NotificationDTO)NotificationList.get(i);
				 
				String readCheck ="X";			
				if(dto.getNot_ch()== 1){
					readCheck="O";
					}
			%>
			<tr>
			
			<td><%=number--%></td>
			
			<td><%	System.out.println(dto.getNot_type());
			if(dto.getNot_type().equals("1")){
				notType= "판매자알림";
			}else if(dto.getNot_type().equals("2")){
				notType= "구매자알림";
			}else if(dto.getNot_type().equals("3")){
				notType= "경고";
			} %>(<%=notType%>)<%=dto.getNot_message() %></td>
			<form action="notificationListPro.jsp" method="get" >	
			<td><%=dto.getNot_reg()%></td> 
			
			<%--if문으로 이미 체크되어있으면 확인함  --%>
			
			<td><%=readCheck%></td>
			
			<td><input type='checkbox' value='1' name="check"/></td>
			<td><input type='submit' value='확인' /></td>
			<td style='display:none'><input type='text' value='n_seller.jsp' name="where"></td>
			</tr>
			<input type='hidden' name='dto' value='<%=dto.getNot_no() %>'>
			</form>


		<%}//for //페이징처리 수정해야함%>
	</table>
	</div>
	
	<br />
	<div align="center">
		<%
			if(count >0){
				int pageCount = count/ pageSize +(count % pageSize == 0? 0:1);
				int pageNumSize = 3;
				int startPage = (int)((currentPage-1)/pageNumSize)*pageNumSize + 1; 
				int endPage = startPage + pageNumSize - 1;
				
				if(endPage > pageCount){ endPage = pageCount;}
				
				if(startPage > pageNumSize){%>
					<a class="pageNums" href="notificationList.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
		<%}
				for(int l = startPage; l <= endPage; l++){ %>
		<a class="pageNums" href="notificationList.jsp?pageNum=<%=l%>">
			&nbsp; <%=l%> &nbsp;
		</a>
		<%}
			
				if(endPage < pageCount) { %>
		<a class="pageNums"
			href="notificationList.jsp?pageNum=<%=startPage+pageNumSize%>">
			&nbsp; &gt; </a>
		<%}
			}%>

	</div>


	<%}//else%>
	
	</div>
	
<br/>
<br/>
<br/>	
	
<%@ include file="../Footer.jsp" %>	



</body>
</html>