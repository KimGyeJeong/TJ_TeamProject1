<%@page import="team.project.model.UserQuestionDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%--  <%@include file="AdminSessionCheck.jsp" %> --%>
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
	request.setCharacterEncoding("UTF-8");

	String uq_no = request.getParameter("uq_no");

	GyeJeongDAO dao = new GyeJeongDAO();
	UserQuestionDTO dto = dao.getOneUserQuestion(Integer.parseInt(uq_no));
	%>

	<div align="center">
		<h4>게시판 번호 : <%=uq_no%></h4>
		<h4>제목 : <%=dto.getUq_title()%></h4>
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
			for (int i = 1; i < 3; i++) {
				if (dto.getUq_img1() != null) {
			%>
			<tr>
				<td><img src="../save/<%=dto.getUq_img1()%>" width="250px" /></td>
			</tr>
			<%
			}
			if (dto.getUq_img2() != null) {
			%>
			<tr>
				<td><img src="../save/<%=dto.getUq_img2()%>" width="250px" /></td>
			</tr>
			<%
			}
			if (dto.getUq_img3() != null) {
			%>
			<tr>
				<td><img src="../save/<%=dto.getUq_img3()%>" width="250px" /></td>
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
						<textarea rows="" cols="" name="uqa_content"><%=dto.getUqa_content()%></textarea>
						<input type="submit" value="답변 완료">
					</form>

				</td>
			</tr>
			<tr>
				<td>답변 상태</td>
				<td>
					<%
					if (dto.getUq_reg().equals(dto.getUqa_reg())) {
					%> 답변 미완료 <%
					} else {
					%> 답변 완료. 완료시각(<%=dto.getUqa_reg()%>) <%
					}
					%>
				</td>
			</tr>
		</table>
	</div>


</body>
</html>