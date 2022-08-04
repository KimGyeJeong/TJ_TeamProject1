<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function a() {
		new daum.Postcode({
			oncomplete : function(data) {
				document.querySelector("#zipcode").value = data.zonecode;
				document.querySelector("#address1").value = data.address
			}
		}).open();
	}

	function openConfimID(inputForm) {
		//아이디 중복 검사 팝업 열기
		//사용자가 id 입력란에 작성을 했는지 체크
		if (inputForm.id.value == "") {
			//!inputForm.id.value 등 방법은 여러가지
			alert("아이디를 입력하세요.")
			return; //메소드 종료
		}
		//아이디 중복 검사 팝업 열기
		let url = "confirmId.jsp?id=" + inputForm.id.value;
		open(url, "confirmId",
				"width=300, height=650, toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no");
	}


	
	function acountCheck(){
		let inputs = document.SignUpForm; 
		if(!inputs.id.value){
			alert("아이디를 입력해주세요.");
			return false; 
		}
		if(!inputs.pw.value){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		if(inputs.pw.value != inputs.pwch.value){
			alert("비밀번호값과 비밀번호 재확인값이 같지않습니다. ");
			return false;
		}
		if(!inputs.name.value){
			alert("이름을 입력해주세요.");
			return false;
		}
		if(!inputs.email.value){
			alert("이메일 입력해주세요.");
			return false;
		}
		if(!inputs.phone.value){
			alert("휴대폰번호를 입력해주세요.");
			return false;
		}
		if(!inputs.addressName.value){
			alert("주소지명을 입력해주세요.");
			return false;
		}
		if(!inputs.zipcode.value){
			alert("우편번호를 입력해주세요.");
			return false;
		}
		if(!inputs.address1.value){
			alert("주소를 입력해주세요.");
			return false;
		}
		if(!inputs.photo.value){
			alert("프로필사진을 올려주세요!");
			return false;
		}
	}
		function openConfirmID(inputForm) {
			//아이디 중복 검사 팝업 열기
			//사용자가 id 입력란에 작성을 했는지 체크
			if (inputForm.id.value == "") {
				//!inputForm.id.value 등 방법은 여러가지
				alert("아이디를 입력하세요.")
				return; //메소드 종료
			}
			//아이디 중복 검사 팝업 열기
			let url = "confirmId.jsp?id=" + inputForm.id.value;
			open(url, "confirmId","width=300, height=650, toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no");
		
		
	}
	
</script>

<% 
	request.setCharacterEncoding("UTF-8"); 

%>



<title>장물아비 회원가입페이지</title>

<style>
#SignUpForm tr td input{
	width: 300px;
}


</style>

</head>
<body>
<jsp:include page='../Header.jsp'/>
<jsp:include page='../floatingAdvertisement.jsp'/>
	<br />
	<h1 align="center">회원가입</h1>
	<br/>
	<form action="SignUpPro.jsp" method="post" enctype="multipart/form-data" name="SignUpForm" onsubmit="return acountCheck()">
		<div style="margin-left: 30%;">
		<table id="SignUpForm">
			<tr>
				<td>아이디 *</td> 

				<td><input  type="text" name="id" style="width:200px;" required="required" />&nbsp;<input type="button" value="중복 확인"
					onclick="openConfimID(this.form)" style="width:100px;" ></td> 

			</tr>
			<tr>
				<td>비밀번호 *</td>
				<td><input type="password" name="pw" /></td>
			</tr>
			<tr>
				<td>비밀번호 확인 *</td>
				<td><input type="password" name="pwch" /></td>
			</tr>

			<tr>
				<td>이름 *</td>
				<td><input type="text" name="name" /></td>
			</tr>

			<tr>
				<td>email*</td>
				<td><input type="email" name="email" /></td>
			</tr>
			<tr>
				<td>phone*</td>
				<td><input type="text" name="phone" /></td>
			</tr>
			<tr>
				<td>배송지명*</td>
				<td><input type="text" name="addressName" /></td>
			</tr>
			<tr>
				<td width="200">우편번호*</td>
				<td><input type="text" name="zipcode" id="zipcode" size="7" style="width:200px;">
					<input type="button" onclick="a()" value="우편번호찾기" style="width:100px;"></td>
			</tr>
			<tr>
				<td>주소*</td>
				<td><input type="text" name="address1" id="address1" size="70">
				</td>
			</tr>
			<tr>

				<td>상세주소</td>
				<td><input type="text" name="address2" id="address2" size="70">
				</td>
			</tr>
			<tr>
				<td>photo*</td>
				<td><input type="file" name="photo" value="File Upload" /></td>
			
			<tr>
				<td colspan="2" align="center"><input type="submit" value="회원 가입" style="width:100px;"/> <input
					type="reset" value="재작성"  style="width:100px;"/> <input type="button" value="취소"
					onclick="window.location='../Main.jsp'"style="width:100px;" /></td>
			</tr>
		</table>
		</div>
		
	</form>
	<br/>
	<br/>
	<br/>
<%@ include file="../Footer.jsp" %>
</body>
</html> 
