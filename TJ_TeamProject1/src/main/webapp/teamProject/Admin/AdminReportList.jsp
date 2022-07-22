<%@page import="team.project.model.ReportDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminReportList</title>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
	response.setCharacterEncoding("UTF-8");
	
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
	
	
	if(search == null){
		reportCount = dao.getReportCount();
		if(reportCount>0)
			list = dao.getReport(startRow, endRow);
	}else{
		reportCount = dao.getSearchReportCount(search, searchOpt);
		if(reportCount>0)
			list = dao.getSearchReport(startRow, endRow, search, searchOpt);
		
	}
	
	for(int i=0;i<list.size();i++){
		dto = list.get(i);
		%>
		Title : <%=dto.getRp_title() %>
		<%
	}
	%>






<div>
<form action="AdminReportList.jsp">
			<select name="searchOpt">
				<option value="RP_REPORTUID" selected>신고자</option>
				<option value="RP_REPORTEDUID">피신고자</option>
			</select>
			<input type="text" name="search" /> 
			<input type="submit" value="검색" />
		</form>
		<br />
		
		<button onclick="window.location='AdminReportList.jsp'"> 전체 게시글 </button>
	
</div>

</body>
</html>