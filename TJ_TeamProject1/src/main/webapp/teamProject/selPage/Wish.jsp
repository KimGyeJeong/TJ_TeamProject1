<%@page import="team.project.dao.BeomSuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찜</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String UID = (String)session.getAttribute("UID");
	if(UID != null){
	Integer p_no = Integer.parseInt(request.getParameter("p_no"));
	
	BeomSuDAO dao = new BeomSuDAO();
	int result = dao.WishAdd(p_no, UID);
	
%>
<body>
<%
	if(result == 1){%>
		<h4>현재 상품을 찜했습니다!</h4>
		<script>
		opener.parent.location.reload();
		</script>
		<button onclick="opener.parent.location='../mypage/MyWishList.jsp', window.close()">찜한상품 보러가기</button>
		<button onclick="window.close()">계속해서 쇼핑하기</button>
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