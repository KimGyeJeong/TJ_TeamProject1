<%@page import="team.project.model.CategoryDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team.project.model.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<head>
	<meta charset="UTF-8">
	<title>나의 후기들</title>
	<jsp:include page="../UIDcheck.jsp"></jsp:include>
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<jsp:include page="../Header.jsp"></jsp:include>
	<jsp:include page='../floatingAdvertisement.jsp'/>
	<style type="text/css">
		#mypagelist {
			list-style: none;
			display: inline-block;
		}
		#mypagelist li{
			margin: 20px;
			font-size: 18px;
		}
		#mypagebody{
			position: relative;
			left: 50px;
			display:inline-block;
		}
		#seller p {
			display: inline;
		}
		fieldset {
			display: inline-block;
			width: 500px;	
		}	
	</style>
<%
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
InstanceDAO dao = new InstanceDAO();
List<ReviewDTO> ReportReviewList = dao.getRecentReportReview(uid);	//	이 유저가 한 평가
List<ReviewDTO> ReportedReviewList = dao.getRecentReportedReview(uid);	//	이 유저에 대한 평가
SimpleDateFormat sdf = new SimpleDateFormat("YY-MM-dd");

%>
</head>
<body>
	<h1 style="padding-bottom: 50px; ">&nbsp;</h1>
	
	<ul id="mypagelist">
	  <li><a href="OrderProcessList.jsp"> 구입한 상품 </a></li>
	  <li><a href="MyProductNow.jsp"> 나의 판매중인 상품 </a></li>
	  <li><a href="MyWishList.jsp"> 찜 </a></li>
	  <li><a href="MyReview.jsp"> 나의 후기 </a></li>
	  <li><a href="AddMyMoney.jsp"> 잔액충전 </a></li>
	  <li><a href="MyPageInfo.jsp"> 계정설정 </a></li>
	  <li><a href="../help/inquiryList.jsp"> 나의 문의사항 </a></li>
	  <li><a href="../help/Help.jsp"> 고객센터 </a></li>
	</ul>
<div id="mypagebody" >
	<fieldset>
	<div> <h3 style="display: inline; width: 300px;height: 20px;" ><%= uid %> 받은 후기</h3> <a href ="ReportedReviewList.jsp"  style=" margin-left : 180px; ">더보기</a> </div>
	<table>
		<tr>
			<td>COMMENT</td><td>평점</td><td>작성자</td><td>작성날짜</td>
		</tr>
	<%	for(int i=0 ; i<ReportedReviewList.size() ; i++){ 
			ReviewDTO dto = ReportedReviewList.get(i); %>
		<tr>
			<td><%= dto.getRe_content() %></td><td><%= dto.getRe_stars() %> / 5</td><td><%= dto.getRe_reportUid() %></td><td><%= sdf.format(dto.getRe_reg()) %></td>
		</tr>
	<% 	} %>
	</table>
	</fieldset>
	<fieldset>
	<div><h3 style="display: inline;"><%= uid %> 작성한 후기</h3><a href ="ReportReviewList.jsp"  style=" margin-left : 180px; ">더보기</a> </div>
	<table>
		<tr>
			<td>COMMENT</td><td>평점</td><td>판매자에게</td><td>작성날짜</td>
		</tr>
	<%	for(int i=0 ; i<ReportReviewList.size() ; i++){ 
			ReviewDTO dto = ReportReviewList.get(i); %>
		<tr>
			<td><%= dto.getRe_content() %></td><td><%= dto.getRe_stars() %> / 5</td><td><%= dto.getRe_reportedUid() %></td><td><%= sdf.format(dto.getRe_reg()) %></td>
		</tr>
	<% 	} %>
	</table>
	</fieldset>
</div>
<jsp:include page="../Footer.jsp"></jsp:include>
</body>
</html>