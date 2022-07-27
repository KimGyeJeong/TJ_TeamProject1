<%@page import="team.project.model.QnADTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminQnA</title>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
	//qno가 있으면 수정 없으면 작성
	//글 작성으로 들어오면 qno값 없음 --> 500ERROR
	request.setCharacterEncoding("UTF-8");

	String q_no = request.getParameter("q_no");

	GyeJeongDAO dao = new GyeJeongDAO();
	QnADTO dto = null;

	if(q_no!=null){
		dto = dao.getQnA(Integer.parseInt(q_no));
	}else{
		dto = new QnADTO();
		dto.setQ_no(0);
		dto.setQ_title("");
		dto.setQ_questionContent("");
		dto.setQ_answerContent("");
	}
	%>
	<form action="AdminQnAPro.jsp" method="post">
		<table>
			<tr style="display: none">
				<td><input type="hidden" name="q_no" value="<%=dto.getQ_no()%>">
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="q_title"
					value="<%=dto.getQ_title()%>"></td>
			</tr>
			<tr>
				<td>질문 내용</td>
				<td><textarea rows="" cols="" name="q_questionContent">
			<%=dto.getQ_questionContent()%></textarea></td>
			</tr>
			<tr>
				<td>답변 내용</td>
				<td><textarea rows="" cols="" name="q_answerContent">
			<%=dto.getQ_answerContent()%></textarea></td>
			</tr>
			<tr>
				<td>등록시간</td>
				<td>
					<%
				if(dto.getQ_reg()!= null){
					%> <%=dto.getQ_reg()%><%	
				}else{
					%> - <%	
				}
				%> </td>
			</tr>
			<tr>
				<td>
					<%
			if(q_no!=null){
				%> <input type="submit" value="수정"> <%
			}else{
				%> <input type="submit" value="작성"> <%
			}
			%>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>