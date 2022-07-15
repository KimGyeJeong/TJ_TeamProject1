<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function a() {
		new daum.Postcode({
			oncomplete : function(data) {
				document.querySelector("#zipcode").value = data.zonecode;
				document.querySelector("#address1").value = data.address
			}
		}).open();
	}
</script>
<title>Insert title here</title>
<link href="../style.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<br />
	<h1 align="center">회원가입</h1>
	<form action="SignUpPro.jsp" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>아이디 *</td>
				<td><input type="text" name="id" /></td>
			</tr>

			<tr>
				<td>비밀번호 *</td>
				<td><input type="password" name="pw" /></td>
			</tr>
			<tr>
				<td>비밀번호 확인 *</td>
				<td><input type="password" name="pwch" /></td>
			</tr>

			<tr>
				<td>이름 *</td>
				<td><input type="text" name="name" /></td>
			</tr>

			<tr>
				<td>email</td>
				<td><input type="text" name="email" /></td>
			</tr>
			<tr>
				<td>phone</td>
				<td><input type="text" name="phone" /></td>
			</tr>
			<tr>
				<td>배송지명 *</td>
				<td><input type="text" name="addressName" /></td>
			</tr>
			<tr>
				<td width="200">우편번호</td>
				<td><input type="text" name="zipcode" id="zipcode" size="7">
					<input type="button" onclick="a()" value="우편번호찾기"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="address1" id="address1" size="70">
				</td>
			</tr>
			<tr>

				<td>상세주소</td>
				<td><input type="text" name="address2" id="address2" size="70">
				</td>
			</tr>
			<tr>
				<td>photo</td>
				<td><input type="file" name="photo" /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="회원 가입" /> <input
					type="reset" value="재작성" /> <input type="button" value="취소"
					onclick="window.location='main.jsp'" /></td>
			</tr>
		</table>
	</form>

</body>
</html> 