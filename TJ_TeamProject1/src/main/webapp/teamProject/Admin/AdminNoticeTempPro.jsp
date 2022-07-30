<%@page import="team.project.model.NoticeDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@include file="AdminSessionCheck.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminNoticeTempPro</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");

	GyeJeongDAO dao = new GyeJeongDAO();
	NoticeDTO dto = new NoticeDTO();

	String no_title = request.getParameter("no_title");
	String no_content = request.getParameter("no_content");
	String no_cat = request.getParameter("no_cat");

	int hidden = 1; // 0 이면 노출 1이면 숨김

	dto.setNo_title(no_title);
	dto.setNo_content(no_content);
	dto.setNo_cat(no_cat);
	dto.setNo_hidden(hidden);

	int result = dao.insertNotice(dto);
	System.out.println("AdminNoticeTempPro.value result : "+result);

	response.sendRedirect("AdminMain.jsp");
	%>


</body>
</html>