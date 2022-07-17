<%@page import="team.project.dao.InstanceDAO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.model.CategoryDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminInsertCategory</title>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");

	InstanceDAO i_dao = new InstanceDAO();

	CategoryDTO ca_dto = new CategoryDTO();
	CategoryDTO ca_dto2 = new CategoryDTO();

	List<CategoryDTO> list = null;

	list = i_dao.getCategory();
	%>

	<h1>Insert New Category Page</h1>

<div style="float:left">
	<h4>현재 카테고리 보기</h4>
	<table>
	<%
	list = i_dao.getCategory();
	
	for(int i=0;i<list.size();i++){
		ca_dto = list.get(i);
		
		if(ca_dto.getCa_level()==0){
		%>
		<tr>
			<td>대분류</td>
			<td><%=ca_dto.getCa_name() %></td>
		</tr>
		<%
		}
		
		for(int j=ca_dto.getCa_level(); j<2;j++){
			ca_dto2 = list.get(i);
			
			if(ca_dto2.getCa_level() != 0){
			%>
			<tr>
				<td>소분류</td>
				<td><%=ca_dto2.getCa_name() %></td>
			</tr>
			<%
			}
		}

	}
%>
	</table>
</div>

	<div style="text-align: center">
		<form action="AdminInsertCategoryPro.jsp" method="post">
			<table>
				<tr>
					<td colspan="2">카테고리 추가</td>
				</tr>
				<tr>
					<td>대분류</td>
					<td>
						<select name="grp">
							<option>선택하기..</option>
						<%
						for(int i=0;i<list.size();i++){
							ca_dto=list.get(i);
							if(ca_dto.getCa_level()==0){
						%>
							<option value="<%=ca_dto.getCa_name()%>"><%=ca_dto.getCa_name() %></option>
						<%
							}
						}
						%>
							<option value="etcGrp">추가입력...</option>
						</select>
					</td>
					<td>
						<select name="level">
							<option>선택하기..</option>
						<%
						for(int i=0;i<list.size();i++){
							ca_dto=list.get(i);
							if(ca_dto.getCa_level()!=0){
						%>
							<option value="<%=ca_dto.getCa_name()%>"><%=ca_dto.getCa_name() %></option>
						<%
							}
						}
						%>
							<option value="etcGrp">추가입력...</option>						
						
						</select>
					</td>
				</tr>
			</table>
		</form>
	</div>



</body>
</html>