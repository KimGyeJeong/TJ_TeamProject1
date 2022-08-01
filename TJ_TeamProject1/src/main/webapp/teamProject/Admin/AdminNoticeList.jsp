<%@page import="team.project.dao.LeeDAO"%>
<%@page import="team.project.model.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminNoticeList</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");

	GyeJeongDAO dao = new GyeJeongDAO();
	LeeDAO dao_lee = new LeeDAO();

	int end = dao_lee.noticeCount();
	List<NoticeDTO> list = dao_lee.noticeList(1, end);
	NoticeDTO dto = null;
	%>

	<div>
		<table>
			<tr>
				<td>게시판 고유번호</td>
				<td>공지사항/이벤트</td>
				<td>제목</td>
				<td>저장/임시저장or삭제</td>
				<td>작성시간</td>
			</tr>
			<%
			for (int i = 0; i < list.size(); i++) {
				dto = list.get(i);
			%>
			<tr>
				<td><%=dto.getNo_no()%></td>
				<td><%=dto.getNo_cat()%></td>
				<td><a href="javascript:goNoticePage(<%=dto.getNo_no()%>)">
						<%=dto.getNo_title()%></a></td>

				<%
				if (dto.getNo_hidden() > 0) {
				%>
				<td>임시저장or삭제</td>
				<%
				} else {
				%>
				<td>저장</td>
				<%
				}
				%>

				<td><%=dto.getNo_reg()%></td>
			</tr>
			<%
			}
			%>
		</table>
	</div>


	<script type="text/javascript">
		function goNoticePage(no_no) {
			let f = document.createElement('form');

			let no;
			no = document.createElement('input');
			no.setAttribute('type', 'hidden');
			no.setAttribute('name', 'no_no');
			no.setAttribute('value', no_no);

			f.appendChild(no);
			f.setAttribute('method', 'post');
			f.setAttribute('action', 'AdminNotice.jsp');

			document.body.appendChild(f);
			f.submit();
		}
	</script>

</body>
</html>