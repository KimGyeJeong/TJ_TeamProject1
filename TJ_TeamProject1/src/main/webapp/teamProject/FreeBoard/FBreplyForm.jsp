<%@page import="team.project.model.ReplyDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.LeeDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script>


</script>
<head>
<meta charset="UTF-8">
<title>reply write form</title>

</head>
<%
	int cno = Integer.parseInt(request.getParameter("cno"));
	String pageNum = request.getParameter("pageNum");
	String id=(String)session.getAttribute("UID");
	if(id==null){
		id="non-login";
	}
	SimpleDateFormat sdf = new SimpleDateFormat();
	
	// 새 댓글 
	int rno = 0, replyGrp = 1, replyStep = 0, replyLevel = 0; 
	
	// 댓글의 댓글 
	if(request.getParameter("rno") != null) {
		rno = Integer.parseInt(request.getParameter("rno"));
		replyGrp = Integer.parseInt(request.getParameter("replyGrp"));
		replyStep = Integer.parseInt(request.getParameter("replyStep"));
		replyLevel = Integer.parseInt(request.getParameter("replyLevel"));
	}
	LeeDAO dao = new LeeDAO();
	int count = dao.getReplyCount(cno);
	String replyPageNum = request.getParameter("replyPageNum");
	if(replyPageNum == null){ // replyPageNum 파라미터 안넘어오면, 1페이지 보여지게 
		replyPageNum = "1";   // 1로 값 체우기 
	}
	int pageSize = 20;  // 현재 페이지에서 보여줄 글 목록의 수 
	int currentPage = Integer.parseInt(replyPageNum); // replyPageNum int로 형변환 -> 숫자 연산 
	int startRow = (currentPage - 1) * pageSize + 1; 
	int endRow = currentPage * pageSize; 
	List replyList = null;
	if(count > 0) {
		// 댓글 목록 가져오기
		replyList = dao.getReplies(cno, startRow, endRow);  
	}

%>

<body>
	<br />
	<h1 align="center">댓글달기</h1>
	<form action="FBreplyPro.jsp?pageNum=<%=pageNum%>" method="post" name="FBreplyForm" onsubmit="return acountCheck()">
		<input type="hidden" name="c_no" value="<%=cno%>" /> <input
				type="hidden" name="r_no" value="<%=rno%>" /> <input type="hidden"
				name="r_grp" value="<%=replyGrp%>" /> <input type="hidden"
				name="r_step" value="<%=replyStep%>" /> <input type="hidden"
				name="r_level" value="<%=replyLevel%>" /> <input type="hidden"
				name="user_id" value="<%=id%>" />
		<table>
			<%if(!id.equals("non-login")){ %>
			<tr>
				<td align="right">내 용</td>
				<td ><textarea rows="3" cols="40" name="r_reply"></textarea>
				</td>
			</tr>

			<tr>
				<td colspan="2" align="center"><input type="submit"
					value="댓글저장" /> <input type="button" value="취소"
					onclick="window.location='FBcontent.jsp?cno=<%=cno%>&pageNum=<%=pageNum%>'" />
				</td>
			</tr>
			<%}%>
		</table>
	</form>


	<%--- 댓글 --%>
	<%
	if(count == 0) { %>
	<table>
		<tr>
			<td colspan="4"><b>댓 글</b></td>
		</tr>
		<tr>
			<td>댓글이 없습니다.</td>
		<tr>
	</table>

	<%}else{ %>

	<table>
		<tr>
			<td colspan="4"><b>댓 글</b></td>
		</tr>
		<tr>
			<td>no
			<td>
			<td>내 용</td>
			<td>작성자</td>
			<td>작성시간</td>
			<td>답글 수정 삭제</td>
		<tr>
			<%
		for(int i = 0; i < replyList.size(); i++){
			ReplyDTO reply = (ReplyDTO)replyList.get(i); %>
		
		<tr>
			<td><%=reply.getR_no() %></td>
			<td></td>
			<td align="left">
				<% // 댓글의 댓글 들여쓰기 효과 주기 
					int wid = 0; 
					if(reply.getR_level() > 0) { 
						wid = 12 * reply.getR_level(); %> <img src="img/tabImg.PNG"
				width="<%=wid%>" /> <img src="img/replyImg.png" width="12" /> <%}%> <%=reply.getR_reply()%>
			</td>
			<td><%=reply.getUser_id()%></td>
			<td><%=sdf.format(reply.getR_reg())%></td>
			<td><%if(!id.equals("non-login")){%>
				<button
					onclick="window.location='FBreplyForm.jsp?rno=<%=reply.getR_no()%>&replyGrp=<%=reply.getR_grp()%>&replyStep=<%=reply.getR_step()%>&replyLevel=<%=reply.getR_level()%>&cno=<%=cno%>&pageNum=<%=pageNum%>'">답글</button>
				<%}%> <%
					 if(id.equals(reply.getUser_id())){%>

				<button
					onclick="window.location='FBreplyModify.jsp?rno=<%=reply.getR_no()%>&cno=<%=cno%>&pageNum=<%=pageNum%>'">수정</button>
				<button
					onclick="window.location='FBreplyDeletePro.jsp?rno=<%=reply.getR_no()%>&cno=<%=cno%>&pageNum=<%=pageNum%>'">삭제</button>


				<%}%></td>
		<tr>

			<%}%>
		
	</table>
	<% }//else%>




	<%-- 댓글 목록 밑에 페이지 번호 뷰어 추가 --%>
	<br />
	<div align="center">
		<%
		if(count > 0){
			// 10페이지 번호씩 보여주겠다 
			// 총 몇페이지 나오는지 계산 -> 뿌려야되는 페이지번호 
			int pageCount = count / pageSize + (count % pageSize == 0? 0 : 1);
			int pageNumSize = 3;  // 한페이지에 보여줄 페이지번호 개수
			int startPage = (int)((currentPage-1)/pageNumSize)*pageNumSize + 1; 
			int endPage = startPage + pageNumSize - 1;
			// 전체 페이지수보다 위에 계산된 페이지 마지막번호가 더 크면 안되므로, 
			// 아래서 endPage다시 조정하기 
			if(endPage > pageCount) { endPage = pageCount; } 
			
			// 페이지 번호 뿌리기 
			
			if(startPage > pageNumSize) { %>
		<a class="pageNums"
			href="FBcontent.jsp?pageNum=<%=pageNum%>&replyPageNum=<%=startPage-1%>&cno=<%=cno%>">
			&lt; &nbsp; </a>
		<%}
			
			for(int i = startPage; i <= endPage; i++){ %>
		<a class="pageNums"
			href="FBcontent.jsp?pageNum=<%=pageNum%>&replyPageNum=<%=i%>&cno=<%=cno%>">
			&nbsp; <%=i%> &nbsp;
		</a>
		<%}
			
			if(endPage < pageCount) { %>
		<a class="pageNums"
			href="FBcontent.jsp?pageNum=<%=pageNum%>&replyPageNum=<%=startPage+pageNumSize%>&cno=<%=cno%>">
			&nbsp; &gt; </a>
		<%}
			
		}
	%>
	</div>


	<%	// else%>

	<br />
	<br />
	<br />
	<br />
	<br />
</body>
</html>
