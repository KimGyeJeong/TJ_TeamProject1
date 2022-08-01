<%@page import="team.project.dao.InstanceDAO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.model.CategoryDTO"%>
<%@include file="AdminSessionCheck.jsp" %>
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
	
//	String grp = "";	//카테고리 추가하기전 비교용
//	int grpNo = 0;		//위와 동일
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
	
		
		for(int j=0; j<list.size();j++){
			ca_dto2 = list.get(j);
			
			if(ca_dto2.getCa_level() != 0 & (ca_dto.getCa_grp() == ca_dto2.getCa_grp())){
				System.out.println("AIC.jsp value 비교 dto. dto2. " + ca_dto.getCa_name() + ", "+ca_dto2.getCa_name() );
			
			%>
			<tr>
				<td>소분류</td>
				<td><%=ca_dto2.getCa_name() %></td>
			</tr>
			<%
			}
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
							for(int i=0; i<list.size();i++){
								ca_dto = list.get(i);
								
								if(ca_dto.getCa_level() == 0){
									%>
									<optgroup label="<%=ca_dto.getCa_name()%>">
									<%
									for(int j=0; j<list.size();j++){
										ca_dto2 = list.get(j);
										if(ca_dto2.getCa_level() != 0 & (ca_dto2.getCa_grp()==ca_dto.getCa_grp())){
											%>
										 	<option value="<%=ca_dto2.getCa_name() %>"><%=ca_dto2.getCa_name() %></option>
											<%  
										}
									}
								}
							}
							%>
							</optgroup>
							<optgroup label="대분류만 수정하기">
								<option value="onlyGrp">대분류 이름만 수정하기</option>
							</optgroup>
						</select>
					</td>
				</tr>
				<tr>
					<td>수정 명</td>
					<td><input type="text" name="update" placeholder="수정하고 싶은 이름">
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
						<select name="grp">
					<%
					for(int i=0; i<list.size();i++){
						ca_dto = list.get(i);
						
						if(ca_dto.getCa_level() == 0){
							%>							
								<option value="<%=ca_dto.getCa_name() %>"><%=ca_dto.getCa_name() %></option>
							<%
						}
					}
					%>
						</select>
					</td>
					<td style="width: 100px"><input type="text" name="grpInsert" placeholder="소분류만 추가시 빈칸으로 냅두세요"></td>
				</tr>
				<tr>
					<td>소분류</td>
					<td>
						<select name="level">
							<%
							for(int i=0; i<list.size();i++){
								ca_dto = list.get(i);
								
								if(ca_dto.getCa_level() == 0){
									%>
									<optgroup label="<%=ca_dto.getCa_name()%>">
									<%
									for(int j=0; j<list.size();j++){
										ca_dto2 = list.get(j);
										if(ca_dto2.getCa_level() != 0 & (ca_dto2.getCa_grp()==ca_dto.getCa_grp())){
											%>
										 	<option value="<%=ca_dto2.getCa_name() %>"><%=ca_dto2.getCa_name() %></option>
											<%  
										}
									}
								}
							}
							%>								
									</optgroup>
						</select>
					</td>
					<td><input type="text" name="levelInsert"></td>
				</tr>
				<tr>
					<td colspan="3"> <input type="submit" value="추가"> </td>
				</tr>
			</table>
		</form>
	</div>


</body>
</html>