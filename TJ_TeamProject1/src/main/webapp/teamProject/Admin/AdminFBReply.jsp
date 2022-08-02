<%@page import="team.project.model.ReplyDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.LeeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminFBReply</title>
</head>
<body>
	<h3>AdminReply</h3>
	<%
	request.setCharacterEncoding("UTF-8");

	int cno = Integer.parseInt(request.getParameter("cno"));
	System.out.println("AdminFBReply.value cno : "+cno);

	LeeDAO dao_lee = new LeeDAO();
	List replylist = null;

	int count = dao_lee.getReplyCount(cno);
	String replyPageNum = request.getParameter("replyPageNum");
	if (replyPageNum == null) { // replyPageNum 파라미터 안넘어오면, 1페이지 보여지게 
		replyPageNum = "1"; // 1로 값 체우기 
	}
	int pageSize = 20; // 현재 페이지에서 보여줄 글 목록의 수 
	int currentPage = Integer.parseInt(replyPageNum); // replyPageNum int로 형변환 -> 숫자 연산 
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;

	if (count > 0) {
		replylist = dao_lee.getReplies(cno, startRow, endRow);
	}
	%>

	<div align="center" id="checkReply">
		<table>

			<%
			if (count < 1) {
			%>
			<tr>
				<td colspan="4">댓글</td>
			</tr>
			<tr>
				<td>댓글이 없습니다</td>
			</tr>
			<%
			}else{
				%>

			<tr>
				<td>고유번호</td>
				<td>내용</td>
				<td>작성자</td>
				<td>작성시간</td>
				<td>옵션</td>
			</tr>
			<%
			for(int i=0; i<replylist.size();i++){
				ReplyDTO dto2 = (ReplyDTO)replylist.get(i);
				%>
				<tr>
					<td> <%=dto2.getR_no() %> </td>	
					<td>
					<%
						int wid = 0;
					if(dto2.getR_level()>0){
						wid=12*dto2.getR_level();
						%>
						<img alt="" src="../FreeBoard/img/tabImg.PNG" width="<%=wid%>/">
						<img alt="" src="../FreeBoard/img/replyImg.PNG" width="12">
						<%
					}
					%>
					<%=dto2.getR_reply() %>
					</td>
					<td><%=dto2.getUser_id() %></td>
					<td><%=dto2.getR_reg() %></td>
					<td> <button onclick="moveDel(<%=dto2.getR_no()%>)">삭제</button> </td>
				</tr>
				<%
			}
			
			
			
			}
			%>
		</table>
	</div>

<script type="text/javascript">
function moveDel(r_no){
	let f = document.createElement('form');

	let no;
	no = document.createElement('input');
	no.setAttribute('type', 'hidden');
	no.setAttribute('name', 'r_no');
	no.setAttribute('value', r_no);

	f.appendChild(no);
	f.setAttribute('method', 'post');
	f.setAttribute('action', 'AdminFBReplyDeletePro.jsp');

	document.body.appendChild(f);
	f.submit();
}

</script>

</body>
</html>