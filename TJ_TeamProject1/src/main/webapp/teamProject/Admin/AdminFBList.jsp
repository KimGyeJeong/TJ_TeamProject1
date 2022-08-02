<%@page import="java.util.List"%>
<%@page import="team.project.model.ContentDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminFBList</title>
</head>
<body>

<%-- 
<h4>TODO. 자유게시판 보는것 구현. 및 삭제 가능하게. productlist 참조</h4>
--%>
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
ContentDTO dto = null;
List<ContentDTO> list = null;

int result = dao.getFBcount();

String pageNum = request.getParameter("pageNum");
if (pageNum == null)
	pageNum = "1";

int currentPage = Integer.parseInt(pageNum);

int pageSize = 5;

int startRow = (currentPage - 1) * pageSize + 1;

int endRow = currentPage * pageSize;

int fbCount = 0;

String search = request.getParameter("search");

if (search == null)
	fbCount = dao.getFBcount();
else
	fbCount = dao.getFBcount(search);

//productNumber 는 필요 없을듯..?	
int fbNumber = fbCount - (currentPage - 1) * pageSize;

if(search == null){
	if(fbCount > 0)
		list = dao.getFBlist(startRow, endRow);
}else{
	if(fbCount>0)
		list = dao.getFBlist(startRow, endRow, search);
}

%>

<h4>result = <%=result %></h4>

<div align="center" id="FBlist">
	<table>
	<tr>
	<td>게시판 고유번호</td>
	<td>제목</td>
	<td>작성자</td>
	<td>작성시간</td>
	<td>조회수</td>
	<td>삭제</td>
	</tr>
	<%if(list != null){
		for(int i=0;i<list.size();i++){
			dto = list.get(i);
			%>
			<tr>
			<td><%=dto.getC_no() %></td>
			<td>
			<a href="AdminFBContent.jsp?cno=<%=dto.getC_no()%>"><%=dto.getC_title() %></a>
			</td>
			<td><%=dto.getUser_id() %></td>
			<td><%=dto.getC_reg() %></td>
			<td><%=dto.getC_readcount() %></td>
			<td>
			<form action="AdminFBDeletePro.jsp" method="post">
				<input type="hidden" value="<%=dto.getC_no()%>" name="cno">
				<input type="submit" value="삭제">
			</form>
			</td>
			</tr>
			<%
		}
	}else{
	%>
	<tr>
		<td colspan="6">글이 없습니다.</td>
		</tr>
	<%
	}%>
	</table>
</div>

<div align="center" id="searchHere">
				<%
				if (fbCount > 0) {
					int pageNumSize = 5;
					int pageCount = fbCount / pageSize + (fbCount % pageNumSize == 0 ? 0 : 1);
					int startPage = (int) ((currentPage - 1) / pageNumSize) * pageNumSize + 1;
					int endPage = startPage + pageNumSize - 1;

					if (endPage > pageCount)
						endPage = pageCount;
					if (startPage > pageNumSize) {
						if (search != null) {
				%>
				<a class="pageNum"
					href="AdminFBList.jsp?pageNum=<%=startPage - 1%>&search=<%=search%>">&lt;
					&nbsp;</a>
				<%
				} else {
				%>
				<a class="pageNum"
					href="AdminFBList.jsp?pageNum=<%=startPage - 1%>">&lt;
					&nbsp;</a>
				<%
				}
				} // startPage > pageNumSize

				for (int i = startPage; i < endPage + 1; i++) {
				if (search != null) {
				%>
				<a class="pageNum"
					href="AdminFBList.jsp?pageNum=<%=i%>&search=<%=search%>">&nbsp;
					<%=i%> &nbsp;
				</a>
				<%
				} else {
				%>
				<a class="pageNum" href="AdminFBList.jsp?pageNum=<%=i%>">&nbsp;
					<%=i%> &nbsp;
				</a>
				<%
				}
				} //for

				if (endPage < pageCount) {
				if (search != null) {
				%>
				<a class="pageNum"
					href="AdminFBList.jsp?pageNum=<%=startPage + pageNumSize%>&search=<%=search%>">&nbsp;
					&gt; </a>
				<%
				} else {
				%>
				<a class="pageNum"
					href="AdminFBList.jsp?pageNum=<%=startPage + pageNumSize%>">&nbsp;
					&gt; </a>
				<%
				}
				}
				}
				%>
</div>
<div align="center" id="pageNumberHere">
	<form action="AdminFBList.jsp">
	<input type="text" name="search" placeholder="유저 id로 찾기">
	<input type="submit" value="검색"> 
	
	</form>

</div>

</body>
</html>