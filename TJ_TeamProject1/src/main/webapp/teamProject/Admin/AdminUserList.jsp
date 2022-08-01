<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="team.project.model.UserListDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="AdminSessionCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminUserList</title>
<link href="../style.css" rel="stylesheet" type="text/css">
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
<div>
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
	<div>
		<form action="AdminUserList.jsp">
			<input type="text" name="search" placeholder="유저ID로 찾기">
			<input type="submit" value="검색"> 
		</form>
	</div>
</body>
</html>