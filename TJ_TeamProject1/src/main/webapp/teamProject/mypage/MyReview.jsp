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
InstanceDAO dao = new InstanceDAO();
List<ReviewDTO> ReportReviewList = dao.getRecentReportReview(uid);	//	이 유저가 한 평가
List<ReviewDTO> ReportedReviewList = dao.getRecentReportedReview(uid);	//	이 유저에 대한 평가
SimpleDateFormat sdf = new SimpleDateFormat("YY-MM-dd");

%>
</head>
<body>
	<jsp:include page="MyPageCategory.jsp" />
<div id="mypagebody" >
	<fieldset>
	<div> <h3 style="display: inline; width: 300px;height: 20px;" ><%= uid %> 받은 후기</h3> <a href ="ReportedReviewList.jsp"  style=" margin-left : 180px; ">더보기</a> </div>
	<table>
		<tr>
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
				<td>글이 없습니다.</td>
			</tr>	
	<% 	} %>	
	</table>
	</fieldset>
	<fieldset>
	<div><h3 style="display: inline;"><%= uid %> 작성한 거래후기</h3><a href ="ReportReviewList.jsp"  style=" margin-left : 180px; ">더보기</a> </div>
	<table>
		<tr>
			<td>COMMENT</td><td>평점</td><td>판매자에게</td><td>작성날짜</td>
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
			<td>글이 없습니다.</td>
		</tr>	
	<% 	} %>	
	</table>
	</fieldset>
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