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
		#mypagebody{
			position: relative;
			left: 50px;
			display:inline-block;
		}
		fieldset {
			display: inline-block;
			width: 500px;	
		}	
		#paging * {
			text-decoration: none;
		}
	</style>
<%
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
String pageNum = request.getParameter("p");
InstanceDAO dao = new InstanceDAO();
int totalData = dao.getReportedReviewCount(uid);
if(pageNum==null){
	pageNum = "1";
}
Paging paging = new Paging(totalData, 10, 10, pageNum);
if(paging.getPageN() > paging.getTotalPage()){
	response.sendRedirect("/TJ_TeamProject1/teamProject/mypage/MyReview.jsp");
}
SimpleDateFormat sdf = new SimpleDateFormat("YY-MM-dd");
List<ReviewDTO> ReportedReviewList = dao.getReportedReview(uid , paging.getDataNumberStart() , paging.getDataNumberEnd());	//	이 유저에 대한 평가
%>
</head>
<body>
	<jsp:include page="MyPageCategory.jsp" />
<div id="mypagebody" >
	<fieldset>
	<div> <h3 style="display: inline; width: 300px;height: 20px;" ><%= uid %> 받은 후기</h3><a href ="ReportReviewList.jsp"  style=" margin-left : 150px; ">작성한 후기로</a></div>
	<table>
		<tr>
			<td>COMMENT</td><td>평점</td><td>작성자</td><td>작성날짜</td>
		</tr>
	<%	if(ReportedReviewList != null){
			for(int i=0 ; i<ReportedReviewList.size() ; i++){ 
				ReviewDTO dto = ReportedReviewList.get(i); %>
					<tr>
						<td><%= dto.getRe_content() %></td><td><%= dto.getRe_stars() %> / 5</td><td><%= dto.getRe_reportedUid() %></td><td><%= sdf.format(dto.getRe_reg()) %></td>
					</tr>
		<% 	}
		}else{ %>
			<tr>
				<td>글이 없습니다.</td>
			</tr>
	<%	} %>
	</table>
	</fieldset>
	<div id="paging" align="center">
	<br>
<% 	if(paging.getIslast() > paging.getTotalPage()){
		paging.setIslast(paging.getTotalPage()); 
	}
	if( 1 != paging.getPageN()){ %>
	<a href="ReportedReviewList.jsp?p=<%= paging.getPageN()-1 %>"> < &nbsp; </a>
<%	}	
	for(int i=paging.getIsfirst(); i<=paging.getIslast() ; i++) {
		%>&nbsp;<a href="ReportedReviewList.jsp?p=<%= i %>"><%= i %></a>&nbsp;
<% 	} %>
<% 	if(paging.getTotalPage() != paging.getPageN()){
		if(paging.getIsfirst() != paging.getIslast()){%>
			<a href="ReportedReviewList.jsp?p=<%= paging.getPageN()+1 %>"> &nbsp; >  </a>
<%		}
	}	%>
	</div>
</div>
<jsp:include page="../Footer.jsp"></jsp:include>
</body>
</html>