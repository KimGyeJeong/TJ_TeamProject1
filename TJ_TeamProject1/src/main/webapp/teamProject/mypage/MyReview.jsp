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
	<jsp:include page="../Header.jsp"></jsp:include>
	<jsp:include page='../floatingAdvertisement.jsp'/>
	<link href="../teamstyle.css" rel="stylesheet" type="text/css" />
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
<div class="mypageContent">
	<jsp:include page="MyPageCategory.jsp" />
	<div class="mypagebody">
		<fieldset style="width: 45%; display: inline-block;">
			<div>
				<h3 style="display: inline-block;"><%= uid %>최근 받은 후기</h3>  
				<a href ="ReportedReviewList.jsp" style="float: right;">더보기</a>  
			</div>
			<table class="ReviewTable" >
				<tr class="bodylist">
					<td>COMMENT</td><td>평점</td><td>작성자</td><td>작성날짜</td>
				</tr>
			<% 	if(ReportedReviewList != null){ %>
				<%	for(int i=0 ; i<ReportedReviewList.size() ; i++){ 
						ReviewDTO dto = ReportedReviewList.get(i); %>
					<tr>
						<td><%= dto.getRe_content() %></td><td><%= dto.getRe_stars() %> / 5</td><td><%= dto.getRe_reportUid() %></td><td><%= sdf.format(dto.getRe_reg()) %></td>
					</tr>
				<% 	} %>
			<% 	}else{ %>
					<tr>
						<td colspan="4">글이 없습니다.</td>
					</tr>	
			<% 	} %>	
			</table>
		</fieldset>
		<fieldset style="width: 45%; display: inline-block ;">
			<div>
				<h3 style="display: inline-block;"><%= uid %>최근 작성한 거래후기</h3>
				<a href ="ReportReviewList.jsp" style="float: right;">더보기</a>
			</div>
			<table class="ReviewTable" >
				<tr class="bodylist">
					<td>COMMENT</td><td>평점</td><td>판매자</td><td>작성날짜</td>
				</tr>
			<% if(ReportReviewList != null){ %>	
				<%	for(int i=0 ; i<ReportReviewList.size() ; i++){ 
						ReviewDTO dto = ReportReviewList.get(i); %>
					<tr>
						<td><%= dto.getRe_content() %></td><td><%= dto.getRe_stars() %> / 5</td><td><%= dto.getRe_reportedUid() %></td><td><%= sdf.format(dto.getRe_reg()) %></td>
					</tr>
				<% 	} %>
			<% 	}else{ %>
				<tr>
					<td colspan="4">글이 없습니다.</td>
				</tr>	
			<% 	} %>	
			</table>
		</fieldset>
	</div>
</div>
<jsp:include page="../Footer.jsp"></jsp:include>
<script type="text/javascript">
function WriteReview(uri){
	let properties = "top=100 , left=600 , width=1000, height=800, "; 
	properties += "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no";
	window.open(uri,"WriteReview",properties);
}
</script>
</body>
</html>