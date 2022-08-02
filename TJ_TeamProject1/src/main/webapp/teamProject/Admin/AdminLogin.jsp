<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminLogin</title>

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet"> 
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="AdminCSS/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="AdminCSS/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="AdminCSS/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="AdminCSS/css/style.css" rel="stylesheet">
</head>
<body>

<div class="container-fluid position-relative d-flex p-0">
<!-- Sign In Start -->
        <div class="container-fluid">
            <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
                <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
                    <div class="bg-secondary rounded p-4 p-sm-5 my-4 mx-3">
                    <form action="AdminLoginPro.jsp" method="post">
                        <div class="d-flex align-items-center justify-content-between mb-3">
                            <a href="AdminMain.jsp" class="">
                                <h3 class="text-primary"><i class="fa fa-user-edit me-2"></i>장물아비 관리자 페이지</h3>
                            </a>

                        </div>
                        <div class="form-floating mb-3">
                            ID<input type="text" name="id" class="form-control" id="floatingInput" placeholder="name@example.com">
                            <label for="floatingInput"></label>
                        </div>
                        <div class="form-floating mb-4">
                           Password <input type="password" name="pw" class="form-control" id="floatingPassword" placeholder="Password">
                            <label for="floatingPassword"></label>
                        </div>
                        <%-- 
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">Check me out</label>
                            </div>
                            <a href="">Forgot Password</a>
                        </div>
                        --%>
                        <button type="submit" class="btn btn-primary py-3 w-100 mb-4">Sign In</button>
                    </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Sign In End -->
        </div>



<%-- 
	<h1>장물아비 어드민 페이지</h1>
<div align="center">
	<form action="AdminLoginPro.jsp" method="post">
		<table>
			<tr>
				<td>AdminId :</td>
				<td><input type="text" name="id"></td>
			</tr>
			<tr>
				<td>AdminPw :</td>
				<td><input type="password" name="pw"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="login"> <input
					type="button" value="go Main" onclick="location.href='../Main.jsp'">
				</td>
			</tr>
		</table>
	</form>
</div>
--%>


	<!-- JavaScript Libraries -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="AdminCSS/lib/chart/chart.min.js"></script>
	<script src="AdminCSS/lib/easing/easing.min.js"></script>
	<script src="AdminCSS/lib/waypoints/waypoints.min.js"></script>
	<script src="AdminCSS/lib/owlcarousel/owl.carousel.min.js"></script>
	<script src="AdminCSS/lib/tempusdominus/js/moment.min.js"></script>
	<script src="AdminCSS/lib/tempusdominus/js/moment-timezone.min.js"></script>
	<script
		src="AdminCSS/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

	<!-- Template Javascript -->
	<script src="AdminCSS/js/main.js"></script>

</body>
</html>