<%@page import="java.util.List"%>
<%@page import="team.project.model.QnADTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminQnAList</title>
</head>
<body>

<%
	response.setCharacterEncoding("UTF-8");

	SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");

	GyeJeongDAO dao = new GyeJeongDAO();
	List<QnADTO> list = null;
	QnADTO dto = null;

	String pageNum = request.getParameter("pageNum");
	if (pageNum == null)
		pageNum = "1";

	int currentPage = Integer.parseInt(pageNum);

	int pageSize = 5;

	int startRow = (currentPage - 1) * pageSize + 1;
	System.out.println("AdminQnAList.value startRow : " + startRow);
	int endRow = currentPage * pageSize;
	System.out.println("AdminQnAList.value endRow : " + endRow);

	//QnA수
	int qnaCount = 0;

	//검색
	// 유저 이름으로 검색
	String search = request.getParameter("search");
	System.out.println("AdminReportList.value search " + search);


	if (search == null) {
		qnaCount = dao.getQnACount();
		if (qnaCount > 0)
			list = dao.getQnA(startRow, endRow);
	} else {
		qnaCount = dao.getSearchQnACount(search);
		if (qnaCount > 0)
			list = dao.getSearchQnA(startRow, endRow, search);
 
	}
	%>

</body>
</html>