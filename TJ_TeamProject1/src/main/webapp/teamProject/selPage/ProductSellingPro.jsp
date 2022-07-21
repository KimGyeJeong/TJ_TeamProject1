<%@page import="team.project.dao.BeomSuDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 올린거 pro 페이지</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String UID = (String)session.getAttribute("UID");
	if(UID != null){	
	String path = request.getRealPath("teamProject/save"); 
	System.out.println(path);
	int max = 1024*1024*5; 
	String enc = "UTF-8"; 
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	String p_price = mr.getParameter("p_price");
	if(p_price == null){
		p_price = "0";
	}
	String p_maxPrice = mr.getParameter("p_maxPrice");
	if(p_maxPrice == null){
		p_maxPrice = "0";
	}
	String p_minPrice = mr.getParameter("p_minPrice");
	if(p_minPrice == null){
		p_minPrice = "0";
	}
	String p_start = mr.getParameter("p_start");
	p_start += " 00:00:00";
	
	String p_end = mr.getParameter("p_end");
	p_end += " 00:00:00";
	ProductDTO dto = new ProductDTO();
	ProductDTO p_dto = new ProductDTO();
	
	dto.setP_img1(mr.getFilesystemName("p_img1"));
	dto.setP_img2(mr.getFilesystemName("p_img2"));
	dto.setP_img3(mr.getFilesystemName("p_img3"));
	dto.setP_img4(mr.getFilesystemName("p_img4"));
	dto.setP_status(Integer.parseInt(mr.getParameter("p_status")));
	dto.setCa_no(Integer.parseInt(mr.getParameter("ca_no")));
	dto.setP_content(mr.getParameter("p_content"));
	dto.setP_price(Integer.parseInt(p_price));
	dto.setP_maxPrice(Integer.parseInt(p_maxPrice));
	dto.setP_minPrice(Integer.parseInt(p_minPrice));
	dto.setP_sellerId(mr.getParameter("p_sellerId"));
	dto.setP_status(Integer.parseInt(mr.getParameter("p_status")));
	dto.setP_title(mr.getParameter("p_title"));
	dto.setP_start(Timestamp.valueOf(p_start));
	dto.setP_end(Timestamp.valueOf(p_end));
	
	BeomSuDAO dao = new BeomSuDAO();
	int result = dao.productSelling(dto);
	
%>
<body>
<%	if(result == 1){ 
		p_dto = dao.getP_no(dto.getP_img1());
%>
		<script>
			alert("상품 등록 완료!");
			 window.location.assign("ProductDetailBuyForm.jsp?p_no="+<%=p_dto.getP_no()%>); 
		</script>
<%	}else{ %>
		<script>
			alert("상품 등록 실패!");
			window.location="../Main.jsp";
		</script>
<%	}
}else{%>
		<script>
			alert("로그인 후 이용해 주세요!");
			window.location.assign("../Login/Login.jsp");
		</script>
<%	}%>
</body>
</html>