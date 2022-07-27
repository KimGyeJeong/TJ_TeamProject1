<%@page import="team.project.dao.BeomSuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 문의 페이지</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String UID = (String)session.getAttribute("UID");
	Integer p_no = Integer.parseInt(request.getParameter("p_no"));
	if(p_no == null){
		p_no = -1;
	}
	String p_sellerId = request.getParameter("p_sellerId");
	String p_title = request.getParameter("p_title");
%>
<body>
<%	if(UID != null){ %>
	<form action="ProductQuestionPro.jsp" method="post">
	<input type="hidden" name="p_no" value="<%=p_no%>"/>
		<table>
			<tr>
				<td>상품 정보</td>
				<td><text readonly>문의할 글의 제목 : <%=p_title %>
				</text><br/>
				<text readonly>판매자 : <%=p_sellerId %></text></td>
			</tr>
			<tr>
				<td>문의 제목</td>
				<td><textarea rows="2" cols="50" name="pq_title"></textarea></td>
			</tr>
			<tr>
				<td>문의 내용</td>
				<td><textarea rows="10" cols="50" name="pq_content"></textarea></td>
			</tr>
			<tr>
				<td>주의사항</td>
				<td><input type="submit" value="문의 작성" /></td>
			</tr>
		</table>
	</form>
<% }else{%>
		<script>
			alert("로그인 후 이용해 주세요!");
			opener.parent.location='../Login/Login.jsp';
			window.close();
		</script>
<%	} %>
</body>
</html>