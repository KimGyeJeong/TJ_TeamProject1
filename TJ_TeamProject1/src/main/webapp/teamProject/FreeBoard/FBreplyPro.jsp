<%@page import="team.project.dao.LeeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>replyPro 댓글 작성 처리</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String cno = request.getParameter("cno");
	String pageNum = request.getParameter("pageNum");
%>
<jsp:useBean id="reply" class="team.project.model.ReplyDTO" />
<jsp:setProperty property="*" name="reply"/>

<% 
	reply.getC_no();
	System.out.println("아잉:"+reply.getR_reply());
	
	
	LeeDAO dao = new LeeDAO(); 
	dao.insertReply(reply);  // DB replyBoard 테이블에 댓글 저장 
	// 이전에 보던 content페이지 요청, 이때 어떤 글의 본문페이지인지 글 고유번호 파라미터로 전달
	response.sendRedirect("FBcontent.jsp?cno=" + reply.getC_no()+"&pageNum=" + pageNum);
%>


<body>

</body>
</html>