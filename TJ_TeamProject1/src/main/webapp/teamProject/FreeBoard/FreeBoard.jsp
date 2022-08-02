<%@page import="team.project.model.ContentDTO"%>
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
<title>장물아비-자유게시판</title>
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
	
	int pageSize = 5;   
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
 		count = dao.getfreeContentListSearchCount(sel, search);
 		if(count >0){
 			list =dao.getfreeContentListSearchList(startRow, endRow, sel, search);
 		}
 	}else{ //일반게시판 
 		count = dao.freeContentCount();
 		if(count >0){
 			list =dao.freeContentList(startRow, endRow); 
 		}
 	}
	int number = count - (currentPage - 1) * pageSize;
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm"); 
	
	
	
	
 %>

</head>
<body>
<jsp:include page='../Header.jsp'/>
<jsp:include page='../floatingAdvertisement.jsp'/>

	<br />
	<h1 align="center"> 자유 게시판</h1>

	
	<br />
	
	<br />
		<table align="center"  >
				<tr>
					<td colspan="4" align="right"><button onclick="window.location='FBwriteForm.jsp'" >글쓰기</button></td>
					<td></td>
				</tr>
				<tr>		
					
					<td>글 번호</td>
					<td>제목</td>
					
					<td>작성자</td>
					<td>작성시간</td>
					<td>조회수</td>
					
				</tr>
			<tr >
		<%
		if(list != null){
			for(int i = 0; i<list.size(); i++){
				ContentDTO dto = (ContentDTO)list.get(i);
				if(i%5==0){%>
				
<%				} %>
					
				<tr>
					<td><%=number-- %></td>
					<td><a href="FBcontent.jsp?c_no=<%=dto.getC_no()%>"><%=dto.getC_title() %></a></td>
					<td><%=dto.getUser_id() %></td>
					<td><%=sdf.format(dto.getC_reg()) %></td>
					<td><%=dto.getC_readcount() %>
				</tr>
				
			<%}
		}else{%>
		<h4 align="center"> 검색하신 "<%=search %>"의 검색결과가 없습니다!</h4>
<%		} %>
			
		</table>
	
	
				<div align="center">
				<form action="/TJ_TeamProject1/teamProject/FreeBoard/FreeBoard.jsp" style="display: inline-block;">
				<select name="sel">
				<option value="C_TITLE" selected>제목</option> 
				<option value="C_CONTENT">글내용</option>
				<option value="USER_ID">작성자</option>
					</select>
					<input type="text" name="search" >
					<input type="submit" value="검색"  />
				</form>
				</div>
				

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
						<a class="pageNums" href="FreeBoard.jsp?pageNum=<%=startPage-1%>&sel=<%=sel%>&search=<%=search%>"> &lt; &nbsp; </a>
					<%}else{%>
						<a class="pageNums" href="FreeBoard.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
					<%}
				}
				
				for(int i = startPage; i <= endPage; i++) { 
					if(sel != null && search != null) { %>
						<a class="pageNums" href="FreeBoard.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
					<%}else{ %>
						<a class="pageNums" href="FreeBoard.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
					<%} 
				}
				
				if(endPage < pageCount) { 
					if(sel != null && search != null) { %>
						<a class="pageNums" href="FreeBoard.jsp?pageNum=<%=startPage+pageNumSize%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; &gt; </a>
				<%	}else{ %>
						<a class="pageNums" href="FreeBoard.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
				<%	}
				} 		
				
				
	}%>
	<br/>
	<br/>
	</div>
	
	<br/>
	<br/>
<%@ include file="../Footer.jsp" %>
</body>
</html>