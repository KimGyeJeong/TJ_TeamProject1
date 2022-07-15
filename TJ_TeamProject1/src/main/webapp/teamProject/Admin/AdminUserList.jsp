<%@page import="java.util.List"%>
<%@page import="team.project.model.UserListDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminUserList</title>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
	GyeJeongDAO dao = new GyeJeongDAO();
	UserListDTO dto = null;
	List<UserListDTO> list = null;

	String pageNum = request.getParameter("pageNum");
	if (pageNum == null)
		pageNum = "1";

	int currentPage = Integer.parseInt(pageNum);

	int pageSize = 5; //값 그때그때 수정시키고싶은데...

	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = startRow * pageSize;

	//유저 수 계산해서 넣어줄 변수
	int userCount = 0;

	//검색
	// 유저 이름으로 검색
	String search = request.getParameter("search");

	/*
	if (search == null)
		search = "";
	*/
	//이름으로 검색
	if (search != null) {
		userCount = dao.getUserSearchCount(search);
		if(userCount>0)
			list = dao.getUserSearch(startRow, endRow, search);
	} else {
		userCount = dao.getUserCount();
	}

	//추가 옵션
	//#1.특정기간내
	//#2.활성화 or 비활성화
	//#3.경고유저 확인
	%>

</body>
</html>