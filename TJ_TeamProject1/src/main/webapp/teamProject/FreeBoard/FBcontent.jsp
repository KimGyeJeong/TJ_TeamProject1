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

<h1 align="center">  </h1>
	<% String id=(String)session.getAttribute("UID"); 
		if(id==null){
			id="non-login";
		}
	%>
		
	
<jsp:include page='../Header.jsp'/>
<jsp:include page='../floatingAdvertisement.jsp'/>
<style>
#fox{
	display: block;
	margin-left: 25%;
	margin-top: 3%;
	
}

</style>
</head>
<%
	int cno = Integer.parseInt(request.getParameter("cno"));
	String pageNum = request.getParameter("pageNum");
	LeeDAO dao = new LeeDAO();
	ContentDTO dto = dao.getOneContent(cno);  
	dao.addReadcount(cno);
	String shouldNotnull = null;
	
	System.out.println("게시판pageNum:"+pageNum);
%>
<body>
<br/>
<div align="center" id="fox">
 <table>

 	<tr>
 		<td><h3>제목 </h3></td>
 		<td><h4>작성자 :<%=dto.getUser_id() %>  &nbsp;&nbsp; 조회수: <%=dto.getC_readcount()+1 %></h4></td>
 		
 	</tr>
 	<tr>
 		<td ><h4><%=dto.getC_title()%> </h4></td>
 		
 	</tr>
 	<tr>
 		<td></td>
 	</tr>
 	<tr>
 		<td><h3>내용</h3></td>
 	</tr>
 	<tr>
 		<td ><h4><%=dto.getC_content() %></h4></td>
 	</tr>
 	
 	
 	
 	<tr>
 		<td ><img src="../save/<%=dto.getC_img()%>" width="700px"> </td> 
 	</tr>		
 	
 	<%if(id.equals(dto.getUser_id())){ %>
 	<tr>
 		
 		<td><input type="button" value="수정" onclick='window.location="FBmodify.jsp?pageNum=<%=pageNum%>&cno=<%=cno%>"'></td>
 		<td><input type="button" value="삭제" onclick='window.location="FreeBoardDelete.jsp?pageNum=<%=pageNum%>&cno=<%=cno%>"'></td>
 	</tr>
	<% }%>
 </table>
 </div>

 
 <%
 System.out.println("이미지:"+dto.getC_img());
 %>
<br />
<br/> 
<jsp:include page='FBreplyForm.jsp'  />
 	
 





















<%@ include file="../Footer.jsp" %>
</body>
</html>
