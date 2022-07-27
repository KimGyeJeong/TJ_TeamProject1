<%@page import="java.util.List"%>
<%@page import="team.project.model.QnADTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminQnAList</title>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>

	<%
	response.setCharacterEncoding("UTF-8");

	SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");

	GyeJeongDAO dao = new GyeJeongDAO();
	List<QnADTO> list = null;
	QnADTO dto = null;

	String pageNum = request.getParameter("pageNum");
	if (pageNum == null)
		pageNum = "1";

	int currentPage = Integer.parseInt(pageNum);

	int pageSize = 5;

	int startRow = (currentPage - 1) * pageSize + 1;
	System.out.println("AdminQnAList.value startRow : " + startRow);
	int endRow = currentPage * pageSize;
	System.out.println("AdminQnAList.value endRow : " + endRow);

	//QnA수
	int qnaCount = 0;

	//검색
	// 유저 이름으로 검색
	String search = request.getParameter("search");
	System.out.println("AdminReportList.value search " + search);

	if (search == null) {
		qnaCount = dao.getQnACount();
		if (qnaCount > 0)
			list = dao.getQnA(startRow, endRow);
	} else {
		qnaCount = dao.getSearchQnACount(search);
		if (qnaCount > 0)
			list = dao.getSearchQnA(startRow, endRow, search);

	}
	%>
	<table>
		<tr>
			<td align="right" colspan="4"> <input type="button" onclick="location.href='AdminQnA.jsp'"
				value="작성"></td>
		</tr>
		<tr>
			<td>자주하는 질문 게시판 번호</td>
			<td>QnA고유번호</td>
			<td>QnA제목</td>
			<td>QnA작성시간</td>
		</tr>
		
		<%
		if(list!=null){
			for(int i=0;i<list.size();i++){
				dto = list.get(i);
				%>
				<tr>
				<td><%=qnaCount-- %></td>
				<td><%= dto.getQ_no()%></td>
				<td>
				<a href="javascript:goPage(<%=dto.getQ_no()%>)"><%= dto.getQ_title() %></a>
				
				</td>
				<td><%= dto.getQ_reg() %></td>
				</tr>
		<%
			}
		}else{
			//list == null
		}
		%>
		
	</table>
	<script type="text/javascript">
	
		function goPage(q_no) {
			let f = document.createElement('form');

			let no;
			no = document.createElement('input');
			no.setAttribute('type', 'hidden');
			no.setAttribute('name', 'q_no');
			no.setAttribute('value', q_no);

			f.appendChild(no);
			f.setAttribute('method', 'post');
			f.setAttribute('action', 'AdminQnA.jsp');

			document.body.appendChild(f);
			f.submit();
		}
	</script>

</body>
</html>