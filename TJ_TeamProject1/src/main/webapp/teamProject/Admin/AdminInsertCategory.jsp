<%@page import="team.project.dao.InstanceDAO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.model.CategoryDTO"%>
<%-- <%@include file="AdminSessionCheck.jsp" %>--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminInsertCategory</title>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");

	InstanceDAO i_dao = new InstanceDAO();

	CategoryDTO ca_dto = new CategoryDTO();
	CategoryDTO ca_dto2 = new CategoryDTO();

	List<CategoryDTO> list = null;

	list = i_dao.getCategory();
	
//	String grp = "";	//카테고리 추가하기전 비교용
//	int grpNo = 0;		//위와 동일
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

	<h1 align="center">Insert & Update Category Page</h1>

<div align="center" style="float:right">
	<h4>현재 카테고리 보기</h4>
	<table border="1">
	<%
	list = i_dao.getCategory();
	
	for(int i=0;i<list.size();i++){
		ca_dto = list.get(i);
		
		if(ca_dto.getCa_level()==0){
		%>
		<tr>
			<td>대분류</td>
			<td><%=ca_dto.getCa_name() %></td>
		</tr>
		<%
	
		
		for(int j=0; j<list.size();j++){
			ca_dto2 = list.get(j);
			
			if(ca_dto2.getCa_level() != 0 & (ca_dto.getCa_grp() == ca_dto2.getCa_grp())){
				System.out.println("AIC.jsp value 비교 dto. dto2. " + ca_dto.getCa_name() + ", "+ca_dto2.getCa_name() );
			
			%>
			<tr>
				<td>소분류</td>
				<td><%=ca_dto2.getCa_name() %></td>
			</tr>
			<%
			}
			}
		}
	}

	
%>
	</table>
</div>

<%-- 카테고리 수정 --%>

	<div align="center" >
		<form action="AdminInsertCategoryPro.jsp" method="post">
		<input type="hidden" name="type" value="update">
			<table border="1">
				<tr>
					<td colspan="2">카테고리 수정</td>
				</tr>
				<tr>
					<td>대분류 수정</td>
					<td>
						<select name="grp">
							<%
							for(int i=0;i<list.size();i++){
								ca_dto=list.get(i);
								if(ca_dto.getCa_level()!=1){
								%>
								<option value="<%=ca_dto.getCa_name() %>"><%=ca_dto.getCa_name() %></option>
								<%
								}
							}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>소분류 수정</td>
					<td>
						<select name="level">
							<%
							for(int i=0; i<list.size();i++){
								ca_dto = list.get(i);
								
								if(ca_dto.getCa_level() == 0){
									%>
									<optgroup label="<%=ca_dto.getCa_name()%>">
									<%
									for(int j=0; j<list.size();j++){
										ca_dto2 = list.get(j);
										if(ca_dto2.getCa_level() != 0 & (ca_dto2.getCa_grp()==ca_dto.getCa_grp())){
											%>
										 	<option value="<%=ca_dto2.getCa_name() %>"><%=ca_dto2.getCa_name() %></option>
											<%  
										}
									}
								}
							}
							%>
							</optgroup>
							<optgroup label="대분류만 수정하기">
								<option value="onlyGrp">대분류 이름만 수정하기</option>
							</optgroup>
						</select>
					</td>
				</tr>
				<tr>
					<td>수정 명</td>
					<td><input type="text" name="update" placeholder="수정하고 싶은 이름">
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="수정">
					</td>
				</tr>
			</table>
		</form>
	</div>

<%-- 한줄띄어쓰기(꾸미기) --%>
<div style="text-align: center">
	<br>
</div>

<%-- 카테고리 추가 --%>
	<div align="center">
		<form action="AdminInsertCategoryPro.jsp" method="post">
		<input type="hidden" name="type" value="insert">
			<table border="1">
				<tr>
					<td colspan="3">카테고리 추가</td>
				</tr>
				<tr>
					<td>대분류</td>
					<td>
						<select name="grp">
					<%
					for(int i=0; i<list.size();i++){
						ca_dto = list.get(i);
						
						if(ca_dto.getCa_level() == 0){
							%>							
								<option value="<%=ca_dto.getCa_name() %>"><%=ca_dto.getCa_name() %></option>
							<%
						}
					}
					%>
						</select>
					</td>
					<td style="width: 100px"><input type="text" name="grpInsert" placeholder="소분류만 추가시 빈칸으로 냅두세요"></td>
				</tr>
				<tr>
					<td>소분류</td>
					<td>
						<select name="level">
							<%
							for(int i=0; i<list.size();i++){
								ca_dto = list.get(i);
								
								if(ca_dto.getCa_level() == 0){
									%>
									<optgroup label="<%=ca_dto.getCa_name()%>">
									<%
									for(int j=0; j<list.size();j++){
										ca_dto2 = list.get(j);
										if(ca_dto2.getCa_level() != 0 & (ca_dto2.getCa_grp()==ca_dto.getCa_grp())){
											%>
										 	<option value="<%=ca_dto2.getCa_name() %>"><%=ca_dto2.getCa_name() %></option>
											<%  
										}
									}
								}
							}
							%>								
									</optgroup>
						</select>
					</td>
					<td><input type="text" name="levelInsert"></td>
				</tr>
				<tr>
					<td colspan="3"> <input type="submit" value="추가"> </td>
				</tr>
			</table>
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