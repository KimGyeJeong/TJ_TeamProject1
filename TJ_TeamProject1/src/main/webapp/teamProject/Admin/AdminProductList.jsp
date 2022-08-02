<%@page import="java.util.List"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%--  <%@include file="AdminSessionCheck.jsp" %> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminProductList</title>
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
	<div align="center">
		<%
		//TODO
		//신고자, 피신고자 null 확인
		request.setCharacterEncoding("UTF-8");

		GyeJeongDAO dao = new GyeJeongDAO();
		ProductDTO dto = null;
		List<ProductDTO> list = null;

		String result = "삭제";

		String pageNum = request.getParameter("pageNum");
		if (pageNum == null)
			pageNum = "1";

		int currentPage = Integer.parseInt(pageNum);

		int pageSize = 5;

		int startRow = (currentPage - 1) * pageSize + 1;

		int endRow = currentPage * pageSize;

		int productCount = 0;

		String searchOpt = request.getParameter("searchOpt");
		String search = request.getParameter("search");

		if (search == null)
			productCount = dao.getProductCount();
		else
			productCount = dao.getProductSearchCount(search, searchOpt);

		//productNumber 는 필요 없을듯..?	
		int productNumber = productCount - (currentPage - 1) * pageSize;

		//대분류 이름 가져오기
		String catBig = "";
		//소분류 이름 가져오기
		String catSmall = "";
		%>

		<input type="button" value="view"
			onclick="
    let view = document.querySelector('#view');
    let recent = document.querySelector('#recent');

    if (this.value === 'recent') {
        view.style.display = 'none';
        recent.style.display = 'block';
        this.value = 'view';
    } else {
        view.style.display = 'block';
        recent.style.display = 'none';
        this.value = 'recent';
    }
    ">



		<div id="recent" style="display: block; margin-right: auto">
			<%
			if (search == null) {
				if (productCount > 0)
					list = dao.getProductRecent(startRow, endRow);
			} else {
				if (productCount > 0)
					list = dao.getProductSearchRecent(startRow, endRow, search, searchOpt);
			}
			%>
			<%-- <form action="AdminProductDeletePro.jsp" method="post">--%>
			<table>
				<tr>
					<td>최근 등록순</td>
				</tr>
				<tr>
					<td>상품고유번호</td>
					<td>일반/입찰 판매</td>
					<td>상품 제목</td>
					<td>가격</td>
					<td>(최소가격)</td>
					<td>(최대가격)</td>
					<td>카테고리 대분류</td>
					<td>카테고리 소분류</td>
					<td>게시 날짜</td>
					<td>게시물 삭제(노출/숨김)</td>
					<td>판매자ID</td>
					<td>구매자ID</td>
					<td>판매 시작일</td>
					<td>판매 종료일</td>
					<td>판매 진행 상태</td>
				</tr>

				<%
				if (list != null) {

					for (int i = 0; i < list.size(); i++) {
						dto = list.get(i);
				%>
				<tr style="">
					<td><input type="hidden" value="<%=dto.getP_no()%>">
					</td>
				</tr>
				<tr>
					<td><%=dto.getP_no()%></td>
					<td>
						<%
						if (dto.getP_status() < 1) {
						%> 일반 거래 <%
						} else {
						%> 입찰 거래 <%
						}
						%>
					</td>
					<td><a
						href="../selPage/ProductDetailBuyForm.jsp?p_no=<%=dto.getP_no()%>"
						target="_blank"> <%=dto.getP_title()%></a></td>
					<td><%=dto.getP_price()%></td>
					<td><%=dto.getP_minPrice()%></td>
					<td><%=dto.getP_maxPrice()%></td>
					<td>
						<%
						//카테고리값 가져가서 대분류카테고리 이름 가져오기
						catBig = dao.getProductCatBig(dto.getCa_no());
						%> <%=catBig%>
					</td>
					<td>
						<%
						catSmall = dao.getProductCatSmall(dto.getCa_no());
						%> <%=catSmall%>
					</td>
					<td><%=dto.getP_reg()%></td>
					<td>
						<%
						if (dto.getP_delete() > 0) {
						%> 삭제처리(숨김) <%
						} else {
						%> 정상처리(노출) <%
						}
						%>
					</td>
					<td><a
						href="AdminShowUser.jsp?user_id=<%=dto.getP_sellerId()%>"><%=dto.getP_sellerId()%></a>
					</td>
					<td><a
						href="AdminShowUser.jsp?user_id=<%=dto.getP_buyerId()%>"><%=dto.getP_buyerId()%></a>
					<td><%=dto.getP_start()%></td>
					<td><%=dto.getP_end()%></td>
					<td>
						<%
						switch (dto.getP_finish()) {
						case 0:
						%>판매중<%
						break;
						case 1:
						%>판매완료<%
						break;
						case 2:
						%>거래중지<%
						break;
						case 3:
						%>거래시간종료<%
						break;

						default:
						%>거래번호 에러<%
						break;

						}
						%>
					</td>
					<%--	<td><input type="submit" value="삭제"></td>  --%>
					<td>
						<%--  	<button type="submit" formaction="AdminProductDeletePro.jsp?pno=<%=dto.getP_no() %>"
							formmethod="get">삭제</button>--%> <%-- Here0725 Test --%>
						<form action="AdminProductDeletePro.jsp" method="post">
							<input type="hidden" value="<%=dto.getP_no()%>" name="pno">
							<%
							if (dto.getP_delete() == 1)
								result = "삭제취소";
							else
								result = "삭제";
							%>
							<input type="submit" value="<%=result%>">
						</form>

					</td>
				</tr>
				<%
				System.out.println("ProductList.Recent dto.pno " + dto.getP_no());
				}
				} else {
				%>
				<tr>
					<td colspan="15">글이 없습니다.</td>
				</tr>
				<%
				}
				%>

			</table>
			<%--	</form> 삭제하기..--%>
			<div id="insidePageNum" align="center">
				<%
				if (productCount > 0) {
					int pageNumSize = 5;
					int pageCount = productCount / pageSize + (productCount % pageNumSize == 0 ? 0 : 1);
					int startPage = (int) ((currentPage - 1) / pageNumSize) * pageNumSize + 1;
					int endPage = startPage + pageNumSize - 1;

					if (endPage > pageCount)
						endPage = pageCount;
					if (startPage > pageNumSize) {
						if (search != null) {
				%>
				<a class="pageNum"
					href="AdminProductList.jsp?pageNum=<%=startPage - 1%>&searchOpt=<%=searchOpt%>&search=<%=search%>">&lt;
					&nbsp;</a>
				<%
				} else {
				%>
				<a class="pageNum"
					href="AdminProductList.jsp?pageNum=<%=startPage - 1%>">&lt;
					&nbsp;</a>
				<%
				}
				} // startPage > pageNumSize

				for (int i = startPage; i < endPage + 1; i++) {
				if (search != null) {
				%>
				<a class="pageNum"
					href="AdminProductList.jsp?pageNum=<%=i%>&searchOpt=<%=searchOpt%>&search=<%=search%>">&nbsp;
					<%=i%> &nbsp;
				</a>
				<%
				} else {
				%>
				<a class="pageNum" href="AdminProductList.jsp?pageNum=<%=i%>">&nbsp;
					<%=i%> &nbsp;
				</a>
				<%
				}
				} //for

				if (endPage < pageCount) {
				if (search != null) {
				%>
				<a class="pageNum"
					href="AdminProductList.jsp?pageNum=<%=startPage + pageNumSize%>&searchOpt=<%=searchOpt%>&search=<%=search%>">&nbsp;
					&gt; </a>
				<%
				} else {
				%>
				<a class="pageNum"
					href="AdminProductList.jsp?pageNum=<%=startPage + pageNumSize%>">&nbsp;
					&gt; </a>
				<%
				}
				}
				}
				%>
			</div>
			<div align="center">
				<form action="AdminProductList.jsp">
					<select name="searchOpt">
						<option value="p_sellerid" selected>판매자</option>
						<option value="p_buyerid">구매자</option>
					</select> <input type="text" name="search" placeholder="유저ID로 찾기"> <input
						type="submit" value="검색">
				</form>
			</div>
		</div>

		<div id="view" style="display: none; margin-right: auto">
			<%
			if (search == null) {
				if (productCount > 0)
					list = dao.getProductView(startRow, endRow);
			} else {
				if (productCount > 0)
					list = dao.getProductSearchView(startRow, endRow, search);
			}
			%>
			<table>
				<tr>
					<td>최다 조회순</td>
				</tr>
				<tr>
					<td>상품고유번호</td>
					<td>일반/입찰 판매</td>
					<td>상품 제목</td>
					<td>가격</td>
					<td>(최소가격)</td>
					<td>(최대가격)</td>
					<td>카테고리 대분류</td>
					<td>카테고리 소분류</td>
					<td>게시 날짜</td>
					<td>게시물 삭제(노출/숨김)</td>
					<td>판매자ID</td>
					<td>구매자ID</td>
					<td>판매 시작일</td>
					<td>판매 종료일</td>
					<td>판매 진행 상태</td>
				</tr>

				<%
				if (list != null) {
					for (int i = 0; i < list.size(); i++) {
						dto = list.get(i);
				%>
				<tr>
					<td><input type="hidden" value="<%=dto.getP_no()%>"
						name="pno"></td>
				</tr>
				<tr>
					<td><%=dto.getP_no()%></td>
					<td>
						<%
						if (dto.getP_status() < 1) {
						%> 일반 거래 <%
						} else {
						%> 입찰 거래 <%
						}
						%>
					</td>
					<td><%=dto.getP_title()%></td>
					<td><%=dto.getP_price()%></td>
					<td><%=dto.getP_minPrice()%></td>
					<td><%=dto.getP_maxPrice()%></td>
					<td>
						<%
						//카테고리값 가져가서 대분류카테고리 이름 가져오기
						catBig = dao.getProductCatBig(dto.getCa_no());
						%> <%=catBig%>
					</td>
					<td>
						<%
						catSmall = dao.getProductCatSmall(dto.getCa_no());
						%> <%=catSmall%>
					</td>
					<td><%=dto.getP_reg()%></td>
					<td>
						<%
						if (dto.getP_delete() > 0) {
						%> 삭제처리(숨김) <%
						} else {
						%> 정상처리(노출) <%
						}
						%>
					</td>
					<td><a
						href="AdminShowUser.jsp?user_id=<%=dto.getP_sellerId()%>"><%=dto.getP_sellerId()%></a>
					</td>
					<td><a
						href="AdminShowUser.jsp?user_id=<%=dto.getP_buyerId()%>"><%=dto.getP_buyerId()%></a>
					<td><%=dto.getP_start()%></td>
					<td><%=dto.getP_end()%></td>
					<td>
						<%
						switch (dto.getP_status()) {
						case 0:
						%>판매중<%
						break;
						case 1:
						%>판매완료<%
						break;
						case 2:
						%>거래중지<%
						break;
						case 3:
						%>거래시간종료<%
						break;

						default:
						%>거래번호 에러<%
						break;

						}
						%>
					</td>
					<%--	<td><input type="submit" value="삭제"></td>  
					 		<td>
						<button type="submit" formaction="AdminProductDeletePro.jsp?pno=<%=dto.getP_no() %>"
							formmethod="get">삭제</button>--%>
					<td>
						<form action="AdminProductDeletePro.jsp" method="post">
							<input type="hidden" value="<%=dto.getP_no()%>" name="pno">
							<%
							if (dto.getP_delete() == 1)
								result = "삭제취소";
							else
								result = "삭제";
							%>
							<input type="submit" value="<%=result%>">
						</form>
					</td>
				</tr>

				<%
				System.out.println("ProductList.View dto.pno " + dto.getP_no());
				}
				} else {
				%>
				<tr>
					<td colspan="15">글이 없습니다.</td>
				</tr>
				<%
				}
				%>

			</table>

			<div id="insidePageNum" align="center">
				<%
				if (productCount > 0) {
					int pageNumSize = 5;
					int pageCount = productCount / pageSize + (productCount % pageNumSize == 0 ? 0 : 1);
					int startPage = (int) ((currentPage - 1) / pageNumSize) * pageNumSize + 1;
					int endPage = startPage + pageNumSize - 1;

					if (endPage > pageCount)
						endPage = pageCount;
					if (startPage > pageNumSize) {
						if (search != null) {
				%>
				<a class="pageNum"
					href="AdminProductList.jsp?pageNum=<%=startPage - 1%>&searchOpt=<%=searchOpt%>&search=<%=search%>">&lt;
					&nbsp;</a>
				<%
				} else {
				%>
				<a class="pageNum"
					href="AdminProductList.jsp?pageNum=<%=startPage - 1%>">&lt;
					&nbsp;</a>
				<%
				}
				} // startPage > pageNumSize

				for (int i = startPage; i < endPage + 1; i++) {
				if (search != null) {
				%>
				<a class="pageNum"
					href="AdminProductList.jsp?pageNum=<%=i%>&searchOpt=<%=searchOpt%>&search=<%=search%>">&nbsp;
					<%=i%> &nbsp;
				</a>
				<%
				} else {
				%>
				<a class="pageNum" href="AdminProductList.jsp?pageNum=<%=i%>">&nbsp;
					<%=i%> &nbsp;
				</a>
				<%
				}
				} //for

				if (endPage < pageCount) {
				if (search != null) {
				%>
				<a class="pageNum"
					href="AdminProductList.jsp?pageNum=<%=startPage + pageNumSize%>&searchOpt=<%=searchOpt%>&search=<%=search%>">&nbsp;
					&gt; </a>
				<%
				} else {
				%>
				<a class="pageNum"
					href="AdminProductList.jsp?pageNum=<%=startPage + pageNumSize%>">&nbsp;
					&gt; </a>
				<%
				}
				}
				}
				%>
			</div>
			<div align="center">
				<form action="AdminProductList.jsp">
					<select name="searchOpt">
						<option value="p_sellerid" selected>판매자</option>
						<option value="p_buyerid">구매자</option>
					</select> <input type="text" name="search" placeholder="유저ID로 찾기"> <input
						type="submit" value="검색">
				</form>
			</div>
		</div>

		<div>
			<h4>footer...</h4>
		</div>
	</div>
</body>
</html>
