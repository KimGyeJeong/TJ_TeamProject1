<%@page import="java.util.List"%>
<%@page import="team.project.model.UserQuestionDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminHelpList</title>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%-- AdminHelp로  --%>
	<%
	request.setCharacterEncoding("UTF-8");

	GyeJeongDAO dao = new GyeJeongDAO();
	UserQuestionDTO dto = null;
	List<UserQuestionDTO> list = null;

	String pageNum = request.getParameter("pageNum");
	if (pageNum == null)
		pageNum = "1";

	int currentPage = Integer.parseInt(pageNum);

	int pageSize = 5;

	int startRow = (currentPage - 1) * pageSize + 1;

	int endRow = currentPage * pageSize;

	//문의들 수 가져오기
	int userQuestionCount = 0;

	userQuestionCount = dao.getQuestionCount();
	//	System.out.println("AdminHelpList.value userQuestionCount : " + userQuestionCount);

	if (userQuestionCount > 0)
		list = dao.getUserQuestion(startRow, endRow);

	//검색?
	// 내림차순? 오름차순?

	int userQuestionNumber = userQuestionCount - (currentPage - 1) * pageSize;
	%>

	<div>
		<table>
			<tr>
				<td>게시판번호</td>
				<td>문의고유번호</td>
				<td>상품번호</td>
				<td>아이디</td>
				<td>제목</td>
				<td>카테고리</td>
				<td>유저작성시간</td>
				<td>답변시간</td>
			</tr>
			<tr>
				<%
				for (int i = 0; i < list.size(); i++) {
					dto = list.get(i);
				%>
				<td><%=userQuestionNumber--%></td>
				<td><%=dto.getUq_no()%></td>
				<td><%=dto.getP_no()%></td>
				<td>
				<a href="AdminShowUser.jsp?user_id=<%=dto.getUser_id()%>">
				<%=dto.getUser_id()%>
				</a>
				</td>
				<td>
				<a href="AdminHelp.jsp?uq_no=<%=dto.getUq_no()%>">
				<%=dto.getUq_title()%>
				</a>
				</td>
				<td><%=dto.getUq_cat()%></td>
				<td><%=dto.getUq_reg()%></td>
				<td><%=dto.getUqa_reg()%></td>
			</tr>
			<%
			}
			%>

		</table>
	</div>

	<%-- 페이지 번호 --%>
	<div align="center">
		<%
		if (userQuestionCount > 0) {
			int pageNumSize = 5;
			int pageCount = userQuestionCount / pageSize + (userQuestionCount % pageNumSize == 0 ? 0 : 1);
			int startPage = (int) ((currentPage - 1) / pageNumSize) * pageNumSize + 1;
			int endPage = startPage + pageNumSize - 1;

			if (endPage > pageCount)
				endPage = pageCount;

			if (startPage > pageNumSize) {
		%>
		<a class="pageNum" href="AdminHelpList.jsp?pageNum=<%=startPage - 1%>">&lt;&nbsp;</a>
		<%
			}
			for (int i = startPage; i < endPage + 1; i++) {
		%>
			<a class="pageNum" href="AdminHelpList.jsp?pageNum=<%=i%>">&nbsp;<%=i%>&nbsp;
			</a>
		<%
			}
			if (endPage < pageCount) {
		%>
			<a class="pageNum"
				href="AdminHelpList.jsp?pageNum=<%=startPage + pageNumSize%>">&nbsp;&gt;</a>
		<%
			}

		}
		%>
	</div>

</body>
</html>