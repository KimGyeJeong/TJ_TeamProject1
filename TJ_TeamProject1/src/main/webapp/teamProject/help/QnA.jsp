<%@page import="team.project.model.QnADTO"%>
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
<jsp:include page='../Header.jsp'/>
<jsp:include page='../floatingAdvertisement.jsp'/>
<meta charset="UTF-8">
<title>장물아비 QnA</title>
<link href="../style.css" rel="stylesheet" type="text/css" />
<style>
#box{
	display: block;
	margin-left: 30%;
	margin-top: 3%;
	
}
#box2{
	display: block;
	margin-left: 35%;
	margin-top: 3%;
	
}
</style>
<head>
<br />
<h1 align="center">QnA 자주하는 질문</h1>

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
 	count = dao.qnaCount();
  
 	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
 	
 	if(count >0){ 
 		NotificationList=dao.qnaList(startRow, endRow);
 		
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
	
	
		<div id='box2'>
		<table>
			<tr>
				<td>no.</td>
				<td>자주하는질문</td>
				<td>질문내용</td>
				<td>답변내용</td>
				
				
			</tr>
			<% String notType =null;%>
			<%
			for(int i=0; i < NotificationList.size(); i++){
				QnADTO dto = (QnADTO)NotificationList.get(i);
		
				
			%>
			<tr>
			
			<td><%=number--%></td>
			
			<td><%=dto.getQ_title() %></td>
				
			<td><%=dto.getQ_questionContent()%></td> 
			
			<td><%=dto.getQ_answerContent()%></td> 
			
			
			 
		
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





<%@ include file="../Footer.jsp" %>



</body>
</html>