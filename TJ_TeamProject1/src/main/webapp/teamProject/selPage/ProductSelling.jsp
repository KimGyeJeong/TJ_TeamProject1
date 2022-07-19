<%@page import="team.project.dao.BeomSuDAO"%>
<%@page import="team.project.model.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 올리는 페이지</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String UID = (String)session.getAttribute("UID");
	int p_status = Integer.parseInt(request.getParameter("p_status"));
	BeomSuDAO dao = new BeomSuDAO();
	List<CategoryDTO> category = dao.getCategory(); 
%>
<body>
<%	if(p_status == 1){ %>
	<form action="ProductSellingPro.jsp" method="post" enctype="multipart/form-data">
	<input type="hidden" name="p_status" value="<%=p_status%>" />
		<table>
			<tr>
				<td>상품 제목<br/>
				<input type="text" name="p_title" required /></td>
			</tr>
			<tr>
				<td>상품 사진(상품 프로필사진)<br/>
				<input type="file" name="p_img1" required /><br/>
				</td>
			</tr>
			<tr>
				<td>상품 사진(상세)<br/>
				<input type="file" name="p_img2" /><br/>
				<input type="file" name="p_img3" /><br/>
				<input type="file" name="p_img4" /></td>
			</tr>
			<tr>
				<td>상한가, 하한가 입력<br/>
				<input type="number" name="p_maxPrice" value="상한가 입력" required/>&nbsp;~&nbsp;<input type="number" name="p_minPrice" value="하한가 입력" required/></td>
			</tr>
			<tr>
				<td><textarea rows="20" cols="100" name="p_content" required></textarea></td>
			</tr>
			<tr>
				<td>판매시작, 종료 날짜 입력<br/>
				<input type="date" name="p_start" required/>&nbsp;~&nbsp;<input type="date" name="p_end" required/></td>
			</tr>
			<tr>
				<td>카테고리 선택<br/>
				<div style=" margin-right: 300px;">
				<form action="" name="ca_no">
					<select name = "ca_no" onchange="window.location.href=document.ca.cano.value" style="width: 150px;">
						<option>카테고리</option>
					<%	for(int i = 0; i<category.size() ; i++){
							CategoryDTO ca = category.get(i);
							if(ca.getCa_level()==0){ %>
								<optgroup label="<%= ca.getCa_name() %>"></optgroup>
							<%	for(int j = 0; j<category.size(); j++){
									CategoryDTO dto = category.get(j);
									if(dto.getCa_level()==1 && dto.getCa_grp()==ca.getCa_grp()){
										%>
											<option value="../selPage/ProductList.jsp?ca_no=<%= dto.getCa_no() %>"><%= dto.getCa_name() %></option>
										<%
									}
								}
							}
						}
					%>
					</select>
				</form>
				</div>
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="작성" />
				<input type="reset" value="초기화" />
				<input type="button" onclick="window.location='../Main.jsp'" value="취소" /></td>
			</tr>
		</table>
	</form>

<%	}else{ %>
	<form action="ProductSellingPro.jsp" method="post" enctype="multipart/form-data">
	<input type="hidden" name="p_status" value="<%=p_status%>" />
		<table>
			<tr>
				<td>상품 제목<br/>
				<input type="text" name="p_title" required /></td>
			</tr>
			<tr>
				<td>상품 사진(상품 프로필사진)<br/>
				<input type="file" name="p_img1" required /><br/>
				</td>
			</tr>
			<tr>
				<td>상품 사진(상세)<br/>
				<input type="file" name="p_img2" /><br/>
				<input type="file" name="p_img3" /><br/>
				<input type="file" name="p_img4" /></td>
			</tr>
			<tr>
				<td>제품 가격 입력<br/>
				<input type="number" name="p_price" value="제품 가격 입력" required/></td>
			</tr>
			<tr>
				<td><textarea rows="20" cols="100" name="p_content" required></textarea></td>
			</tr>
			<tr>
				<td>판매시작, 종료 날짜 입력<br/>
				<input type="date" name="p_start" required/>&nbsp;~&nbsp;<input type="date" name="p_end" required/></td>
			</tr>
			<tr>
				<td>카테고리 선택<br/>
				<div style=" margin-right: 300px;">
					<select name = "ca_no" onchange="window.location.href=document.ca.cano.value" style="width: 150px;" required>
						<option>카테고리</option>
					<%	for(int i = 0; i<category.size() ; i++){
							CategoryDTO ca = category.get(i);
							if(ca.getCa_level()==0){ %>
								<optgroup label="<%= ca.getCa_name() %>"></optgroup>
							<%	for(int j = 0; j<category.size(); j++){
									CategoryDTO dto = category.get(j);
									if(dto.getCa_level()==1 && dto.getCa_grp()==ca.getCa_grp()){
										%>
											<option value="=<%= dto.getCa_no() %>" required><%= dto.getCa_name() %></option>
										<%
									}
								}
							}
						}
					%>
					</select>
				</div>
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="작성" />
				<input type="reset" value="초기화" />
				<input type="button" onclick="window.location='../Main.jsp'" value="취소" /></td>
			</tr>
		</table>
	</form>
<%	} %>
</body>
</html>