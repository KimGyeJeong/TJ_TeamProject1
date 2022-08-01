<%@page import="team.project.model.ContentDTO"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team.project.model.AddressDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.model.UserListDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="AdminSessionCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminShowUser</title>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>

	<%
	request.setCharacterEncoding("UTF-8");
	SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");

	String pageNum = request.getParameter("pageNum");
	String search = request.getParameter("search");
	String user_id = request.getParameter("user_id");

	int listSize = 0; //판매글, 게시글 3개 이하로만 노출시키기 위해 사용

	GyeJeongDAO dao = new GyeJeongDAO();
	UserListDTO dto = dao.getUserProfile(user_id);

	List<AddressDTO> list = dao.getUserAddress(user_id);
	AddressDTO dto_a = null;

	List<ProductDTO> list_product = dao.getUserProductList(user_id);
	ProductDTO dto_p = null;

	List<ContentDTO> list_content = dao.getUserContentList(user_id);
	ContentDTO dto_c = null;
	//address 에러 --> 해당 아이디에 주소가 없으면 500에러 발생
	%>

	<h1>
		A.S.U TEST pageNum =
		<%=pageNum%>, search =
		<%=search%>, user_id =
		<%=user_id%></h1>

	<div id="Profile">
		<table>
			<tr>
				<td align="right">유저 상세정보</td>
				<td align="left" colspan="5"><input type="hidden"
					value="<%=dto.getUser_id()%>" id="pInput"> <!--  	<input type="button" value="경고" onclick="openChild()">
				<input type="button" value="경고해제" onclick="">--> <input
					type="button" value="활동정지 및 계정정지"
					onclick="openChild('buttonClick/YellowCard.jsp')"> <input
					type="button" value="활동정지 및 계정정지 해제"
					onclick="openChild('buttonClick/ResetYellowCard.jsp')"></td>
			</tr>
		</table>

		<br>

		<div id="userProfileDetail">
			<table>
				<tr>
					<td>ID</td>
					<td colspan="2" width="10" align="left"><%=dto.getUser_id()%></td>
					<td>성명</td>
					<td colspan="2"><input type="text" name="name"
						value="<%=dto.getUser_name()%>"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td colspan="5"><input type="email" name="email"
						value="<%=dto.getUser_email()%>"></td>
				</tr>
				<tr>
					<td>휴대폰 번호</td>
					<td colspan="5"><input type="text" name="phone"
						value="<%=dto.getUser_phone()%>"></td>
				</tr>
				<tr>
					<td>현재 잔액</td>
					<td colspan="2"><input type="text" name="money"
						value="<%=dto.getUser_money()%>" disabled="disabled"> 원</td>
					<td>사용 가능 잔액</td>
					<td colspan="2"><input type="text" name="usemoney"
						value="<%=dto.getUser_usemoney()%>" disabled="disabled"> 원</td>
				</tr>
				<%
				if (list != null) {
					//주소 없으면 출력X
					for (int i = 0; i < list.size(); i++) {
						dto_a = list.get(i);
				%>

				<tr>
					<td rowspan="3"><%=i + 1%>번째 주소</td>
					<td>배송지명 : <input type="text" value="<%=dto_a.getA_tag()%>">
					</td>
					<td>우편번호 : <input type="text"
						value="<%=dto_a.getA_zipCode()%>" disabled="disabled"></td>
					<td>수령자 이름 : <input type="text" value="<%=dto_a.getA_name()%>"></td>
					<td>배송지 최근 사용 일자 : <input type="text"
						value="<%=dto_a.getA_usereg()%>" disabled="disabled"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td colspan="5"><input type="text" size="50"
						value="<%=dto_a.getA_address()%>"></td>
				</tr>
				<tr>
					<td>상세 주소</td>
					<td colspan="5"><input type="text" size="50"
						value="<%=dto_a.getA_address2()%>"></td>
				</tr>
				<%
				}
				}
				%>
				<tr>
					<td>별점 평균</td>
					<td colspan="5"><input type="text"
						value="<%=dto.getUser_stars()%>">/5 점</td>
				</tr>
			</table>
		</div>
		<br>
		<div id="UserInformation">
			<table>
				<tr>
					<td>가입일</td>
					<td>삭제여부(O,X)</td>
					<td>삭제날짜</td>
					<td>신고누적횟수</td>
					<td>계정상태</td>
					<td>정지해제일</td>
				</tr>
				<tr>
					<td><%=sdf.format(dto.getUser_reg())%></td>
					<%
					if (dto.getUser_delete() < 1) {
					%>
					<td>활동중인계정</td>
					<%
					} else {
					%>
					<td>삭제된계정</td>
					<%
					}
					%>

					<%
					if (dto.getUser_deleteReg() == null) {
					%>
					<td>활동중인계정</td>
					<%
					} else {
					%>
					<td><%=sdf.format(dto.getUser_deleteReg())%></td>
					<%
					}
					%>

					<td><%=dto.getUser_reportCnt()%></td>
					<td><%=dto.getUser_report()%></td>
					<%
					if (dto.getUser_activeReg() == null) {
					%>
					<td>정지상태가아닙니다.</td>
					<%
					} else {
					%>
					<td><%=sdf.format(dto.getUser_activeReg())%>까지 정지상태입니다</td>
					<%
					}
					%>
				</tr>
			</table>
		</div>
		<br>
		<div id="showUserList">
			<table>
				<tr>
					<td align="left">
						<div id="sellList" align="left">
							<form>
								<table>
									<%
									if (list_product != null) {
										if (list_product.size() > 3){
											listSize = 3;
										}else
											listSize = list_product.size();
									%>
									<tr style="display: none">
										<td><input type="hidden" value="<%=dto.getUser_id()%>"
											name="user_id"></td>
									</tr>
									<tr>
										<td>판매글 리스트
									<%--	<% if(list_product.size()>3){%> --%>
										<% if(list_product.size()>1){%>
											<button style="width: 60pt" type="submit"
											<%-- 
												formaction="buttonClick/MoreProductList.jsp"--%>
												formaction="AdminProductList.jsp?search=<%=dto.getUser_id() %>"
												formmethod="post">+더보기</button>
												<% }%>
										</td>
									</tr>
									<%
									for (int i = 0; i < listSize; i++) {
										dto_p = list_product.get(i);
									%>
									<tr>
										<td><a
											href="../selPage/ProductDetailBuyForm.jsp?p_no=<%=dto_p.getP_no()%>&ca_no=<%=dto_p.getCa_no()%>"><%=dto_p.getP_title()%></a>
										</td>
									</tr>
									<%
									}
									} else {
									%>
									<tr>
										<td>판매글이 없습니다.</td>
									</tr>
									<%
									}
									%>
								</table>
							</form>
						</div>
					</td>
					<td align="right">
						<div id="contextList" align="right">
							<form>
								<table>
									<%
									listSize = 0;
									if (list_content != null) {
										if (list_content.size() > 3){
											listSize = 3;
										}else
											listSize = list_content.size();
									%>
									<tr style="display: none">
										<td><input type="hidden" value="<%=dto.getUser_id()%>"
											name="user_id"></td>
									</tr>
									<tr>
										<td>게시글 리스트
										<% if(list_content.size()>3){ %>
											<button style="width: 60pt" type="submit"
												formaction="buttonClick/MoreContentList.jsp"
												formmethod="post">+더보기</button>
												<% }%>
										</td>
									</tr>
									<%
									for (int i = 0; i < listSize; i++) {
										dto_c = list_content.get(i);
									%>
									<tr>
										<td><a href=""><%=dto_c.getC_title()%></a></td>
									</tr>
									<%
									}
									} else {
									%>
									<tr>
										<td>게시글이 없습니다.</td>
									</tr>
									<%
									}
									%>
								</table>
							</form>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>


	<script type="text/javascript">
		let openWin;

		function openChild(url) {
			window.name = "parentForm";
			openWin = window.open(url, "ChildPopUp",
					"width=570, height=350, resizable = no, scrollbars = no");
		}
	</script>

	<div align="left">
		<input type="button" value="go main" onclick="location.href='AdminMain.jsp'">
	</div>
</body>
</html>