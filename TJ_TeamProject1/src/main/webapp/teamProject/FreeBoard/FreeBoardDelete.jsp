<%@ page language="java" contentType="text/html; charset=UTF-8" 

    pageEncoding="UTF-8"%> 

<!DOCTYPE html> 

<html> 

<head> 

	<meta charset="UTF-8"> 

	<title>delete form</title> 

	<link href="style.css" rel="stylesheet" type="text/css" /> 

</head> 

<% 

	String pageNum = request.getParameter("pageNum"); 

	String cno = request.getParameter("cno"); 

	 

%> 

  

<% String id=(String)session.getAttribute("UID"); %> 

	<h3 align="right"> 사용자: <%=id %></h3> 

	 

	<%if(session.getAttribute("UID") != id ){%> 

		<script> 

  			alert("접근권한이 없습니다"); 

  			history.go(-1); 

  		</script> 

    <%}%> 

  		 

  

<body> 

	<br /> 

	<h1 align="center"> 글 삭제 </h1> 

	 

	<form action="FreeBoardDeletePro.jsp?pageNum=<%=pageNum%>&cno=<%=cno%>" method="post"> 

	<table> 

			 

		<tr> 

			<td> 

				<input type="submit" value="삭제" /> 

				<input type="button" value="취소" onclick="window.location='FBcontent.jsp?cno=<%=cno%>&pageNum=<%=pageNum%>'" /> 

			</td> 

		</tr> 

	 

	</table> 

	</form> 

	 

	 

	 

	 

  

</body> 

</html> 