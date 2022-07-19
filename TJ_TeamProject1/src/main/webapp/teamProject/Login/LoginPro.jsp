<%@page import="oracle.net.aso.c"%>
<%@page import="team.project.dao.LeeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String auto = request.getParameter("auto");
	System.out.println("쿠키테스트login pro:"+id+pw+auto);
	
	Cookie[] coos = request.getCookies(); 
	if(coos != null){
		for(Cookie c : coos) {
			// 쿠키가 있다면 쿠키에 저장된 값꺼내 변수에 담기
			if(c.getName().equals("autoId")) id = c.getValue();   
			if(c.getName().equals("autoPw")) pw = c.getValue();
			if(c.getName().equals("autoCh")) auto = c.getValue(); 
			System.out.println("쿠키테스트login pro2:"+id+pw+auto);
		}
	}

	
	LeeDAO dao = new LeeDAO();
	int result = dao.idpwChkUser(id,pw);
	System.out.println("result idpw:"+result);
	if(result < 1){%>
	<script>
		alert("존재하지 않는 id 또는 pw 입니다...");
		window.location="../Main.jsp";
	</script>
<%}else{
	//로그인 처리!!
	session.setAttribute("u_id", id);
	//쿠키처리

		//자동로그인이면 쿠키도 생성하고싶다
		if(auto != null){
			//자동로그인 체크했을 경우
			Cookie c1 = new Cookie("autoId",id);
			Cookie c2 = new Cookie("autoPw",pw);
			Cookie c3 = new Cookie("autoCh",auto); 
			c1.setPath("../"); 
			c1.setMaxAge(60*60*24*30); 
			c2.setMaxAge(60*60*24*30);
			c3.setMaxAge(60*60*24*30);
			response.addCookie(c1);
			response.addCookie(c2);
			response.addCookie(c3);
			System.out.println("쿠키테스트 :"+ c1.getValue());
		}
	String uri =(String)session.getAttribute("uri");
	System.out.println("uri:"+uri);
	
	if(uri == null ){
		uri = "../Main.jsp";
				
	}
	System.out.println("uri:"+uri);


%>
	<script>
		alert("로그인 성공!!!!");
		window.location="<%=uri%>";
		
	
	</script>
	
<%}%>
</body>
</html>