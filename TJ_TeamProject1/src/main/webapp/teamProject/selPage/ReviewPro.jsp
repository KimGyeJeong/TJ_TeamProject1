<%@page import="team.project.model.ReviewDTO"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.dao.BeomSuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String UID = (String)session.getAttribute("UID");
	int p_no = Integer.parseInt(request.getParameter("p_no"));
	BeomSuDAO dao = new BeomSuDAO();
	ProductDTO proDTO = dao.productDetailBuy(p_no);
	if(UID.equals(proDTO.getP_buyerId())){
	int re_stars = Integer.parseInt(request.getParameter("re_stars"));
	String re_content = request.getParameter("re_content");
	ReviewDTO reDTO = new ReviewDTO();
	reDTO.setRe_stars(re_stars);
	reDTO.setRe_reportUid(UID);
	reDTO.setRe_reportedUid(proDTO.getP_sellerId());
	reDTO.setRe_content(re_content);
	int result = dao.reviewAdd(reDTO);
%>
<body>
<%	if(result == 1){ %>
	<script type="text/javascript">
		alert("리뷰를 작성했습니다!");
		window.close();
	</script>
<%	}else{ %>
	<script type="text/javascript">
		alert("리뷰 작성 실패!");
		window.close();
	</script>
<%	} %>
	<script>
		alert("권한이 없습니다");
		window.close();
	</script>
<%} %>
</body>
</html>