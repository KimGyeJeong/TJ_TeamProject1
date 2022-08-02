<%@page import="java.util.List"%>
<%@page import="team.project.model.QnADTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--  <%@include file="AdminSessionCheck.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminQnAList</title>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>

<jsp:include page='AdminSessionCheck.jsp' />

	<%-- CSS입힌 곳.. --%>
	<div class="container-fluid position-relative d-flex p-0">
		<!-- Spinner Start -->
		<%-- 
        <div id="spinner" class="show bg-dark position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        --%>
		<!-- Sidebar Start -->
		<div class="sidebar pe-4 pb-3">
			<nav class="navbar bg-secondary navbar-dark">
				<a href="AdminMain.jsp" class="navbar-brand mx-4 mb-3">
					<h3 class="text-primary">
						<i class="fa fa-user-edit me-2"></i>AdminPage
					</h3>
				</a>
				<%-- 
				<div class="d-flex align-items-center ms-4 mb-4">
					<div class="position-relative">
						<img class="rounded-circle" src="img/user.jpg" alt=""
							style="width: 40px; height: 40px;">
						<div
							class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
					</div>
					<div class="ms-3">
						<h6 class="mb-0">Jhon Doe</h6>
						<span>Admin</span>
					</div>
				</div>
				--%>
				<div class="navbar-nav w-100">
					<a href="AdminUserList.jsp" class="nav-item nav-link active">유저확인</a>
					<a href="AdminInsertCategory.jsp" class="nav-item nav-link">카테고리설정</a>
					<a href="AdminReportList.jsp" class="nav-item nav-link">신고글확인</a> <a
						href="AdminNotice.jsp" class="nav-item nav-link">공지사항/이벤트 글 작성</a>
					<a href="AdminHelpList.jsp" class="nav-item nav-link">1대1 문의 확인</a>
					<a href="AdminProductList.jsp" class="nav-item nav-link">상품확인</a> <a
						href="AdminQnAList.jsp" class="nav-item nav-link">자주하는질문</a>


					<div class="nav-item dropdown">
						<a href="#" class="nav-link dropdown-toggle"
							data-bs-toggle="dropdown"><i class="far fa-file-alt me-2"></i>Pages</a>
						<div class="dropdown-menu bg-transparent border-0">
							<a href="signin.html" class="dropdown-item">Sign In</a> <a
								href="signup.html" class="dropdown-item">Sign Up</a> <a
								href="404.html" class="dropdown-item">404 Error</a> <a
								href="blank.html" class="dropdown-item">Blank Page</a>
						</div>
					</div>
				</div>
			</nav>
		</div>
		<!-- Sidebar End -->
	</div>
	<!-- Content End -->

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
	<div align="center">
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