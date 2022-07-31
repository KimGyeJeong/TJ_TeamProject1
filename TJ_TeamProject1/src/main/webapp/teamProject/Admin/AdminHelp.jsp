<%@page import="team.project.model.UserQuestionDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@include file="AdminSessionCheck.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminHelp</title>
<link href="../style.css" rel="stylesheet" type="text/css">

</head>
<body>
<%-- <jsp:include page='AdminSessionCheck.jsp' /> --%>
	<%
	request.setCharacterEncoding("UTF-8");

	String uq_no = request.getParameter("uq_no");

	GyeJeongDAO dao = new GyeJeongDAO();
	UserQuestionDTO dto = dao.getOneUserQuestion(Integer.parseInt(uq_no));
	%>

	<h4><%=uq_no%></h4>
	<h4><%=dto.getUq_title()%></h4>
	<%-- 답변하기 --%>
	<table>
		<tr>
			<td>고객문의 고유번호</td>
			<td><%=dto.getUq_no()%></td>
		</tr>
		<tr>
			<td>상품 고유번호</td>
			<td><%=dto.getP_no()%></td>
		</tr>
		<tr>
			<td>등록자</td>
			<td><%=dto.getUser_id()%></td>
		</tr>
		<tr>
			<td>문의 제목</td>
			<td><%=dto.getUq_title()%></td>
		</tr>
		<tr>
			<td>문의 카테고리</td>
			<td><%=dto.getUq_cat()%></td>
		</tr>
		<tr>
			<td>문의 내용</td>
			<td><%=dto.getUq_content()%></td>
		</tr>
		<%-- 문의 사진 3장 --%>
		<%
			for(int i=1;i<3;i++){
				if(dto.getUq_img1()!=null){
					%>
					<tr>
					<td><img  src="../save/<%=dto.getUq_img1()%>" width="250px"/></td>
					</tr>
					<%
				}
				if(dto.getUq_img2()!=null){
					%>
					<tr>
					<td><img  src="../save/<%=dto.getUq_img2()%>" width="250px"/></td>
					</tr>
					<%
				}
				if(dto.getUq_img3()!=null){
					%>
					<tr>
					<td><img  src="../save/<%=dto.getUq_img3()%>" width="250px"/></td>
					</tr>
					<%
				}
			}
		%>
		<tr>
			<td>등록날짜</td>
			<td><%=dto.getUq_reg()%></td>
		</tr>

		<%
		//필요한것. 답변 내용
		// 등록날짜랑 답변날짜 같으면 등록 안했다고 처리?
		%>
		<tr>
			<td>답변하기</td>
			<td>
				<form action="AdminHelpPro.jsp" method="post">
					<input type="hidden" name="uq_no" value="<%=dto.getUq_no()%>">
					<textarea rows="" cols="" name="uqa_content"><%=dto.getUqa_content() %></textarea>
					<input type="submit" value="답변 완료">
				</form>

			</td>
		</tr>
		<tr>
			<td>답변 상태</td>
			<td>
				<%
			if(dto.getUq_reg().equals(dto.getUqa_reg())){
				%> 답변 미완료 <%
			}else{
				%> 답변 완료. 완료시각(<%=dto.getUqa_reg() %>) <%
			}
			%>
			</td>
		</tr>
	</table>


</body>
</html>