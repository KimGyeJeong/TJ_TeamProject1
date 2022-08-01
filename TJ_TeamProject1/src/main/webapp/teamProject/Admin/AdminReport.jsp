<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team.project.model.UserListDTO"%>
<%@page import="team.project.model.ReportDTO"%>
<%@page import="team.project.dao.GyeJeongDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="AdminSessionCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminReport</title>
<link href="../style.css" rel="stylesheet" type="text/css">

</head>
<body>
	<%
	//처리중 rp_pro : 1, 처리완료 2
	request.setCharacterEncoding("UTF-8");

	SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");

	String rp_no = request.getParameter("rp_no");
	GyeJeongDAO dao = new GyeJeongDAO();
	ReportDTO dto = dao.getReport(Integer.parseInt(rp_no));

	//피신고자 정보 가져오기
	UserListDTO dto_user = dao.getUserProfile(dto.getRp_reportedUid());
	%>
	<h4><%=rp_no%></h4>



	<table>
		<tr>
			<td colspan="2">신고 내역 확인</td>
		</tr>
		<tr>
			<td>신고 사유</td>
			<td><%=dto.getRp_reason()%></td>
		</tr>
		<tr>
			<td>신고 제목</td>
			<td><%=dto.getRp_title()%></td>
		</tr>
		<tr>
			<td>신고내용</td>
			<td><textarea rows="" cols="" readonly="readonly"><%=dto.getRp_content()%></textarea>
			</td>
		</tr>
		<tr>
			<td>신고자ID</td>
			<td><a href="javascript:goPage('<%=dto.getRp_reportUid()%>');"><%=dto.getRp_reportUid()%></a>
			</td>
		</tr>
		<tr>
			<td>피신고자ID</td>
			<td><a href="javascript:goPage('<%=dto.getRp_reportedUid()%>');">
					<%=dto.getRp_reportedUid()%></a> <script type="text/javascript">
						function goPage(user_id) {
							let f = document.createElement('form');

							let no;
							no = document.createElement('input');
							no.setAttribute('type', 'hidden');
							no.setAttribute('name', 'user_id');
							no.setAttribute('value', user_id);

							f.appendChild(no);
							f.setAttribute('method', 'post');
							f.setAttribute('action', 'AdminShowUser.jsp');

							document.body.appendChild(f);
							f.submit();
						}
					</script></td>
		</tr>
		<tr>
			<td>피신고자 정지상태</td>
			<td>
				<%
				if (dto_user.getUser_activeReg() != null) {
				%> <%=sdf.format(dto_user.getUser_activeReg())%> 까지 정지상태입니다. <%
 } else {
 %> 정지상태가 아닙니다. <%
 }
 %>
			</td>
		</tr>
		<tr>
			<td align="right">유저 상세정보</td>
			<td align="left" colspan="5"><input type="hidden"
				value="<%=dto_user.getUser_id()%>" id="pInput"> <!--  	<input type="button" value="경고" onclick="openChild()">
				<input type="button" value="경고해제" onclick="">--> <input
				type="button" value="활동정지 및 계정정지"
				onclick="openChild('buttonClick/YellowCard.jsp')"> <input
				type="button" value="활동정지 및 계정정지 해제"
				onclick="openChild('buttonClick/ResetYellowCard.jsp')"></td>
		</tr>
		<tr>
			<td>처리중</td>
			<td><form action="AdminReportPro.jsp" method="post">
				<%
				for (int i = 0; i < 3; i++) {
				%> <input type="radio" name="rp_pro"
				value="<%=i%>" <%if (dto.getRp_pro() == i) {%> checked="checked" <%}%>>
				<%
				switch (i) {
					case 0 :
				%>접수중<%
				break;
				case 1 :
				%>처리중<%
				break;
				case 2 :
				%>처리완료<%
				break;
				default :
				%>처리에러<%
				break;
				}
				}
				%>
			</td>
		</tr>
		<tr>
			<td colspan="2">
					<input style="display: none" type="hidden" name="rp_no"
						value="<%=dto.getRp_no()%>"> <input type="submit"
						value="확인">
				</form>
			</td>
		</tr>
	</table>

	<script type="text/javascript">
		let openWin;

		function openChild(url) {
			window.name = "parentForm";
			openWin = window.open(url, "ChildPopUp",
					"width=570, height=350, resizable = no, scrollbars = no");
		}
	</script>

</body>
</html>