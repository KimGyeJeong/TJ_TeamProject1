<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>배송지 추가하기</h1>
<form action="addAddressPro.jsp" method="get">
배송지명
<input type="text" name="aTag"> <br>
받으시는분
<input type="text" name="aname"> <br>
주소
<input type="text" name="address1" id="address"> <input type="text" name="zipcode" id="zipcode">  <input type="button" onclick="seachzipcode()" value="주소찾기"><br>
상세주소<input type="text" name="address2"> <br>
배송시 요청사항
<input type="text" name="acomment"> <br>

<input type="submit" value="추가하기" > <input type="reset" value="리셋"> <button type="button" onclick="window.close()" >취소</button>
</form>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
        function seachzipcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    document.querySelector("#zipcode").value = data.zonecode;
                    document.querySelector("#address").value = data.address;
                }
            }).open();
        }
	</script>
</body>
</html>