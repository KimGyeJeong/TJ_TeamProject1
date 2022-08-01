<%@page import="team.project.model.NoticeDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="AdminSessionCheck.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminNotice</title>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
NoticeDTO dto = null;

String no_no = request.getParameter("no_no");
//no_nono 가 null 이면 500에러
if(no_no!=null){
	GyeJeongDAO dao = new GyeJeongDAO();
	System.out.println("AdminNotice.value nono: " + no_no);
	dto = dao.getNotice(Integer.parseInt(no_no));
%>
	<h4>no_no = <%=no_no %></h4>
		<script type="text/javascript">
	function testSomeThing(){
		document.getElementById("no_title").value='<%=dto.getNo_title()%>';
		document.getElementById("no_content").value='<%=dto.getNo_content()%>';
		document.getElementById("testSome").value='After';
		//location.reload;
		console.log("Function ACTIVE");
	}
	


	</script>

	
<% } %>	
	<%-- 공지사항/이벤트 작성 폼 --%>
	
	TestSome : <input type="button" id="testSome" value="Before" onclick="testSomeThing()">
	<div>
		<form name="notice">
			<table>
				<tr>
					<td colspan="2">공지사항/이벤트 글 작성</td>
				</tr>
				<tr>
					<td>카테고리</td>
					<td><input type="radio" name="no_cat" value="notice"
						checked="checked">공지사항 <input type="radio" name="no_cat"
						value="event">이벤트</td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" id="no_title" name="no_title" value=""></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea cols="50" rows="15" id="no_content" name="no_content"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="reset" value="초기화">
						<input type="button" value="작성 취소"
						onclick="location.href='AdminMain.jsp'">
						<button type="submit" formaction="AdminNoticeTempPro.jsp"
							formmethod="post">임시저장</button>
						<button type="submit" formaction="AdminNoticePro.jsp"
							formmethod="post">저장</button></td>
				</tr>
			</table>
		</form>
	</div>
	
	

	
	
	<div align="center">
		<jsp:include page='AdminNoticeList.jsp' />
	</div>

</body>
</html>