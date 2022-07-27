<%@page import="team.project.dao.Paging"%>
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
	<title>내가 작성한 후기들</title>
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
		fieldset {
			display: inline-block;
			width: 500px;	
		}	
	</style>
<%
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
String pageNum = request.getParameter("p");
if(pageNum==null){
	pageNum = "1";
}
InstanceDAO dao = new InstanceDAO();
SimpleDateFormat sdf = new SimpleDateFormat("YY-MM-dd");
int totalData = dao.getReportedReviewCount(uid);
Paging paging = new Paging(totalData, 10, 10, pageNum);
List<ReviewDTO> ReportedReviewList = dao.getReportedReview(uid , paging.getDataNumberStart() , paging.getDataNumberEnd());	//	이 유저에 대한 평가
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
	<div> <h3 style="display: inline; width: 300px;height: 20px;" ><%= uid %>님과의 최근 거래경험담</h3> <a href ="ReportedReviewList.jsp"  style=" margin-left : 180px; ">더보기</a> </div>
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
<% 	if(paging.getIsfirst() != 1){ %>
	<a href="location='ReprotedReviewList.jsp?p=<%= paging.getIsfirst()-1 %>'"></a>
<%	}	%>
<% 	if(paging.getIslast() != 1){ %>
	<a href="location='ReprotedReviewList.jsp?p=<%= paging.getIsfirst()-1 %>'"></a>
<%	}	%>
</div>
<jsp:include page="../Footer.jsp"></jsp:include>
</body>
</html>