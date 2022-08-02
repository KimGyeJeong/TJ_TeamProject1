<%@page import="team.project.model.NoticeDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--  <%@include file="AdminSessionCheck.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminNotice</title>
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
	NoticeDTO dto = null;

	String no_no = request.getParameter("no_no");
	//no_nono 가 null 이면 500에러
	if (no_no != null) {
		GyeJeongDAO dao = new GyeJeongDAO();
		System.out.println("AdminNotice.value nono: " + no_no);
		dto = dao.getNotice(Integer.parseInt(no_no));
	%>





	<div align="center">
		<h4>
			no_no =
			<%=no_no%></h4>
		<script type="text/javascript">
	function testSomeThing(){
		document.getElementById("no_title").value='<%=dto.getNo_title()%>';
		document.getElementById("no_content").value='<%=dto.getNo_content()%>
			';
				document.getElementById("testSome").value = 'After';
				//location.reload;
				console.log("Function ACTIVE");
			}
		</script>


		<%
		}
		%>
		<%-- 공지사항/이벤트 작성 폼 --%>
		<div align="center">
			TestSome : <input type="button" id="testSome" value="Before"
				onclick="testSomeThing()">
			<div>
				<form name="notice">
					<table>
						<tr>
							<td colspan="2">공지사항/이벤트 글 작성</td>
						</tr>
						<tr>
							<td>카테고리</td>
							<td><input type="radio" name="no_cat" value="notice"
								checked="checked">공지사항 <input type="radio" name="no_cat"
								value="event">이벤트</td>
						</tr>
						<tr>
							<td>제목</td>
							<td><input type="text" id="no_title" name="no_title"
								value=""></td>
						</tr>
						<tr>
							<td>내용</td>
							<td><textarea cols="50" rows="15" id="no_content"
									name="no_content"></textarea></td>
						</tr>
						<tr>
							<td colspan="2" align="right"><input type="reset"
								value="초기화"> <input type="button" value="작성 취소"
								onclick="location.href='AdminMain.jsp'">
								<button type="submit" formaction="AdminNoticeTempPro.jsp"
									formmethod="post">임시저장</button>
								<button type="submit" formaction="AdminNoticePro.jsp"
									formmethod="post">저장</button></td>
						</tr>
					</table>
				</form>
			</div>
		</div>





		<div align="center">
			<jsp:include page='AdminNoticeList.jsp' />
		</div>
	</div>

</body>
</html>