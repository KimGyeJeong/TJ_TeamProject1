<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="team.project.model.UserListDTO"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<jsp:include page="../UIDcheck.jsp"></jsp:include>
</head>
<%
request.setCharacterEncoding("UTF-8");
String uid = (String)session.getAttribute("UID");
uid="qwe8246"; 		//	임시!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


String path = request.getRealPath("teamProject/save");
int size = 1024*1024*10;

MultipartRequest mr = new MultipartRequest(request, path,size,"UTF-8",new DefaultFileRenamePolicy());
String pw = mr.getParameter("modifyPW");
String pwcheck = mr.getParameter("modifyPWcheck");
String username = mr.getParameter("username");
String email = mr.getParameter("email");
String phone = mr.getParameter("phone");
String profileIMG = mr.getFilesystemName("profileIMG");

InstanceDAO dao = new InstanceDAO();
UserListDTO dto = new UserListDTO();

int result = -100;

dto.setUser_id(uid);
dto.setUser_name(username);
dto.setUser_email(email);
dto.setUser_phone(phone);


	if(profileIMG != null){
		dto.setUser_img(profileIMG);		
	}
	if(pw!=null && pwcheck!=null){
		if(pw.equals(pwcheck)){
			dto.setUser_pw(pw);
		}else{ %>
			<script type="text/javascript">
			alert("비밀번호가 서로 일치 하지 않습니다.")
			window.location="modifyProfile.jsp"
			</script>
	<%	}
	} 
	
result = dao.updateUser(dto);
if(result == 1){%>
<script type="text/javascript">
alert("수정되었습니다.");
location="MyPageInfo.jsp";
</script>
<%} %>
<body>

</body>
</html>