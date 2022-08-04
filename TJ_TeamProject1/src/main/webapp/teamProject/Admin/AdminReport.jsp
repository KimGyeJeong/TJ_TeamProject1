<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team.project.model.UserListDTO"%>
<%@page import="team.project.model.ReportDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--  <%@include file="AdminSessionCheck.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminReport</title>
<link href="../style.css" rel="stylesheet" type="text/css">

</head>
<body>
	<%
	//처리중 rp_pro : 1, 처리완료 2
	request.setCharacterEncoding("UTF-8");

	SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");

	String rp_no = request.getParameter("rp_no");
	GyeJeongDAO dao = new GyeJeongDAO();
	ReportDTO dto = dao.getReport(Integer.parseInt(rp_no));

	//피신고자 정보 가져오기
	UserListDTO dto_user = dao.getUserProfile(dto.getRp_reportedUid());
	%>
	<h4><%=rp_no%></h4>
	
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
			<td colspan="2">신고 내역 확인</td>
		</tr>
		<tr>
			<td>신고 사유</td>
			<td><%=dto.getRp_reason()%></td>
		</tr>
		<tr>
			<td>신고 제목</td>
			<td><%=dto.getRp_title()%></td>
		</tr>
		<tr>
			<td>신고내용</td>
			<td><textarea rows="" cols="" readonly="readonly"><%=dto.getRp_content()%></textarea>
			</td>
		</tr>
		<tr>
			<td>신고자ID</td>
			<td><a href="javascript:goPage('<%=dto.getRp_reportUid()%>');"><%=dto.getRp_reportUid()%></a>
			</td>
		</tr>
		<tr>
			<td>피신고자ID</td>
			<td><a href="javascript:goPage('<%=dto.getRp_reportedUid()%>');">
					<%=dto.getRp_reportedUid()%></a> <script type="text/javascript">
						function goPage(user_id) {
							let f = document.createElement('form');

							let no;
							no = document.createElement('input');
							no.setAttribute('type', 'hidden');
							no.setAttribute('name', 'user_id');
							no.setAttribute('value', user_id);

							f.appendChild(no);
							f.setAttribute('method', 'post');
							f.setAttribute('action', 'AdminShowUser.jsp');

							document.body.appendChild(f);
							f.submit();
						}
					</script></td>
		</tr>
		<tr>
			<td>피신고자 정지상태</td>
			<td>
				<%
				if (dto_user.getUser_activeReg() != null) {
				%> <%=sdf.format(dto_user.getUser_activeReg())%> 까지 정지상태입니다. <%
 } else {
 %> 정지상태가 아닙니다. <%
 }
 %>
			</td>
		</tr>
		<tr>
			<td align="right">유저 상세정보</td>
			<td align="left" colspan="5"><input type="hidden"
				value="<%=dto_user.getUser_id()%>" id="pInput"> <!--  	<input type="button" value="경고" onclick="openChild()">
				<input type="button" value="경고해제" onclick="">--> <input
				type="button" value="활동정지 및 계정정지"
				onclick="openChild('buttonClick/YellowCard.jsp')"> <input
				type="button" value="활동정지 및 계정정지 해제"
				onclick="openChild('buttonClick/ResetYellowCard.jsp')"></td>
		</tr>
		<tr>
			<td>처리중</td>
			<td><form action="AdminReportPro.jsp" method="post">
				<%
				for (int i = 0; i < 3; i++) {
				%> <input type="radio" name="rp_pro"
				value="<%=i%>" <%if (dto.getRp_pro() == i) {%> checked="checked" <%}%>>
				<%
				switch (i) {
					case 0 :
				%>접수중<%
				break;
				case 1 :
				%>처리중<%
				break;
				case 2 :
				%>처리완료<%
				break;
				default :
				%>처리에러<%
				break;
				}
				}
				%>
			</td>
		</tr>
		<tr>
			<td colspan="2">
					<input style="display: none" type="hidden" name="rp_no"
						value="<%=dto.getRp_no()%>"> <input type="submit"
						value="확인">
				</form>
			</td>
		</tr>
	</table>
	</div>

	<script type="text/javascript">
		let openWin;

		function openChild(url) {
			window.name = "parentForm";
			openWin = window.open(url, "ChildPopUp",
					"width=570, height=350, resizable = no, scrollbars = no");
		}
	</script>

</body>
</html>