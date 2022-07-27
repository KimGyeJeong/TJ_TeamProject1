<%@page import="team.project.model.ProductQuestionDTO"%>
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
	Integer p_no = Integer.parseInt(request.getParameter("p_no"));
	Integer pq_no = Integer.parseInt(request.getParameter("pq_no"));
	String p_sellerId = request.getParameter("p_sellerId");
	if(p_no == null){
		p_no = -1;
	}
	BeomSuDAO dao = new BeomSuDAO();
	ProductDTO proDTO = dao.productDetailBuy(p_no);
	ProductQuestionDTO queDTO = dao.ProductQuestionList2(pq_no);
%>
<body>
<%	if(UID.equals(p_sellerId)){ %>
	<form action="ProductAnswerPro.jsp" method="post">
	<input type="hidden" name="pq_no" value="<%=pq_no%>"/>
	<input type="hidden" name="p_sellerId" value="<%=p_sellerId%>"/>
		<table>
			<tr>
				<td>상품 정보</td>
				<td><text readonly>상품 제목 : <%=proDTO.getP_title() %>
				</text><br/>
				<text readonly>문의 작성자 : <%=queDTO.getUser_id() %></text></td>
			</tr>
			<tr>
				<td>문의 제목</td>
				<td><text readonly><%=queDTO.getPq_title() %></text></td>
			</tr>
			<tr>
				<td>문의 내용</td>
				<td><text readonly><%=queDTO.getPq_content() %></text></td>
			</tr>
			<tr>
				<td>답변 내용</td>
				<td><textarea rows="5" cols="50" name="pq_answer"></textarea></td>
			</tr>
			<tr>
				<td>주의사항</td>
				<td><input type="submit" value="문의 작성" /></td>
			</tr>
		</table>
	</form>
<% }else{%>
		<script>
			alert("권한이 없습니다");
			window.close();
		</script>
<%	} %>

</body>
</html>