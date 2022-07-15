<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../style.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<br />
	<h2 align="center">문의신청</h2>
	<form action="inquiryPro.jsp" method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<td>제 목</td>
			<td><input type="text" name="subject" /></td>
		</tr>
		<tr>
			<td>카테고리</td>
			<td>
			<select id="category" name="category" size="1">
				<option value="">선택하세요.</option>
				<option value="거래신고">거래신고</option>
				<option value="회원/계정">회원/계정</option>
				<option value="기타서비스">기타서비스</option>
				<option value="오류/신고/제안">오류/신고/제안</option>

			</select>
			</td>
		</tr>
		<tr>
			<td>내 용</td>
			<td><textarea rows="15" cols="50" name="content"></textarea></td>
		</tr>
		<tr>
			<td>이미지첨부1</td>
			<td><input type="file" name="img1" /></td>
		</tr>
		<tr>
			<td>이미지첨부2</td>
			<td><input type="file" name="img2" /></td>
		</tr>
		<tr>
			<td>이미지첨부3</td>
			<td><input type="file" name="img3" /></td>
		</tr>
		<tr>
				<td colspan="2">
					<input type="submit" value="제출하기" />
					<input type="button" value="취소"  onclick="window.location='../Main.jsp'" />
				</td>
			</tr>

	</table>
	</form>
</body>
</html>