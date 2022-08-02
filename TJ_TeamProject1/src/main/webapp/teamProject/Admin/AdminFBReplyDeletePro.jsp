<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminFBReplyDeletePro</title>
</head>
<body>

<jsp:include page='AdminSessionCheck.jsp' />

<h3>댓글삭제페이지</h3>
<%
request.setCharacterEncoding("UTF-8");

String rno = request.getParameter("r_no");

GyeJeongDAO dao = new GyeJeongDAO();
int result = dao.deleteFBR(Integer.parseInt(rno));
int cno = dao.getFBContentFromRNO(Integer.parseInt(rno));

System.out.println("AdminFBReplyDelete.value rno : "+rno);
System.out.println("AdminFBReplyDelete.value cno : "+cno);

response.sendRedirect("AdminFBContent.jsp?cno="+cno); 
%>
<h4>rno : <%=rno %></h4>
<h4>result : <%=result %></h4>

</body>
</html>