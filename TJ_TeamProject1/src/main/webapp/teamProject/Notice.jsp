<%@page import="team.project.model.NoticeDTO"%>
<%@page import="team.project.model.NotificationDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.LeeDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team.project.model.UserQuestionDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page='Header.jsp'/>
<jsp:include page='floatingAdvertisement.jsp'/>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../style.css" rel="stylesheet" type="text/css" />
<head>
<br />
<h1 align="center">공지사항</h1>

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


	<%if(session.getAttribute("UID") == null || session.getAttribute("UID") == "null" || session.getAttribute("UID") ==""){%>
		<script>
  		alert("로그인 후 사용가능한 서비스입니다.");
  		location.href="Main.jsp";
  		</script>

	<%}else{%>
	

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
 	count = dao.noticeCount();
  

 	
 	if(count >0){
 		NotificationList=dao.noticeList(startRow, endRow);
 		
 	} 
 
 	
 	System.out.println("notificationListCount  : " + count);
 
	
	int number = count - (currentPage - 1) * pageSize;

	
	
 	%>

</head>
<body>

<br />
<br />
<br />
	<div>
	
	<% if(count == 0){ // 글이 없으면  %>
	
		<table>
			<tr>
				<td colspan="5">게시글이 없습니다.</td>
			</tr>
		</table>
	
	<%}else{ // 글이 하나라도 있으면 %>
		<br />
	
		<div>
		<table>
			<tr>
				<td>no.</td>
				<td>제목</td>
				<td>공지내용</td>
				<td>분류</td>
				<td>공지시간</td>
				
			</tr>
			<% String notType =null;%>
			<%
			for(int i=0; i < NotificationList.size(); i++){
				NoticeDTO dto = (NoticeDTO)NotificationList.get(i);
				 
				
			%>
			<tr>
			
			<td><%=number--%></td>
			
			<td><%=dto.getNo_title() %></td>
				
			<td><%=dto.getNo_content()%></td> 
			
			<%--if문으로 이미 체크되어있으면 확인함  --%>
			
			<td><%=dto.getNo_cat()%></td>
			<td><%=dto.getNo_reg()%></td>
			
		
			</tr>
			
			


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
					<a class="pageNums" href="Notice.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
		<%}
				for(int l = startPage; l <= endPage; l++){ %>
		<a class="pageNums" href="Notice.jsp?pageNum=<%=l%>">
			&nbsp; <%=l%> &nbsp;
		</a>
		<%}
			
				if(endPage < pageCount) { %>
		<a class="pageNums"
			href="Notice.jsp?pageNum=<%=startPage+pageNumSize%>">
			&nbsp; &gt; </a>
		<%}
			}%>

	</div>


	<%}//else%>
	
	</div>
	
	
<br/>
<br/>
<br/>





<%@ include file="Footer.jsp" %>



</body>
</html>