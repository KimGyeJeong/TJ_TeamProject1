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
	Integer p_no = Integer.parseInt(request.getParameter("p_no"));
	String pq_title = request.getParameter("pq_title");
	String pq_content = request.getParameter("pq_content");
	int pq_secret = Integer.parseInt(request.getParameter("pq_secret"));
	BeomSuDAO dao = new BeomSuDAO();
	
	//상품에 대한 구매희망자가 판매자에게 질문글 남기는 곳.
	//여기서 알림 넣어주기
	int result = dao.ProductQuestionAdd(p_no, UID, pq_title, pq_content, pq_secret);
	
%>
<body>

<%
if(UID != null){
	if(result == 1){%>
		<script>
			alert("문의글 작성 완료!");
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
		alert("로그인 후 이용해 주세요!");
		opener.parent.location='../Login/Login.jsp';
		window.close();
	</script>
<%	} %>

</body>
</html>