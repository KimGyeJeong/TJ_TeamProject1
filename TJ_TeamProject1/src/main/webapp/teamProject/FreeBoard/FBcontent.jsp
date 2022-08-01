<%@page import="team.project.model.ContentDTO"%>
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
<%String no =request.getParameter("c_no"); %>
<h1 align="center"> content </h1>
	<% String id=(String)session.getAttribute("UID"); %>
		<h3 align="right"> 사용자: <%=id %></h3>
	

</head>
<%
	int cno = Integer.parseInt(request.getParameter("c_no"));
	String pageNum = request.getParameter("pageNum");
	LeeDAO dao = new LeeDAO();
	ContentDTO dto = dao.getOneContent(cno);  
	String shouldNotnull = null;
	
	
%>
<body>
 <table>
 	<tr>
 		<td>제목 </td>
 		<td>작성자</td>
 		<td><%=dto.getUser_id() %></td>
 	</tr>
 	<tr>
 		<td><%=dto.getC_title()%> </td>
 		
 	</tr>
 	<tr>
 		<td>내용</td>
 	</tr>
 	<tr>
 		<td><textarea  width="500px" hight="300px" readonly="readonly"><%=dto.getC_content() %></textarea></td>
 	</tr>
 	<tr>
 		<td>이미지</td>
 	</tr>
 	<tr>
 		<td><img src="../save/<%=dto.getC_img()%>" width="500px"> </td> 
 	</tr>		
 	
 	

 </table>
 
 <%
 System.out.println("이미지:"+dto.getC_img());
 %>
 <br />
 

 	
 






















</body>
</html>