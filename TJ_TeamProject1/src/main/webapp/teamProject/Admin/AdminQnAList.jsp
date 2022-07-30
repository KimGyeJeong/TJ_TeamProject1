<%@page import="java.util.List"%>
<%@page import="team.project.model.QnADTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="AdminSessionCheck.jsp" %>
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
	//System.out.println("AdminQnAList.value search 44" + search);

	if (search == null) {
		qnaCount = dao.getQnACount();
		//System.out.println("QnAList.value 48. qnaCount : "+qnaCount);
		if (qnaCount > 0)
			list = dao.getQnA(startRow, endRow);
	} else {
		qnaCount = dao.getSearchQnACount(search);
		if (qnaCount > 0)
			list = dao.getSearchQnA(startRow, endRow, search);

	}
	int qnaNumber = qnaCount - (currentPage - 1) * pageSize;
	%>
	<div>
		<table>
			<tr>
				<td align="right" colspan="4"><input type="button"
					onclick="location.href='AdminQnA.jsp'" value="작성"></td>
			</tr>
			<tr>
				<td>자주하는 질문 게시판 번호</td>
				<td>QnA고유번호</td>
				<td>QnA제목</td>
				<td>QnA작성시간</td>
				<td>-</td>
			</tr>

			<%
			if (list != null) {
				for (int i = 0; i < list.size(); i++) {
					dto = list.get(i);
			%>
			<tr>
				<td><%=qnaNumber--%></td>
				<td><%=dto.getQ_no()%></td>
				<td><a
					href="javascript:goPage('AdminQnA.jsp',<%=dto.getQ_no()%>)"><%=dto.getQ_title()%></a>

				</td>
				<td><%=dto.getQ_reg()%></td>
				<td><input type="button" value="삭제"
					onclick="check(<%=dto.getQ_no()%>)">
				</td>
			</tr>
			<%
			}
			} else {
			//list == null
			%>
			<tr>
			<td colspan="5">등록된 글이 없습니다.</td>
			</tr>
			<%
			}
			%>

		</table>
	</div>

	<%-- pageNum --%>
	<div align="center">
		<%
		if (qnaCount > 0) {
			int pageNumSize = 5;
			int pageCount = qnaCount / pageSize + (qnaCount % pageNumSize == 0 ? 0 : 1);
			int startPage = (int) ((currentPage - 1) / pageNumSize) * pageNumSize + 1;
			int endPage = startPage + pageNumSize - 1;

			if (endPage > pageCount)
				endPage = pageCount;

			if (startPage > pageNumSize) {
				if (search != null) {
		%>
		<a class="pageNum"
			href="AdminQnAList.jsp?pageNum=<%=startPage - 1%>&search=<%=search%>">&lt;&nbsp;</a>
		<%
		} else {
		%>
		<a class="pageNum" href="AdminQnAList.jsp?pageNum=<%=startPage - 1%>">&lt;&nbsp;</a>
		<%
		}
		}
		for (int i = startPage; i < endPage + 1; i++) {
		//System.out.println("AdminQnAList.value 페이지for 117 i=" + i);
		if (search != null) {
		%>
		<a class="pageNum"
			href="AdminQnAList.jsp?pageNum=<%=i%>&search=<%=search%>">&nbsp;<%=i%>&nbsp;
		</a>
		<%
		} else {
		%>
		<a class="pageNum" href="AdminQnAList.jsp?pageNum=<%=i%>">&nbsp;<%=i%>&nbsp;
		</a>
		<%
		}
		}
		if (endPage < pageCount) {
		if (search != null) {
		%>
		<a class="pageNum"
			href="AdminQnAList.jsp?pageNum=<%=startPage + pageNumSize%>&search=<%=search%>">&nbsp;&gt;</a>
		<%
		} else {
		%>
		<a class="pageNum"
			href="AdminQnAList.jsp?pageNum=<%=startPage + pageNumSize%>">&nbsp;&gt;</a>
		<%
		}
		}
		}
		%>
	</div>

	<div align="center">
		<form action="AdminQnAList.jsp">
			<input type="text" name="search" placeholder="검색"> <input
				type="submit" value="검색">
		</form>
	</div>



	<script type="text/javascript">
	
	function check(q_no){
		let checkDelete = confirm("자주하는 질문 게시글을 삭제하겠습니까?");
		if(checkDelete){
			goPage('AdminQnADelete.jsp', q_no);
		}else{
			history.go(0);
		}
	}
	
		function goPage(uri, q_no) {
			let f = document.createElement('form');

			let no;
			no = document.createElement('input');
			no.setAttribute('type', 'hidden');
			no.setAttribute('name', 'q_no');
			no.setAttribute('value', q_no);

			f.appendChild(no);
			f.setAttribute('method', 'post');
			f.setAttribute('action', uri );
			
			document.body.appendChild(f);
			f.submit();
		}
	</script>

</body>
</html>