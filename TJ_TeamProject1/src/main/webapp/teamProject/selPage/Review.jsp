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
%>
<body>
<form action="ReviewPro.jsp" method="post">
<input type="hidden" value="<%=p_no%>" name="p_no">
	<table>
		<tr>
			<td>상품 제목<text><%=proDTO.getP_title() %></text></td>&nbsp;&nbsp;
			<td>판매자<text><%=proDTO.getP_sellerId() %></text></td>
		</tr>
		<tr>
			<td>평정</td>
			<td><input type="number" min="1" max="5" name="re_stars" required /> / 5</td>
		</tr>
		<tr>
			<td colspan="2"><textarea rows="10" cols="50" name="re_content" required>리뷰내용을 적어주세요!</textarea></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="리뷰 작성!" />
			<input type="reset" value="초기화!" />
			<input type="button" value="취소!" onclick="window.close()" />
			</td>
		</tr>
	</table>
</form>
<%	}else{ %>
	<script>
		alert("권한이 없습니다");
		window.close();
	</script>
<%	} %>
</body>
</html>