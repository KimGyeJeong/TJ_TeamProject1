<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../style.css" rel="stylesheet" type="text/css" />
<script>
function checkField() {
	let inputs = document.loginForm; 
	if(!inputs.id.value){
		alert("아이디를 입력해주세요.");
		return false; 
	}
	if(!inputs.pw.value){
		alert("비밀번호를 입력해주세요.");
		return false;
	}
}


</script>
<%
if(session.getAttribute("UID") == null){ // 로그인 안했을때 
	
	// 쿠키가 있는지 검사 
	String id = null, pw = null, auto = null; 
	Cookie[] coos = request.getCookies(); 
	if(coos != null){
		for(Cookie c : coos) {
			// 쿠키가 있다면 쿠키에 저장된 값꺼내 변수에 담기
			if(c.getName().equals("autoId")) id = c.getValue();   
			if(c.getName().equals("autoPw")) pw = c.getValue();
			if(c.getName().equals("autoCh")) auto = c.getValue(); 
		}
	}
	
	// 세개 변수에 값이 들어있을 경우 (쿠키 제대로 생성되서 다 갖고 있다.)
	if(auto != null && id != null && pw != null){
		// 로그인 처리되도록 loginPro.jsp 처리 페이지로 이동시키기 
		response.sendRedirect("LoginPro.jsp");
	}

}

%>

</head>
<body>
<br/>
	<%if(session.getAttribute("UID")!=null){%>
		<script>
			alert("이미 로그인상태입니다.");
			window.location="../Main.jsp";
		</script>
		
	<%  }%>
	<h1 align="center"> 로그인페이지</h1>
	<form action="LoginPro.jsp" method="post" name="loginForm" onsubmit="return checkField()" >
	<table >
		<tr >			
			<td>아이디</td>
			<td><input type="text" name="id"/></td>
		</tr>
		<tr>			
			<td>비밀번호</td>
			<td><input type="password" name="pw"/></td>
		</tr>
		<tr>			
			<td colspan="2"><input type="checkbox" name="auto" value="1"/>자동로그인</td>
		</tr>
		<tr>			
			<td colspan="2"><input type="submit" value="로그인"/>
							<input type="button" value="회원가입" onclick="window.location='../SignUp/Agecheck.jsp'"/></td>
		</tr>
		</table>
		</form>

</body>
</html>