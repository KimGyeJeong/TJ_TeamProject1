<%@page import="java.util.List"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
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

	<%
	request.setCharacterEncoding("UTF-8");

	GyeJeongDAO dao = new GyeJeongDAO();
	ProductDTO dto = null;
	List<ProductDTO> list = null;

	String pageNum = request.getParameter("pageNum");
	if (pageNum == null)
		pageNum = "1";

	int currentPage = Integer.parseInt(pageNum);

	int pageSize = 5;

	int startRow = (currentPage - 1) * pageSize + 1;

	int endRow = currentPage * pageSize;

	int productCount = 0;

	productCount = dao.getProductCount();

	//productNumber 는 필요 없을듯..?	
	int productNumber = productCount - (currentPage - 1) * pageSize;

	//대분류 이름 가져오기
	String catBig = "";
	//소분유 이름 가져오기
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

	<div id="recent" style="display: block;">
		<%
		list = dao.getProductRecent(startRow, endRow);
		%>
		<form>
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
				for (int i = 0; i < list.size(); i++) {
					dto = list.get(i);
				%>
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
					<td><%=dto.getP_delete()%></td>
					<td><a
						href="AdminShowUser.jsp?user_id=<%=dto.getP_sellerId() %>"><%=dto.getP_sellerId()%></a>
					</td>
					<td><a
						href="AdminShowUser.jsp?user_id=<%=dto.getP_buyerId() %>"><%=dto.getP_buyerId()%></a>
					<td><%=dto.getP_start()%></td>
					<td><%=dto.getP_end()%></td>
					<td><%=dto.getP_status()%></td>
					<%--	<td><input type="submit" value="삭제"></td>  --%>
					<td>
						<button type="submit" formaction="AdminProductListPro.jsp"
							formmethod="post">삭제</button>
					</td>
				</tr>
				<%
				}
				%>

			</table>
		</form>
		<div id="insidePageNum" align="center">
			<%
			if (productCount > 0) {
				int pageNumSize = 5;
				int pageCount = productCount / pageSize + (productCount % pageNumSize == 0 ? 0 : 1);
				int startPage = (int) ((currentPage - 1) / pageNumSize) * pageNumSize + 1;
				int endPage = startPage + pageNumSize - 1;

				if (endPage > pageCount)
					endPage = pageCount;
				if(startPage>pageNumSize){
					%>
			<a class="pageNum"
				href="AdminProductList.jsp?pageNum=<%=startPage-1 %>">&lt;&nbsp;</a>
			<%
				}
				for(int i=startPage; i<endPage+1;i++){
					%>
			<a class="pageNum" href="AdminProductList.jsp?pageNum=<%=i%>">&nbsp;<%=i%>&nbsp;
			</a>
			<%
				}
				if(endPage < pageCount){
					%>
			<a class="pageNum"
				href="AdminProductList.jsp?pageNum=<%=startPage + pageNumSize%>">&nbsp;&gt;</a>
			<%
				}
			}
			%>
		</div>
	</div>

	<div id="view" style="display: none;">
		<%
		list = dao.getProductView(startRow, endRow);
		%>
		<form>
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
				for (int i = 0; i < list.size(); i++) {
					dto = list.get(i);
				%>
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
					<td><%=dto.getP_delete()%></td>
					<td><%=dto.getP_sellerId()%></td>
					<td><%=dto.getP_buyerId()%></td>
					<td><%=dto.getP_start()%></td>
					<td><%=dto.getP_end()%></td>
					<td><%=dto.getP_status()%></td>
					<%--	<td><input type="submit" value="삭제"></td>  --%>
					<td>
						<button type="submit" formaction="AdminProductListPro.jsp"
							formmethod="post">삭제</button>
					</td>
				</tr>
				<%
				}
				%>

			</table>
		</form>
		<div id="insidePageNum" align="center">
			<%
			if (productCount > 0) {
				int pageNumSize = 5;
				int pageCount = productCount / pageSize + (productCount % pageNumSize == 0 ? 0 : 1);
				int startPage = (int) ((currentPage - 1) / pageNumSize) * pageNumSize + 1;
				int endPage = startPage + pageNumSize - 1;

				if (endPage > pageCount)
					endPage = pageCount;
				if(startPage>pageNumSize){
					%>
			<a class="pageNum"
				href="AdminProductList.jsp?pageNum=<%=startPage-1 %>">&lt;&nbsp;</a>
			<%
				}
				for(int i=startPage; i<endPage+1;i++){
					%>
			<a class="pageNum" href="AdminProductList.jsp?pageNum=<%=i%>">&nbsp;<%=i%>&nbsp;
			</a>
			<%
				}
				if(endPage < pageCount){
					%>
			<a class="pageNum"
				href="AdminProductList.jsp?pageNum=<%=startPage + pageNumSize%>">&nbsp;&gt;</a>
			<%
				}
			}
			%>
		</div>
	</div>

</body>
</html>