<%@page import="team.project.model.ContentDTO"%>
<%@page import="team.project.dao.LeeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
	<% String id=(String)session.getAttribute("UID"); %>
	<h3 align="right"> 사용자: <%=id %></h3>
</head>
<%
	int cno = Integer.parseInt(request.getParameter("cno")); 	
	System.out.println("FBmodify.cno:"+cno);
	String pageNum = request.getParameter("pageNum");
	
	LeeDAO dao = new LeeDAO();
	ContentDTO article = dao.getOneContent(cno);

%>


<body>
	<br /> 
	<h1 align="center"> 글 수정 폼 </h1>
	<form action="FBmodifyPro.jsp?pageNum=<%=pageNum%>" method="post" enctype="multipart/form-data">
		<input type="hidden" name="cno" value="<%=cno%>" />
		<table>
			<tr>
				<td>제  목</td>
				<td><%=article.getC_title()%></td>
			</tr>		
			<tr>
				<td>작성자</td>
				<td><%=article.getUser_id()%></td>
			</tr>		
			<tr>
				<td>내  용</td>
				<td><textarea rows="15" cols="50" name="content"><%=article.getC_content()%></textarea></td>
			</tr>		
			<tr>
				<td>이미지</td>
				<td>
					<img src="../save/<%=article.getC_img()%>" width="300px" /> <br /> 
					<input type="file" name="img" />
					<input type="hidden" name="exImg" value="<%=article.getC_img()%>" />
					<input type="hidden" name="id" value="<%=article.getUser_id()%>" />
					
				</td>
			</tr>
			
		
			<tr>
				<td colspan="2">
					<input type="submit" value="수정" />
					<input type="reset" value="재작성" />
					<input type="button" value="취소"  onclick="window.location='FBcontent.jsp?cno=<%=cno%>&pageNum=<%=pageNum%>'" />
				</td>
			</tr>
		</table>
	</form>


</body>
</html>