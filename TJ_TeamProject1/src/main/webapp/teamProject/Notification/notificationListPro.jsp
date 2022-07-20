<%@page import="team.project.model.NotificationDTO"%>
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
<%String check= request.getParameter("check"); 
 	System.out.println(check);
  String dto = request.getParameter("dto");
    System.out.println(dto);
    
    if(check.equals("1")){
    	System.out.println("이걸내탓을?");
    	//실행해서... 값바꿔주기
     LeeDAO dao = new LeeDAO();	
     int result=dao.notificationCheckChange(dto);
     System.out.println("notificationCheckChange result:" +result);
     
    }
    response.sendRedirect("notificationList.jsp");
    
%>

</body>
</html>