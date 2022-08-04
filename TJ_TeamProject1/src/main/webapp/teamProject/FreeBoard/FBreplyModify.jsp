<%@page import="team.project.model.ReplyDTO"%>
<%@page import="team.project.dao.LeeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>reply modify form</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%
	int rno = Integer.parseInt(request.getParameter("rno"));
	int cno = Integer.parseInt(request.getParameter("cno"));
	String pageNum = request.getParameter("pageNum");
	
	LeeDAO dao = new LeeDAO(); 
	ReplyDTO reply = dao.getOneReply(rno); 
	String id=reply.getUser_id();
	System.out.println("id:"+id);
	
%>

<body>
	<br />
	<h1 align="center"> Reply Modify </h1>
	<form action="FBreplyModifyPro.jsp?pageNum=<%=pageNum%>" method="post">
		<input type="hidden" name="cno" value="<%=cno%>"/>
		<input type="hidden" name="rno" value="<%=rno%>"/>
		<table>
			<tr>
				<td>내 용</td>
				<td><textarea rows="3" cols="40" name="reply"> <%=reply.getR_reply()%> </textarea></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td align="left"><%=reply.getUser_id()%></td>
			</tr>
			<tr>
				<td colspan="2" align="left">
					<input type="submit" value="댓글수정" /> 
					<input type="button" value="취소" onclick="window.location='FBcontent.jsp?cno=<%=cno%>&pageNum=<%=pageNum%>'" />
				</td>
			</tr>
		</table>
	</form>
	

</body>
</html>