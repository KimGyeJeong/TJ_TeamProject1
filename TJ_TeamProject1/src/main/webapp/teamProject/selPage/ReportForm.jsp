<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 페이지</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String UID = (String)session.getAttribute("UID");
	if(UID != null){
	Integer p_no = Integer.parseInt(request.getParameter("p_no"));
	if(p_no == null){
		p_no = -1;
	}
	String p_sellerId = request.getParameter("p_sellerId");
%>
</body>
	<form action="ReportPro.jsp" method="post">
	<input type="hidden" name="p_no" value="<%=p_no%>"/>
	<input type="hidden" name="rp_reportedUid" value="<%=p_sellerId %>" />
		<table>
			<tr>
				<td>신고할 유저<br/>
				<textarea rows="2" cols="22" readonly><%=p_sellerId %></textarea></td>
			</tr>
			<tr>
				<td>신고 사유<br/>
				<select id="rp_reason" name="rp_reason" >
					<option value="1">1</option>
					<option value="1">2</option>
					<option value="1">3</option>
					<option value="기타">기타</option>
				</select></td>
			</tr>
			<tr>
				<td>신고 제목<br/>
				<textarea rows="2" cols="50" name="rp_title"></textarea></td>
			</tr>
			<tr>
				<td>신고 내용<br/>
				<br/><textarea rows="10" cols="50" name="rp_content"></textarea></td>
			</tr>
			<tr>
				<td>주의사항</td>
				<td><input type="submit" value="신고 하기" /></td>
			</tr>
		</table>
	</form>
<%}else{%>
		<script>
			alert("로그인 후 이용해 주세요!");
			window.location.assign("../Login/Login.jsp");
		</script>
<%	}%>
</html>