<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 올리는 페이지</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String UID = (String)session.getAttribute("UID");
	int p_status = Integer.parseInt(request.getParameter("p_status"));
	
%>
<body>
<%	if(p_status == 1){ %>
	<form action="ProductSellingPro.jsp" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>상품 제목<br/>
				<input type="text" name="p_title" required /></td>
			</tr>
			<tr>
				<td>상품 사진(상품 프로필사진)<br/>
				<input type="file" name="p_img1" required /><br/>
				</td>
			</tr>
			<tr>
				<td>상품 사진(상세)<br/>
				<input type="file" name="p_img2" /><br/>
				<input type="file" name="p_img3" /><br/>
				<input type="file" name="p_img4" /></td>
			</tr>
			<tr>
				<td>상한가, 하한가 입력<br/>
				<input type="number" name="p_maxPrice" value="상한가 입력"/>&nbsp;~&nbsp;<input type="number" name="p_minPrice" value="하한가 입력"/></td>
			</tr>
			<tr>
				<td><textarea rows="20" cols="100" name="p_content"></textarea></td>
			</tr>
			<tr>
				<td>판매시작, 종료 날짜 입력<br/>
				<input type="date" name="p_start" />&nbsp;~&nbsp;<input type="date" name="p_end" /></td>
			</tr>
			<tr>
				<td>카테고리 선택<br/>
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="작성" />
				<input type="reset" value="초기화" />
				<input type="button" onclick="window.location='../main.jsp'" value="취소" /></td>
			</tr>
		</table>
	</form>

<%	}else{ %>

<%	} %>
</body>
</html>