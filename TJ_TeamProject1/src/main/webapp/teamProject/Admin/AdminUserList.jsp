<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="team.project.model.UserListDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@include file="AdminSessionCheck.jsp" %>--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminUserList</title>
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
	
	//TODO 0722
	//검색결과가 null인경우 500에러 발생
	
	request.setCharacterEncoding("UTF-8");

	SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd a HH:mm:ss");

	GyeJeongDAO dao = new GyeJeongDAO();
	UserListDTO dto = null;
	List<UserListDTO> list = null;

	String pageNum = request.getParameter("pageNum");
	if (pageNum == null)
		pageNum = "1";

	int currentPage = Integer.parseInt(pageNum);

	int pageSize = 5; //값 그때그때 수정시키고싶은데...

	int startRow = (currentPage - 1) * pageSize + 1;
	System.out.println("AdminUserList.value startRow : " + startRow);
	int endRow = currentPage * pageSize;
	System.out.println("AdminUserList.value endRow : " + endRow);

	//유저 수 계산해서 넣어줄 변수
	int userCount = 0;

	//검색
	// 유저 이름으로 검색
	String search = request.getParameter("search");
	System.out.println("userlist.value search " + search);

	//기본 내림차순 정렬
	String orderBy = request.getParameter("orderBy");
	if (orderBy == null)
		orderBy = "DESC";

	/*
	if (search == null)
		search = "";
	*/

	//유저 ID로 찾기

	if (search == null) {
		userCount = dao.getUserCount();
		if (userCount > 0)
			list = dao.getUser(startRow, endRow, orderBy);
	} else {
		userCount = dao.getUserSearchCount(search);
		if (userCount > 0)
			list = dao.getUserSearch(startRow, endRow, search, orderBy);
	}

	//TODO 수정하기 0715
	//어드민은 전부 봐야해서 필요없을것 같은데
	int userNumber = userCount - (currentPage - 1) * pageSize;

	//추가 옵션
	//#1.특정기간내
	//#2.활성화 or 비활성화
	//#3.경고유저 확인
	%>
	
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
	
	
	
<div align="center">
	<table>
		<tr>
			<td>번호</td>
			<td>아이디</td>
			<td>Email</td>
			<td>이름</td>
			<td>가입일</td>
			<td>삭제여부</td>
			<td>신고횟수</td>
		</tr>
		<tr>
			<%
			for (int i = 0; i < list.size(); i++) {
				dto = list.get(i);
			%>
			<td><%=userNumber--%></td>
			<td><a
				href="AdminShowUser.jsp?user_id=<%=dto.getUser_id()%>&pageNum=<%=pageNum%>&search=<%=search%>"><%=dto.getUser_id()%></a></td>
			<td><%=dto.getUser_email()%></td>
			<td><%=dto.getUser_name()%></td>
			<td><%=sdf.format(dto.getUser_reg())%></td>
			<td><%=dto.getUser_delete()%></td>
			<td><%=dto.getUser_reportCnt()%></td>
		</tr>
		<%
		}
		%>
	</table>
</div>
	<%-- 페이징 처리하기 --%>
	<div align="center">
		<%
		if (userCount > 0) {
			int pageNumSize = 5;
			int pageCount = userCount / pageSize + (userCount % pageSize == 0 ? 0 : 1);
			int startPage = (int)((currentPage - 1) / pageNumSize) * pageNumSize + 1;
			int endPage = startPage + pageNumSize - 1;

			if (endPage > pageCount)
				endPage = pageCount;

			if (startPage > pageNumSize) {
				if (search != null) {
		%>
		<a class="pageNum"
			href="AdminUserList.jsp?pageNum=<%=startPage - 1%>&search=<%=search%>">&lt;
			&nbsp;</a>
		<%
		} else {
		%>
		<a class="pageNum" href="AdminUserList.jsp?pageNum=<%=startPage - 1%>">&lt;
			&nbsp;</a>
		<%
		}
		} //startPage>pageNumSize

		for (int i = startPage; i < endPage + 1; i++) {
		if (search != null) {
		%>
		<a class="pageNum"
			href="AdminUserList.jsp?pageNum=<%=i%>&search=<%=search%>">&nbsp;
			<%=i%> &nbsp;
		</a>
		<%
		} else {
		%>
		<a class="pageNum" href="AdminUserList.jsp?pageNum=<%=i%>">&nbsp; <%=i%>
			&nbsp;
		</a>
		<%
		}
		}//for
		
		if(endPage < pageCount){
			if(search!=null){
				%>
		<a class="pageNum"
			href="AdminUserList.jsp?pageNum=<%=startPage + pageNumSize%>&search=<%=search%>">&nbsp;
			&gt; </a>
		<%
			}else{
				%>
		<a class="pageNum"
			href="AdminUserList.jsp?pageNum=<%=startPage + pageNumSize%>">&nbsp;
			&gt; </a>
		<%
			}
		}
		}
		%>

	</div>
	
	<%-- select만들기.. --%>
	<div align="center">
		<form action="AdminUserList.jsp">
			<input type="text" name="search" placeholder="유저ID로 찾기">
			<input type="submit" value="검색"> 
		</form>
	</div>
	
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