<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.Writer"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="team.project.dao.BeomSuDAO"%>
<%@page import="team.project.model.ProductDTO"%>
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
	
	if(UID != null){	
	String path = request.getRealPath("teamProject/save"); 
	System.out.println(path);
	int max = 1024*1024*5; 
	String enc = "UTF-8"; 
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	int p_no = Integer.parseInt(mr.getParameter("p_no"));
	int  result = 1;
	System.out.println(p_no);
	String ca_no = mr.getParameter("ca_no");
	if(ca_no.equals("카테고리")){
		response.setContentType("text/html; charset=UTF-8");
	    PrintWriter alert = response.getWriter();
	    out.println("<script>alert('카테고리를 선택해 주세요!'); history.go(-1);</script>");
	    out.flush();
	    response.flushBuffer();
	    out.close();
	}
	
	String p_price = mr.getParameter("p_price");
	if(p_price == null){
		p_price = "0";
	}
	String p_maxPri = mr.getParameter("p_maxPrice");
	if(p_maxPri == null){
		p_maxPri = "0";
	}
	System.out.println(p_maxPri);
	String p_minPri = mr.getParameter("p_minPrice");
	if(p_minPri == null){
		p_minPri = "0";
	}
	int p_maxPrice = Integer.parseInt(p_maxPri);
	int p_minPrice = Integer.parseInt(p_minPri);
	System.out.println(p_minPri);
	int p_status = Integer.parseInt(mr.getParameter("p_status"));
	if(p_status == 1){
		if(p_maxPrice == 0 && p_maxPrice <= p_minPrice){
			result = 0;
		    Writer outWriter = response.getWriter();
		    String message = URLEncoder.encode("상한가가 하한가보다 낮거나 같을 수 없습니다!.","UTF-8");
		    response.setContentType("text/html; charset=UTF-8");
		    outWriter.write("<script type=\"text/javascript\">alert(decodeURIComponent('"+message+"'.replace(/\\+/g, '%20'))); history.go(-1)</script>");
		    outWriter.flush();
		    response.flushBuffer();
		    outWriter.close();
		}
	}
	String p_start = mr.getParameter("p_start");
	System.out.println(mr.getParameter("p_start"));
	p_start += " 00:00:00";
	
	String p_end = mr.getParameter("p_end");
	p_end += " 00:00:00";
	BeomSuDAO dao = new BeomSuDAO();
	ProductDTO dto = dao.productDetailBuy(p_no);
	
	dto.setP_img1(mr.getFilesystemName("p_img1"));
	dto.setP_img2(mr.getFilesystemName("p_img2"));
	dto.setP_img3(mr.getFilesystemName("p_img3"));
	dto.setP_img4(mr.getFilesystemName("p_img4"));
	dto.setP_status(p_status);
	dto.setCa_no(Integer.parseInt(mr.getParameter("ca_no")));
	dto.setP_content(mr.getParameter("p_content"));
	dto.setP_price(Integer.parseInt(p_price));
	dto.setP_maxPrice(p_maxPrice);
	dto.setP_minPrice(p_minPrice);
	dto.setP_sellerId(mr.getParameter("p_sellerId"));
	dto.setP_status(Integer.parseInt(mr.getParameter("p_status")));
	dto.setP_title(mr.getParameter("p_title"));
	dto.setP_start(Timestamp.valueOf(p_start));
	dto.setP_end(Timestamp.valueOf(p_end));
	
	 
	result = dao.productModify(dto, p_no);   
	
%>
<body>
<%	if(result == 1){ 

%>
		<script>
			alert("수정 완료!");
			 window.location.assign("ProductDetailBuyForm.jsp?p_no="+<%=dto.getP_no()%>); 
		</script>
<%	}else{ %>
		<script>
			alert("수정 실패!");
			window.location="../Main.jsp";
		</script>
<%	}
}else{%>
		<script>
			alert("권한이 없습니다!");
			window.location.assign("../Main.jsp");
		</script>
<%	}%>

</body>
</html>