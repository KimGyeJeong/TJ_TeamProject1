<%@page import="team.project.dao.LeeDAO"%>
<%@page import="team.project.model.ContentDTO"%>
<%@page import="javax.swing.text.AbstractDocument.Content"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">  
	<title>modifyPro</title>
	
</head>
<%
	request.setCharacterEncoding("UTF-8");
	ContentDTO article = new ContentDTO(); 
	String id= request.getParameter("id");
	
	String path = request.getRealPath("/teamProject/save");
	System.out.println(path);
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	String cno=mr.getParameter("cno");
	System.out.println("FBmodifyPro.cno:"+cno);
	// 비번 검사하고 맞으면 수정 : bpw 
	// update imgBoard set subject=?, content=?, email=?, img=? where bno=?; 
	article.setC_title(mr.getParameter("subject"));
	article.setUser_id(id);
	article.setC_content(mr.getParameter("content"));
	article.setC_no(Integer.parseInt(cno));
	if(mr.getFilesystemName("img") != null){
		article.setC_img(mr.getFilesystemName("img"));
	}else{
		article.setC_img(mr.getFilesystemName("exImg"));
	}
	
	String pageNum = mr.getParameter("pageNum");
	
	
	LeeDAO dao = new LeeDAO(); 
	int result = dao.updateArticle(article); // 비번 틀리면 0, 수정완료 1   
	%>
		<script>
			alert("수정 완료!!!");
			window.location.href = "FBcontent.jsp?cno=" + <%=cno%> + "&pageNum=" + <%=pageNum%>; 
		</script>
	


<body>

</body>
</html>