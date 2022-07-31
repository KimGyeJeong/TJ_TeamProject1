<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminSessionCheck</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id");
String pw = request.getParameter("pw");

String aduid = (String)session.getAttribute("adminId");
if(session.getAttribute("adminId")==null){
	aduid = (String)session.getAttribute("adminId");
	System.out.println("AdminSessionCheck session.value adminId is : "+aduid);
	if(aduid != null){
		//이게 출력되면 오류
		System.out.println("AdminSessionCheck is not null");
	}else{
		System.out.println("AdminSessionCheck is null");
		%>
		<script type="text/javascript">
		alert("로그인이 필요합니다.\n로그인페이지로이동합니다.");
		//location.href="AdminLogin.jsp";
		location.href="/TJ_TeamProject1/teamProject/Admin/AdminLogin.jsp";
		</script>
		<%
		//response.sendRedirect("AdminLogin.jsp");
	}
}

%>
<h4><%=aduid %></h4>

</body>
</html>