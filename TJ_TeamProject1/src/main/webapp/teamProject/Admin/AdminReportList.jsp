<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team.project.model.ReportDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@include file="AdminSessionCheck.jsp" %>--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminReportList</title>
</head>
<body>


	<%
	response.setCharacterEncoding("UTF-8");

	SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");

	GyeJeongDAO dao = new GyeJeongDAO();
	List<ReportDTO> list = null;
	ReportDTO dto = null;

	String pageNum = request.getParameter("pageNum");
	if (pageNum == null)
		pageNum = "1";

	int currentPage = Integer.parseInt(pageNum);

	int pageSize = 5;

	int startRow = (currentPage - 1) * pageSize + 1;
	System.out.println("AdminReportList.value startRow : " + startRow);
	int endRow = currentPage * pageSize;
	System.out.println("AdminReportList.value endRow : " + endRow);

	//신고수
	int reportCount = 0;

	//검색
	// 유저 이름으로 검색
	String searchOpt = request.getParameter("searchOpt");

	String search = request.getParameter("search");
	System.out.println("AdminReportList.value search " + search);

	//TODO 주말동안...
	// 신고자, 피신고자로 검색하기... 해결.
	// 신고자, 피신고자가 없어서 null이 발생하는 경우 처리

	if (search == null) {
		reportCount = dao.getReportCount();
		if (reportCount > 0)
			list = dao.getReport(startRow, endRow);
	} else {
		reportCount = dao.getSearchReportCount(search, searchOpt);
		if (reportCount > 0)
			list = dao.getSearchReport(startRow, endRow, search, searchOpt);

	}
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
				<td>신고</td>
				<td>신고사유</td>
				<td>신고제목</td>
				<td>신고자id</td>
				<td>피신고자id</td>
				<td>처리 과정</td>
				<%-- 접수중0, 처리중1, 처리완료2 --%>
				<td>신고 작성시간</td>
			</tr>

			<%
			if (list != null) {
				for (int i = 0; i < list.size(); i++) {
					dto = list.get(i);
			%>
			<tr>
				<td><%=dto.getRp_no()%></td>
				<td><%=dto.getRp_reason()%></td>
				<td>
					<%--	<form action="AdminReport.jsp" name="pageGo" id="pageGo" method="post">
	<input type="hidden" id="rp_no" name="rp_no" value="<%=dto.getRp_no()%>">
  	<a href="#" onclick="javascript:goPage('<%=dto.getRp_no()%>');">
	<a href="JavaScript:goPage(<%=dto.getRp_no()%>)">
	<a href="#" onclick ="goPage(<%=dto.getRp_no()%>)">
	<%=dto.getRp_title() %>
	</a>
	</form>
	
	<a href="#" onclick="pageGo(<%=dto.getRp_no()%>)"><%=dto.getRp_title() %></a>
	--%> <%
 System.out.println("AdminReportList.Value rp_no : " + dto.getRp_no());
 %> <a href="javascript:goPage(<%=dto.getRp_no()%>);"><%=dto.getRp_title()%></a>

					<script type="text/javascript">
						function goPage(rp_no) {
							let f = document.createElement('form');

							let no;
							no = document.createElement('input');
							no.setAttribute('type', 'hidden');
							no.setAttribute('name', 'rp_no');
							no.setAttribute('value', rp_no
							//dto.getrpno() 값이 마지막값이 들어가서 에러.... 문제 해결
							// no.setAttribute('value', rp_no);를 줘야 하는데
							//  no.setAttribute('value', dto.rpno);를 줘서 에러
							);

							f.appendChild(no);
							f.setAttribute('method', 'post');
							f.setAttribute('action', 'AdminReport.jsp');

							document.body.appendChild(f);
							f.submit();
						}
					</script>
				</td>
				<td><%=dto.getRp_reportUid()%></td>
				<td><%=dto.getRp_reportedUid()%></td>
				<td>
					<%
					switch (dto.getRp_pro()) {
					case 0:
					%>접수중<%
					break;
					case 1:
					%>처리중<%
					break;
					case 2:
					%>처리완료<%
					break;
					default:
					%>접수과정에러<%
					break;
					}
					%>
				</td>
				<td><%=sdf.format(dto.getRp_reg())%></td>
			</tr>
			<%
			}
			} else {
			//list == null
			%>
			<tr>
				<td colspan="7">신고내용이없습니다.</td>
			</tr>
			<%
			}
			%>
		</table>
	</div>
	<div align="center">
		<%
		if (reportCount > 0) {
			int pageNumSize = 5;
			int pageCount = reportCount / pageSize + (reportCount % pageNumSize == 0 ? 0 : 1);
			int startPage = (int) ((currentPage - 1) / pageNumSize) * pageNumSize + 1;
			int endPage = startPage + pageNumSize - 1;

			if (endPage > pageCount)
				endPage = pageCount;

			if (startPage > pageNumSize) {
		%>
		<a class="pageNum"
			href="AdminReportList.jsp?pageNum=<%=startPage - 1%>">&lt;&nbsp;</a>
		<%
		}
		for (int i = startPage; i < endPage + 1; i++) {
		%>
		<a class="pageNum" href="AdminReportList.jsp?pageNum=<%=i%>">&nbsp;<%=i%>&nbsp;
		</a>
		<%
		}
		if (endPage < pageCount) {
		%>
		<a class="pageNum"
			href="AdminReportList.jsp?pageNum=<%=startPage + pageNumSize%>">&nbsp;&gt;</a>
		<%
		}

		}
		%>
	</div>

	<div align="center">
		<form action="AdminReportList.jsp">
			<select name="searchOpt">
				<option value="RP_REPORTUID" selected>신고자</option>
				<option value="RP_REPORTEDUID">피신고자</option>
			</select> <input type="text" name="search" /> <input type="submit" value="검색" />
		</form>
		<br />

		<button onclick="window.location='AdminReportList.jsp'">전체
			게시글</button>

	</div>


</body>
</html>