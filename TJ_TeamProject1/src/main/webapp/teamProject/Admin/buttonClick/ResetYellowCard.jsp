<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ResetYellowCard</title>
<link href="../../style.css" rel="stylesheet" type="text/css">
</head>
<body onload="getValue()">

	<script type="text/javascript">
		let pInput = opener.document.getElementById("pInput").value;
		console.log("Test : " + pInput);

		function getValue() {
			document.getElementById('cInput').value = opener.document
					.getElementById("pInput").value;

		}
	</script>

	<div>
		<form action="ResetYellowCardPro.jsp" method="post">
			<table>
				<tr>
					<td>현재 ID : <input type="text" id="cInput" name="user_id" readonly="readonly"></td>
				</tr>
				<tr>
					<td>정지해제 하시겠습니까?
					</td>
				</tr>
				<tr>
					<td> <input type="submit" value="확인">
					<input type="button" value="취소"
						onclick="window.close()"></td>
				</tr>
			</table>
		</form>
	</div>


</body>
</html>