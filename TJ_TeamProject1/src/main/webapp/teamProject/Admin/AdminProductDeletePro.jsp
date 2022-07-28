<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminProductDeletePro</title>
</head>
<body>
<%
//p delete 값 수정
//노출 --> 숨김 (삭제처리) p_delete 0-->1
//숨김 --> 노출 (삭제취소처리) p_delete 1-->0

request.setCharacterEncoding("UTF-8");

String getNo = request.getParameter("pno");
int getNoInt = Integer.parseInt(getNo);

GyeJeongDAO dao = new GyeJeongDAO();

int result = dao.checkProductDelete(getNoInt);

if(result > 0){	//result == 1 현재 숨김중인 게시글 --> 삭제취소
	dao.invertProductDelete(getNoInt , 0);
}else if(result < 0){
	
}else{	// result ==0 현재 노출중인 게시글 --> 삭제
	dao.invertProductDelete(getNoInt , 1);
	
}
response.sendRedirect("AdminProductList.jsp");
%>
<h4><%=getNo %></h4>

</body>
</html> 