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
	<title>받은 후기들</title>
	<jsp:include page="../UIDcheck.jsp"></jsp:include>
	<jsp:include page="../Header.jsp"></jsp:include>
	<jsp:include page='../floatingAdvertisement.jsp'/>
	<link href="../teamstyle.css" rel="stylesheet" type="text/css" />
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
<div class="mypageContent">
	<jsp:include page="MyPageCategory.jsp" />
	<div class="mypagebody" >
		<fieldset>
			<div> 
			<h3 style="display: inline-block;" ><%= uid %> 받은 후기</h3>
			<a href ="ReportReviewList.jsp"  style="float: right; ">작성한 후기로</a></div>
			<table class="MoreReviewTable">
				<tr class="bodylist">
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
						<td colspan="4">글이 없습니다.</td>
					</tr>
			<%	} %>
			</table>
		</fieldset>
		<div class="paging" align="center">
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
</div>
<jsp:include page="../Footer.jsp"></jsp:include>
</body>
</html>