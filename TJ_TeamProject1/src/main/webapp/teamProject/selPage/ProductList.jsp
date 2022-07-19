<%@page import="team.project.model.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.BeomSuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 리스트</title>
<link href="/TJ_TeamProject1/teamProject/style.css" rel="stylesheet" type="text/css" />
</head>
<%
	request.setCharacterEncoding("utf-8");
	String ca = request.getParameter("ca_no");
	if(ca == null){
		ca = "3";
	}
	int ca_no = Integer.parseInt(ca);
	
	BeomSuDAO dao = new BeomSuDAO();
	List list = null;
	list = dao.categorySelect(ca_no);
	
%>
<body>
	<br />
	<h4>추천 상품</h4>
		<table align="left">

		<%
		if(list != null){
			int j = 0;
			for(int i = j; i<list.size(); i++){%>
			<tr>
<%
				ProductDTO dto = (ProductDTO)list.get(i);%>
				<td><a href="ProductDetailBuyForm.jsp?p_no=<%=dto.getP_no()%>&ca_no=<%=ca_no%>">
				<img src="/teamProject/save/<%=dto.getP_img1() %>" /><br/>
				<%=dto.getP_title() %>
				</a>
				</td>
			</tr>
			<%}
		}else{%>
		<h4>해당 카테고리에 상품이 없습니다!</h4>
<%		} %>
			
		</table>

</body>
</html>