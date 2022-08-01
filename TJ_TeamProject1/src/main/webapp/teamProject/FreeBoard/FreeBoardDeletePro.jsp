<%@page import="team.project.dao.LeeDAO"%> 

<%@ page language="java" contentType="text/html; charset=UTF-8" 

    pageEncoding="UTF-8"%> 

<!DOCTYPE html> 

<html> 

<head> 

	<meta charset="UTF-8"> 

	<title>FreeBoardDeletePro</title> 

</head> 

<% 

	String pageNum = request.getParameter("pageNum"); 

	int cno = Integer.parseInt(request.getParameter("cno")); 

	 

	 

	LeeDAO dao = new LeeDAO();  

	int result = dao.deleteArticle(cno);  

	 

	if(result == 1) {  // 사진삭제 %> 

		<script> 

			alert("삭제 완료!!!"); 

			window.location.href="FreeBoard.jsp?pageNum="+<%=pageNum%>; 

		</script> 

	<%}%> 

  

<body> 

  

</body> 

</html> 