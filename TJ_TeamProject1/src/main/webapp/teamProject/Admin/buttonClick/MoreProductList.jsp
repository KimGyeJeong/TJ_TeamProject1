<%@page import="team.project.model.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MoreProductList</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");

	String user_id = request.getParameter("user_id");

	GyeJeongDAO dao = new GyeJeongDAO();
	List<ProductDTO> list = null;
	ProductDTO dto = null;

	list = dao.getUserProductList(user_id);
	%>
	<h4><%=user_id%></h4>

	<div>
		<table>
			<tr>
				<td>상품 고유 번호</td>
				<td>상품 제목</td>
				<td>게시 날짜</td>
			</tr>
		</table>
	</div>
</body>
</html>