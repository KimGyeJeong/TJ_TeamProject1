<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team.project.model.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<%
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
uid = "qwe8246";
InstanceDAO dao = new InstanceDAO();
List<ReviewDTO> ReportReviewList = dao.getReportReview(uid);	//	이 유저가 한 평가	
List<ReviewDTO> ReportedReviewList = dao.getReportedReview(uid);	//	이 유저에 대한 평가
SimpleDateFormat sdf = new SimpleDateFormat("YY-MM-dd HH:mm");

%>
<body>
<fieldset>
<%= uid %>님과의 거래경험담
<table>
	<tr>
		<td>COMMENT</td><td>평점</td><td>작성자</td><td>작성날짜</td>
	</tr>
<%	for(int i=0 ; i<ReportedReviewList.size() ; i++){ 
		ReviewDTO dto = ReportedReviewList.get(i); 
		System.out.println(dto);%>
	<tr>
		<td><%= dto.getRe_content() %></td><td>평점<%= dto.getRe_stars() %></td><td><%= dto.getRe_reportUid() %></td><td><%= sdf.format(dto.getRe_reg()) %></td>
	</tr>
<% 	} %>
</table>
</fieldset>
<fieldset>
<%= uid %>님이 쓰신 거래경험담
<table>
	<tr>
		<td>COMMENT</td><td>평점</td><td>판매자에게</td><td>작성날짜</td>
	</tr>
<%	for(int i=0 ; i<ReportedReviewList.size() ; i++){ 
		ReviewDTO dto = ReportedReviewList.get(i); 
		System.out.println(dto);%>
	<tr>
		<td><%= dto.getRe_content() %></td><td>평점<%= dto.getRe_stars() %></td><td><%= dto.getRe_reportedUid() %></td><td><%= sdf.format(dto.getRe_reg()) %></td>
	</tr>
<% 	} %>
</table>
</fieldset>
</body>
</html>