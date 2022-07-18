<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminInsertCategoryPro</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");

	GyeJeongDAO dao = new GyeJeongDAO();

	//수정해야할것. 0718
	// 띄어쓰기등 들어올 경우엔...? trim 사용?
	
	String grp = request.getParameter("grp");
	String grpInsert = request.getParameter("grpInsert");
	String level = request.getParameter("level");
	String levelInsert = request.getParameter("levelInsert");
	String update = request.getParameter("update");
	String type = request.getParameter("type");
	
	int result;
	%>

	<%-- 테스트용 출력 --%>
	<h4>
		grp :
		<%=grp%></h4>
	<h4>
		grpInsert :
		<%=grpInsert%></h4>
	<h4>
		level :
		<%=level%></h4>
	<h4>
		levelInsert :
		<%=levelInsert%></h4>
	<h4>
		update :
		<%=update%></h4>
	<h4>
		type :
		<%=type%></h4>

	<%-- Test End --%>
	<%
	if (type.equals("update")) { //카테고리 수정
		if(level.equals("onlyGrp")){//대분류 이름 수정
		//	System.out.println("onlyGrp Test");	//정상 작동
			
			result = dao.updateCatGrp(grp, update);
			response.sendRedirect("AdminInsertCategory.jsp");
			
		}else{	//소분류 이름 수정
			System.out.println("Change level Test");	//정상 작동
			
			result = dao.updateCatLevel(grp, level, update);
			response.sendRedirect("AdminInsertCategory.jsp");
			//여기까지 정상 작동
		}

	} else if (type.equals("insert")) { //카테고리 추가
		if(grpInsert.equals("")){	//소분류 추가
			System.out.println("Only Change Level");	//정상작동
			
			result = dao.insertCatLevel( grp,  levelInsert);
		}else{
			System.out.println("Insert new grp, level ");	//정상작동
			
			result = dao.insertCatGrp(grpInsert, levelInsert);	//정상작동
			
		}

	} else { //타입이 없으면...?

	}
	%>
</body>
</html>