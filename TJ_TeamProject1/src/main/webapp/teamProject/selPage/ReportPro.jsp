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
	if(UID != null){
	Integer p_no = Integer.parseInt(request.getParameter("p_no"));
	String rp_title = request.getParameter("rp_title");
	String rp_content = request.getParameter("rp_content");
	String rp_reportedUid = request.getParameter("rp_reportedUid");
	String rp_reason = request.getParameter("rp_reason");
	
	BeomSuDAO dao = new BeomSuDAO();
	int result = dao.RportAdd(p_no, UID, rp_title, rp_content, rp_reportedUid, rp_reason);
	
%>
<body>
<%
	if(result == 1){%>
		<script>
			alert("신고 완료!");
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
<%	}
%>

</body>
</html>