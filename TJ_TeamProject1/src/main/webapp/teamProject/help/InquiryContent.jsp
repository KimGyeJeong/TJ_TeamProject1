<%@page import="team.project.model.UserQuestionDTO"%>
<%@page import="team.project.dao.LeeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../style.css" rel="stylesheet" type="text/css" />
<br/>
<h1 align="center"> 문의-상세페이지</h1>
	<% String id=(String)session.getAttribute("u_id"); %>
		<h3 align="right"> 사용자: <%=id %></h3>
	
	<%if(session.getAttribute("u_id") != null){%>
		<input  type="button" value="로그아웃" onclick="window.location='../Login/Logout.jsp'" style="float: right;"/>
    <%}else{%>
  		<script>
  			alert("로그인 후 사용가능한 서비스입니다.");
  			history.go(-1);
  		</script>
    <%}%>

</head>
<%
	int uq_no = Integer.parseInt(request.getParameter("UQ_NO")); 
	String pageNum = request.getParameter("pageNum");
	LeeDAO dao = new LeeDAO();
	UserQuestionDTO dto = dao.getContent(uq_no); 
	
	
%>
<body>
 <table>
 	<tr>
 		<td>문의 제목 </td>
 	</tr>
 	<tr>
 		<td><%=dto.getUq_title()%> </td>
 	</tr>
 	<tr>
 		<td>문의 내용 </td>
 	</tr>
 	<tr>
 		<td><%=dto.getUq_content() %> </td>
 		
 	</tr>

 </table>
 
 
 <br />
 
<table>
 
 	
 	<tr>
 		<td >관리자 답변 </td>
 	</tr>
 	<tr>
 		<td><%=dto.getUqa_content() %> </td>
 	</tr>

 </table>























</body>
</html>