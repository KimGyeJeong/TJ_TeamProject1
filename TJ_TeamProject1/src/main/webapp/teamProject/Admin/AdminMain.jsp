<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminMain</title>
<%-- <link href="../style.css" rel="stylesheet" type="text/css"> --%>

<!-- Favicon -->
<link href="AdminCSS/img/favicon.ico" rel="icon">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap"
	rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="AdminCSS/lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link
	href="AdminCSS/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
	rel="stylesheet" />

<!-- Customized Bootstrap Stylesheet -->
<link href="AdminCSS/css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<link href="AdminCSS/css/style.css" rel="stylesheet">

</head>
<body>
	<%
//TEST Session.value 0730
String ad_id = (String)session.getAttribute("adminId");
System.out.println("AdminMain.value ad_id : "+ad_id);

%>

	<jsp:include page='AdminSessionCheck.jsp' />
	
	<%-- CSS입힌 곳.. --%>
	<div class="container-fluid position-relative d-flex p-0">
	    <!-- Spinner Start -->
        <div id="spinner" class="show bg-dark position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
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
					<a href="AdminReportList.jsp"
						class="nav-item nav-link">신고글확인</a>
					<a href="AdminNotice.jsp" class="nav-item nav-link">공지사항/이벤트 글 작성</a>
					<a href="AdminHelpList.jsp"
						class="nav-item nav-link">1대1 문의 확인</a>
					<a href="AdminProductList.jsp"
						class="nav-item nav-link">상품확인</a>
					<a href="AdminQnAList.jsp"
						class="nav-item nav-link">자주하는질문</a>
					<a href="AdminFBList.jsp"
						class="nav-item nav-link">자유게시판</a>

				</div>
			</nav>
		</div>
		<!-- Sidebar End -->
	</div>
	<!-- Content End -->


<div id="AdminCat" align="center" style="margin-left: 250px">
<img alt="" src="../save/AdminCat.png">
</div>

<%-- 
	<div align="center">
		<table>
			<tr>
				<td>AdminPage</td>
			</tr>
			<tr>
				<td><a onclick="location.href='AdminUserList.jsp'">유저 확인</a></td>
			</tr>
			<tr>
				<td><a onclick="location.href='AdminInsertCategory.jsp'">카테고리
						설정</a></td>
			</tr>
			<tr>
				<td><a onclick="location.href='AdminReportList.jsp'">신고글 확인</a>
				</td>
			</tr>
			<tr>
				<td><a onclick="location.href='AdminNotice.jsp'">공지사항/이벤트 글
						작성</a></td>
			</tr>
			<tr>
				<td><a onclick="location.href='AdminHelpList.jsp'">1대1 문의
						확인</a></td>
			</tr>
			<tr>
				<td><a onclick="location.href='AdminProductList.jsp'">상품 확인</a>
				</td>
			</tr>
			<tr>
				<td><a onclick="location.href='AdminQnAList.jsp'">자주하는질문</a></td>
			</tr>
		</table>
	</div>
--%>

	<!-- JavaScript Libraries -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="AdminCSS/lib/chart/chart.min.js"></script>
	<script src="AdminCSS/lib/easing/easing.min.js"></script>
	<script src="AdminCSS/lib/waypoints/waypoints.min.js"></script>
	<script src="AdminCSS/lib/owlcarousel/owl.carousel.min.js"></script>
	<script src="AdminCSS/lib/tempusdominus/js/moment.min.js"></script>
	<script src="AdminCSS/lib/tempusdominus/js/moment-timezone.min.js"></script>
	<script
		src="AdminCSS/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

	<!-- Template Javascript -->
	<script src="AdminCSS/js/main.js"></script>

</body>
</html>