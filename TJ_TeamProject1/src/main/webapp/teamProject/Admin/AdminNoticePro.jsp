<%@page import="team.project.model.NoticeDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="AdminSessionCheck.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminNoticePro</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");

	GyeJeongDAO dao = new GyeJeongDAO();
	NoticeDTO dto = new NoticeDTO();

	String no_title = request.getParameter("no_title");
	String no_content = request.getParameter("no_content");
	String no_cat = request.getParameter("no_cat");

	int hidden = 0; // 0 이면 노출 1이면 숨김

	dto.setNo_title(no_title);
	dto.setNo_content(no_content);
	dto.setNo_cat(no_cat);
	dto.setNo_hidden(hidden);

	int result = dao.updateNotice(dto);

	response.sendRedirect("AdminMain.jsp");
	%>


</body>
</html>