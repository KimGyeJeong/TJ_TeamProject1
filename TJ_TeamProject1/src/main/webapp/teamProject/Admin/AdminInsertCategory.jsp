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
	
	String grp = "";	//카테고리 추가하기전 비교용
	int grpNo = 0;		//위와 동일
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

<%-- 카테고리 수정 --%>
	<div style="text-align: center">
		<form action="AdminInsertCategoryPro.jsp" method="post">
		<input type="hidden" name="type" value="update">
			<table>
				<tr>
					<td colspan="2">카테고리 수정</td>
				</tr>
				<tr>
					<td>대분류 수정</td>
					<td>
						<select name="grp">
							<%
							for(int i=0;i<list.size();i++){
								ca_dto=list.get(i);
								if(ca_dto.getCa_level()!=1){
								%>
								<option value="<%=ca_dto.getCa_name() %>"><%=ca_dto.getCa_name() %></option>
								<%
								}
							}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>소분류 수정</td>
					<td>
						<select name="level">
						
							<% 
							for(int i=0;i<list.size();i++){
								ca_dto=list.get(i);
								
								for(int j=1; j<list.size();j++){
									if(ca_dto.getCa_grp()==j & ca_dto.getCa_level()==0){
										%>
											<optgroup label="<%= ca_dto.getCa_name()%>">
											<%= ca_dto.getCa_name()%>											
										<%
									}
										if(ca_dto.getCa_grp()==j & ca_dto.getCa_level()!=0){
											%>
											<option value="<%= ca_dto.getCa_name()%>">
											<%= ca_dto.getCa_name()%></option>									
										<%
										}
									}
									%>
									</optgroup>
									<%
								}								 
							%>
							<optgroup label="대분류만 수정하기">
								<option value="onlyGrp">대분류 이름만 수정하기</option>
							</optgroup>
						</select>
					</td>
				</tr>
				<tr>
					<td>수정 명</td>
					<td><input type="text" name="update">
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="수정">
					</td>
				</tr>
			</table>
		</form>
	</div>
	
<%-- 한줄띄어쓰기(꾸미기) --%>
<div style="text-align: center">
	<br>
</div>

<%-- 카테고리 추가 --%>
	<div style="text-align: center">
		<form action="AdminInsertCategoryPro.jsp" method="post">
		<input type="hidden" name="type" value="insert">
			<table>
				<tr>
					<td colspan="3">카테고리 추가</td>
				</tr>
				<tr>
					<td>대분류</td>
					<td>
						<select>
					<%
					for(int i=0; i<list.size();i++){
						ca_dto = list.get(i);
						
						if(ca_dto.getCa_level() == 0){
							%>							
								<option><%=ca_dto.getCa_name() %></option>
							<%
						}
					}
					%>
						</select>
					</td>
					<td><input type="text" name="grp"></td>
				</tr>
				<tr>
					<td>소분류</td>
					<td>
						<select>
					<%
					for(int i=0; i<list.size();i++){
						ca_dto = list.get(i);
						
						if(ca_dto.getCa_level() != 0){
							%>							
								<option><%=ca_dto.getCa_name() %></option>
							<%
						}
					}
					%>
						</select>
					</td>
					<td><input type="text" name="level"></td>
				</tr>
				<tr>
					<td colspan="3"> <input type="submit" value="추가"> </td>
				</tr>
			</table>
		</form>
	</div>


</body>
</html>