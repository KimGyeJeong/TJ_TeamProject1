<%@page import="java.util.List"%>
<%@page import="team.project.model.UserQuestionDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%--  <%@include file="AdminSessionCheck.jsp" %> --%>
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
<%--<jsp:include page='AdminSessionCheck.jsp' />--%>
	<%-- AdminHelp로  --%>
	
	
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
					<a href="AdminFBList.jsp"
						class="nav-item nav-link">자유게시판</a>

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




	<div align="center">
		<table>
			<tr>
				<td>문의게시판번호</td>
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
				<td>
				<%
				if(dto.getP_no()==0){
				%>
					-
				<%
				}else{
				%>
					<%=dto.getP_no() %>
				<%
				}
				%>
				</td>
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
				<td>
				<%
				if(dto.getUq_reg().equals(dto.getUqa_reg())){
					%>
					-
					<%
				}else{
					%>
					<%=dto.getUqa_reg() %>
					<%
				}
				%>
				</td>
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