<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminSessionCheck</title>

<!-- Favicon -->
<link href="AdminCSS/img/favicon.ico" rel="icon">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap"
	rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="AdminCSS/lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link
	href="AdminCSS/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
	rel="stylesheet" />

<!-- Customized Bootstrap Stylesheet -->
<link href="AdminCSS/css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<link href="AdminCSS/css/style.css" rel="stylesheet">

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
<div align="center">
<h4 >AdminSessionCheck : <%=aduid %></h4>
</div>
<div align="right">
 <a href="AdminLogout.jsp">로그아웃</a>
</div>
</body>
</html>