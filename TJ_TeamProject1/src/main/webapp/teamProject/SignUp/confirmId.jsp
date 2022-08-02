<%@page import="team.project.dao.LeeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>confirmId.jsp</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>

	<h1>중복 확인 팝업</h1>

	<%
	//open(url..) : url = confirmId.jsp?id=값
	//id 에 있는 값 저장
	String id = request.getParameter("id");
	//DB 연결해서 사용자가 작성한 id값이 db테이블에 존재하는지 검사
	LeeDAO dao = new LeeDAO();
	boolean result = dao.confimId(id); //true 이미 존재, false 존재하지않음 --> 사용가능
  
	if (result) { //true -> 이미 존재 -> 사용 불가
	%>
	<table>
		<tr>
			<td><%=id%>은/는 이미 사용중인 아이디 입니다.</td>
		</tr>
	</table>
	<form action="confirmId.jsp" method="post">
		<table>
			<tr>
				<td>다른 아이디를 입력하세요.<br /> <input type="text" name="id"><input
					type="submit" value="ID중복확인">
				</td>
			</tr>
		</table>
	</form>
	<%
	} else { //false -> 존재 x -> 사용 가능
	%>
	<table>
		<tr>
			<td><%=id%> 은/는 사용가능합니다<br /> <input type="button" value="닫기"
				onclick="setId()"></td>
		</tr>
	</table>
	<h2></h2>

	<%	
	}
	%>
	<script type="text/javascript">
		function setId() {
			// 팝업을 열어준 원래페이지의 id input태그의 value를
			// 최종 사용할 id로 변경
			opener.document.SignUpForm.id.value = "<%=id%>";
			//현재 팝업 닫기
			self.close();
		}
	</script>

</body>
</html>