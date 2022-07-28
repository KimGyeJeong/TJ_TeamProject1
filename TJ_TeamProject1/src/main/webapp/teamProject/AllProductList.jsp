<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.model.UserQuestionDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.LeeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../style.css" rel="stylesheet" type="text/css" />

<%request.setCharacterEncoding("UTF-8");
	String ca = request.getParameter("ca_no");
	if(ca == null){
		ca = "3";
	}
	int ca_no = Integer.parseInt(ca);
 	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){ 
		pageNum = "1";   
	}
	System.out.println("pageNum : " + pageNum);
	
	int pageSize = 10;   
	int currentPage = Integer.parseInt(pageNum);  
	int startRow = (currentPage - 1) * pageSize + 1; 
	int endRow = currentPage * pageSize; 
 	
 	int count=0;
 	List list = null;
 	LeeDAO dao = new LeeDAO();
 	String sel = request.getParameter("sel");
 	//제목 , 글 본문 내용으로 검색기능
 	String search = request.getParameter("search");
 	if(sel != null && search != null){//검색게시판
 		count = dao.getProductListSearchCount(sel, search);
 		if(count >0){
 			list =dao.categorySearchSelect(startRow, endRow, sel, search);
 		}
 	}else{ //일반게시판 
 		count = dao.getProductListCount();
 		if(count >0){
 			list =dao.categorySelect(startRow, endRow); 
 		}
 	}
	int number = count - (currentPage - 1) * pageSize;
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm"); 
	System.out.println(ca_no);
	
	
	
 %>

</head>
<body>
<jsp:include page='Header.jsp'/>
<jsp:include page='floatingAdvertisement.jsp'/>
	
	<br />
	<h1 align="center">전체 상품 리스트</h1>
	<br />

	<br />
		<table align="center" >
			<tr >
		<%
		if(list != null){
			for(int i = 0; i<list.size(); i++){
				ProductDTO dto = (ProductDTO)list.get(i);
				if(i%5==0){%>
					<tr>
<%				} %>
				<td><a href="selPage/ProductDetailBuyForm.jsp?p_no=<%=dto.getP_no()%>">
				<img src="save/<%=dto.getP_img1() %>" width="250px"/><br/>
				<%=dto.getP_title() %>
				</a>
				</td>
			<%}
		}else{%>
		<h4 align="center"> 검색하신 "<%=search %>"의 해당 검색어 관련 상품이 없습니다!</h4>
<%		} %>
			
		</table>


	<br />
	<div align="center">
		<%
			if(count >0){
				int pageCount = count/ pageSize +(count % pageSize == 0? 0:1);
				int pageNumSize = 3;
				int startPage = (int)((currentPage-1)/pageNumSize)*pageNumSize + 1; 
				int endPage = startPage + pageNumSize - 1;
				
				if(endPage > pageCount){ endPage = pageCount;}
				
				
				
			
				
				
				if(startPage > pageNumSize) { 
					if(sel != null && search != null) { %>
						<a class="pageNums" href="AllProductList.jsp?pageNum=<%=startPage-1%>&sel=<%=sel%>&search=<%=search%>"> &lt; &nbsp; </a>
					<%}else{%>
						<a class="pageNums" href="AllProductList.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
					<%}
				}
				
				for(int i = startPage; i <= endPage; i++) { 
					if(sel != null && search != null) { %>
						<a class="pageNums" href="AllProductList.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
					<%}else{ %>
						<a class="pageNums" href="AllProductList.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
					<%} 
				}
				
				if(endPage < pageCount) { 
					if(sel != null && search != null) { %>
						<a class="pageNums" href="AllProductList.jsp?pageNum=<%=startPage+pageNumSize%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; &gt; </a>
				<%	}else{ %>
						<a class="pageNums" href="AllProductList.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
				<%	}
				} 		
				
				
	}%>
	<br/>
	<br/>
	</div>
	
	<br/>
	<br/>
<%@ include file="Footer.jsp" %>
</body>
</html>