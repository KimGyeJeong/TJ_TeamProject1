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
<script>
function acountCheck(){
	let inputs = document.ProductSell; 
	
	if(inputs.p_minPrice.value > inputs.p_maxPrice.value){
		alert("하한가는 상한가보다 클 수 없습니다. ");
		return false;
	}
	if(inputs.p_minPrice.value == inputs.p_maxPrice.value){
		alert("하한가와 상한가는 같을 수 없습니다. ");
		return false;
	}
}

</script>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String UID = (String)session.getAttribute("UID");
	int p_status = Integer.parseInt(request.getParameter("p_status"));
	BeomSuDAO dao = new BeomSuDAO();
	List<CategoryDTO> category = dao.getCategory(); 
%>
<body>
<style>
#fox{
	display: block;
	margin-left: 25%;
	margin-top: 3%;
;
}
</style>
<jsp:include page='../Header.jsp'/>
<%
if(UID != null){

if(p_status == 1){ %>

	<form action="ProductSellingPro.jsp" method="post" enctype="multipart/form-data" name="ProductSell" onsubmit="return acountCheck()">
	<input type="hidden" name="p_status" value="<%=p_status%>" />
	<input type="hidden" name="p_sellerId" value="<%=UID%>" />
		<table id='fox'>
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
				<td>하한가, 상한가 입력<br/>
				하한가<input type="number" name="p_minPrice"  required/>&nbsp;&nbsp;상한가<input type="number" name="p_maxPrice" required/></td>
			</tr>
			
			<tr>
				<td><textarea rows="20" cols="100" name="p_content" required></textarea></td>
			</tr>
			<tr>
				<td>판매시작, 종료 날짜 입력<br/>
				<input type="date" id="p_start" name="p_start" required/>&nbsp;~&nbsp;<input type="date" name="p_end" id="p_end" required/></td>
			</tr>
			<tr>
				<td>카테고리 선택<br/>
				<div style=" margin-right: 300px;">
					<select name = "ca_no" onchange="window.location.href=document.ca_no.value" style="width: 150px;" required>
						<option>카테고리</option>
					<%	for(int i = 0; i<category.size() ; i++){
							CategoryDTO ca = category.get(i);
							if(ca.getCa_level()==0){ %>
								<optgroup label="<%= ca.getCa_name() %>"></optgroup>
							<%	for(int j = 0; j<category.size(); j++){
									CategoryDTO dto = category.get(j);
									if(dto.getCa_level()==1 && dto.getCa_grp()==ca.getCa_grp()){
										%>
											<option value="<%= dto.getCa_no() %>" required><%= dto.getCa_name() %></option>
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

<%	}else{ %>
	<form action="ProductSellingPro.jsp" method="post" enctype="multipart/form-data">
	<input type="hidden" name="p_status" value="<%=p_status%>" />
	<input type="hidden" name="p_sellerId" value="<%=UID%>" />
		<table id='fox'>
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
				<input type="date" id="p_start" name="p_start" required/>&nbsp;~&nbsp;<input type="date" name="p_end" id="p_end" required/></td>
			</tr>
			<tr>
				<td>카테고리 선택<br/>
				<div style=" margin-right: 300px;">
					<select name = "ca_no" onchange="window.location.href=document.ca_no.value" style="width: 150px;" required>
						<option>카테고리</option>
					<%	for(int i = 0; i<category.size() ; i++){
							CategoryDTO ca = category.get(i);
							if(ca.getCa_level()==0){ %>
								<optgroup label="<%= ca.getCa_name() %>"></optgroup>
							<%	for(int j = 0; j<category.size(); j++){
									CategoryDTO dto = category.get(j);
									if(dto.getCa_level()==1 && dto.getCa_grp()==ca.getCa_grp()){
										%>
											<option value="<%= dto.getCa_no() %>" required><%= dto.getCa_name() %></option>
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
	
<%	}%>
	<script>
	
	let dateElement = document.getElementById('p_start');
    let date = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().slice(0, -14);
    dateElement.value = date;
    dateElement.setAttribute("min", date);
    let dateElement1 = document.getElementById('p_start');
    let date1 = new Date(new Date().getTime()+604800000 - new Date().getTimezoneOffset() * 60000).toISOString().slice(0, -14);
    dateElement1.value = date1;
    dateElement1.setAttribute("max", date1);
    document.getElementById('p_start').value = new Date().toISOString().substring(0, 10);
    let dateElement2 = document.getElementById('p_end');
    dateElement2.value = date1;
    dateElement2.setAttribute("min", date1);
    let dateElement3 = document.getElementById('p_end');
    let date2 = new Date(new Date().getTime()+(604800000*2) - new Date().getTimezoneOffset() * 60000).toISOString().slice(0, -14);
    dateElement3.value = date2;
    dateElement3.setAttribute("max", date2);

	</script>
<%	}else{%>
		<script>
			alert("로그인 후 이용해 주세요!");
			window.location.assign("../Login/Login.jsp");
		</script>
<%	} %>
 <jsp:include page='../floatingAdvertisement.jsp'/>
	
	<br/>
	<br/>
<%@ include file="../Footer.jsp" %>
</body>
</html>