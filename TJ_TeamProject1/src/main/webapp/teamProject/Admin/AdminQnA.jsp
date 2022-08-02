<%@page import="team.project.model.QnADTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--<%@include file="AdminSessionCheck.jsp" %>--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminQnA</title>
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
	<div align="center">
	<form name="QnAForm">
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
				<td colspan="2">
					<%
			if(q_no!=null){
				%> 
				<button type="submit" formaction="AdminQnAPro.jsp" formmethod="post">수정</button>
				 <%
			}else{
				%> 
				<button type="submit" formaction="AdminQnAPro.jsp" formmethod="post">작성</button>
 				<%
			}
			%>
			<button type="submit" formaction="AdminQnADelete.jsp" formmethod="post">삭제</button>

				</td>
			</tr>
		</table>
	</form>
	</div>

</body>
</html>