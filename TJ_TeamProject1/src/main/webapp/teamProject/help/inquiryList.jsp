<%@page import="team.project.model.UserQuestionDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.LeeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../style.css" rel="stylesheet" type="text/css" />
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
	session.setAttribute("uri", "../help/inquiryList.jsp");
	response.sendRedirect("Login/LoginPro.jsp");
}
%>

<%request.setCharacterEncoding("UTF-8"); %>
<%  id=(String)session.getAttribute("u_id"); %>
	<h3 align="right"> 사용자: <%=id %></h3>
	
	<%if(session.getAttribute("u_id") == null || session.getAttribute("u_id") == "null" || session.getAttribute("u_id") ==""){%>
		<script>
  		alert("로그인 후 사용가능한 서비스입니다.");
  		history.go(-1);
  		</script>
		
    <%}else{%>
    	<input type="button" value="로그아웃" onclick="window.location='../Login/Logout.jsp'" style="float: right;"/>
  		
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
 	List inquiryList = null;
 	
 	String sel = request.getParameter("sel");
 	//제목 , 글 본문 내용으로 검색기능
 	String search = request.getParameter("search");
 	if(sel != null && search != null){//검색게시판
 		
 		if(count >0){
 			
 		}
 	}else{ //일반게시판 
 		count = dao.getInquiryListCount(id);
 		if(count >0){
 			inquiryList =dao.getInquiryList(startRow, endRow, id);
 		}
 	}
 	System.out.println("userquestion count : " + count);
	System.out.println(inquiryList);
	
	int number = count - (currentPage - 1) * pageSize;
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm"); 
	

 %>

</head>
<body>
<br/>

	
	
	<img  src="helpimg2.jpg" width='100'/>
	<h1>1:1문의내역 목록 <button onclick="window.location.href='http://localhost:8080/TJ_TeamProject1/teamProject/help/inquiry.jsp'">문의하기</button></h1>
	
	
	<br/>
	<% if(count == 0){ // 글이 없으면  %>
	<br/>
	<table>
		<tr>
			<td colspan="5">게시글이 없습니다.</td>
		</tr>
	</table>
	<%}else{ // 글이 하나라도 있으면 %>
	<br/>
		<table>
		<tr>
				<td>No.</td>
				<td>작성자</td>
				<td>제 목</td>
				<td>카테고리</td>
				<td>작성시간</td>
				<td>상담원 답변여부</td>
		</tr>
		<%
		for(int i=0; i < inquiryList.size(); i++){
			UserQuestionDTO dto = (UserQuestionDTO)inquiryList.get(i);
			String answer ="O";
			if(dto.getUqa_content()==null){ answer ="X";}%>
		<tr>
			<td><%=number-- %></td>
			<td> <%=dto.getUser_id() %> </td>
			<td><a href="InquiryContent.jsp?UQ_NO=<%=dto.getUq_no()%>&pageNum=<%=pageNum%>"><%=dto.getUq_title()%></a></td> 
			<td><%=dto.getUq_cat() %></td>
			<td><%=dto.getUq_reg() %></td>
			<td><%=answer%></td>
	   </tr>
	   
	   
	   
		<%} //페이징처리 수정해야함%>	
		
		</table>
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
				  <a class="pageNums" href="inquiryList.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
				<%}
				for(int l = startPage; l <= endPage; l++){ %>
				<a class="pageNums" href="inquiryList.jsp?pageNum=<%=l%>"> &nbsp; <%=l%> &nbsp; </a>
				<%}
			
				if(endPage < pageCount) { %>
					<a class="pageNums" href="inquiryList.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
				<%}
			}%>
			
		</div>
		

	<%}%>

	
</body>
</html>