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
	Integer pq_no = Integer.parseInt(request.getParameter("pq_no"));
	String pq_answer = request.getParameter("pq_answer");
	String p_sellerId = request.getParameter("p_sellerId");
	BeomSuDAO dao = new BeomSuDAO();
	
	//여기서 알람을 넣어주기
	//productquestion테이블에 user_id알람넣어주기.
	//판매자가 질문답변하면 구매희망자에게 알람가기
	int result = dao.ProductAnswerAdd(pq_no, pq_answer);
	
%>
<body>

<%
if(UID.equals(p_sellerId)){
	if(result == 1){%>
		<script>
			alert("답변글 작성 완료!");
			opener.parent.location.reload();
			window.close();
			
		</script>	
<%	}else{%>
		<script>
			alert("작성실패");
			window.close();
		</script>
<%	}
}else{%>
	<script>
		alert("권한이 없습니다!");
		opener.parent.location='../Main.jsp';
		window.close();
	</script>
<%	} %>


</body>
</html>