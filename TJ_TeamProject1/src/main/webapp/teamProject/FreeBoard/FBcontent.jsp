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

<h1 align="center"> content </h1>
	<% String id=(String)session.getAttribute("UID"); %>
		<h3 align="right"> 사용자: <%=id %></h3>
	

</head>
<%
	int cno = Integer.parseInt(request.getParameter("cno"));
	String pageNum = request.getParameter("pageNum");
	LeeDAO dao = new LeeDAO();
	ContentDTO dto = dao.getOneContent(cno);  
	String shouldNotnull = null;
	
	System.out.println("게시판pageNum:"+pageNum);
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
 	
 	<%if(id.equals(dto.getUser_id())){ %>
 	<tr>
 		
 		<td><input type="button" value="수정" onclick='window.location="FBmodify.jsp?pageNum=<%=pageNum%>&cno=<%=cno%>"'></td>
 		<td><input type="button" value="삭제" onclick='window.location="FreeBoardDelete.jsp?pageNum=<%=pageNum%>&cno=<%=cno%>"'></td>
 	</tr>
	<% }%>
 </table>
 
 <table>
 	<tr>
 	
 	</tr>
 </table>
 
 <%
 System.out.println("이미지:"+dto.getC_img());
 %>
<br />
<br/> 
<jsp:include page='FBreplyForm.jsp'  />
 	
 






















</body>
</html>
