<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="AdminSessionCheck.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminNotice</title>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>

	<%-- 공지사항/이벤트 작성 폼 --%>
	<div>
		<form name="notice">
			<table>
				<tr>
					<td colspan="2">공지사항/이벤트 글 작성</td>
				</tr>
				<tr>
					<td>카테고리</td>
					<td><input type="radio" name="no_cat" value="notice"
						checked="checked">공지사항 <input type="radio" name="no_cat"
						value="event">이벤트</td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" name="no_title"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea cols="50" rows="15" name="no_content"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="reset" value="초기화">
						<input type="button" value="작성 취소"
						onclick="location.href='AdminMain.jsp'">
						<button type="submit" formaction="AdminNoticeTempPro.jsp"
							formmethod="post">임시저장</button>
						<button type="submit" formaction="AdminNoticePro.jsp"
							formmethod="post">저장</button></td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>