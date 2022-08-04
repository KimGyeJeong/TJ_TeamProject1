z<%@page import="team.project.model.UserListDTO"%>
<%@page import="java.util.List"%>
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
String UID = (String) session.getAttribute("UID");

int p_no = Integer.parseInt(request.getParameter("p_no"));
String p_sellerId = request.getParameter("p_sellerId");

BeomSuDAO dao = new BeomSuDAO();
ProductDTO proDTO = dao.productDetailBuy(p_no);

if (UID.equals(proDTO.getP_buyerId())) {
	//REVIEW 에서 넘어오는 평점과 댓글
	int re_stars = Integer.parseInt(request.getParameter("re_stars"));
	String re_content = request.getParameter("re_content");
	
	//replyDTO 에서 작성자는 세션 로그인한사람, 후기 받는 사람은 물건 판매자,..
	// 0803 현재. 리뷰는 구매자가 판매자한테만 작성 가능.
	ReviewDTO reDTO = new ReviewDTO();
	reDTO.setRe_stars(re_stars);
	reDTO.setRe_reportUid(UID);
	reDTO.setRe_reportedUid(proDTO.getP_sellerId());
	reDTO.setRe_content(re_content);
	//redto에 p_no도 들어가야함
	reDTO.setP_no(p_no);

	//reply dto 들고 댓글넣어주는 페이지
	//여기서 알람이 갈수 있게...
	int result = dao.reviewAdd(reDTO);
%>
<body>
	<%
	if (result == 1) {
		List list = dao.getReview(proDTO.getP_sellerId());
		int stars = 0;
		if (list != null) {
			for (int i = 0; i < list.size(); i++) {
		reDTO = (ReviewDTO) list.get(i);
		stars += reDTO.getRe_stars();
			}
			stars /= list.size();
		} else {
			stars = re_stars;
		}
		dao.userStarsAdd(proDTO.getP_sellerId(), stars);
	%>
	<script type="text/javascript">
		alert("리뷰를 작성했습니다!");
		window.close();
	</script>
	<%
	} else {
	%>
	<script type="text/javascript">
		alert("리뷰 작성 실패!");
		window.close();
	</script>
	<%
	}
	%>
	<script>
		alert("권한이 없습니다");
		window.close();
	</script>
	<%
	}
	%>
</body>
</html>