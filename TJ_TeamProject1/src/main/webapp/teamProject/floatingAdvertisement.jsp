<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


	<script type="text/javascript"
		src="http://code.jquery.com/jquery-2.1.4.js"></script>

	<div class="sideBanner">
		<span class="txt-label"> 최근본 상품 </span>
		<a href="javascript:goProductTest()">
		<input type="text" id="nameTest" value="before">
		<script type="text/javascript">
		function goProductTest(){
			let getp_noT = JSON.parse(localStorage.getItem("Test"));
			window.open('selPage/ProductDetailBuyForm.jsp?p_no='+getp_noT[0].p_no,'_blank');
		
		}
		</script>
		</a>
		<script type="text/javascript">
		//세션스토리지값 가져오기..
		/*
		let getWebStorage = JSON.parse(localStorage.getItem("Test"));
		for(let webfor = 0; webfor < Object.keys(getWebStorage).length; webfor++){
			let objp_no = getWebStorage[webfor].p_no;
			let objimg = getWebStorage[webfor].imglink;
			
			console.log("Float.jsp Value : ", objp_no);
			console.log("Float.jsp Value : ", objimg);
			
			document.getElementById('nameHere').value=objp_no;
			document.getElementById('nameHerePlz').value=objimg;
		}*/
		
		/*
		for(let getStorage = 0; getStorage<newArray.length;getStorage++){
			console.log("float Test.value : ",recentView.length);
		//	let objp_no = get("Test")[arrRecent].p_no;
		//	let objimg = get("Test")[arrRecent].imglink;
		
			let objp_no = get("Test")[arrRecent].p_no;
			let objimg = get("Test")[arrRecent].imglink;
			
			console.log("FloatValue objp_no : ",objp_no);
			console.log("FloatValue objimg : ",objimg);
			
			document.getElementById('nameHere').value=objp_no;
			document.getElementById('nameHerePlz').value=objp_no;
			location.reload;
		}*/
		
		//
		let goProductNo = JSON.parse(localStorage.getItem("Test"));
		function goProduct(){
			//let getp_no = document.getElementById('nameHere').value;
			window.open('TJ_TeamProject1/teamProject/selPage/ProductDetailBuyForm.jsp?p_no='+goProductNo[0].p_no,'_blank');
		}
			
		</script>

		<table>
			<tr>
				<td><a>
						<div> <img alt="" src=""> </div>
						<div id="nameHere"> 333 </div>
				</a></td>
			</tr>
		</table>
<%-- 상품번호1:<input type="text" readonly="readonly" id="nameHere" name="nameHere">--%>


<table>
<tr>
<td> 
<a href="javascript:goProduct()">
<img id="nameHerePlz" alt="" src="">
상품번호:<input type="text" readonly="readonly" value="testText" id="nameTest"></a> </td>

</tr>
</table>

	</div>
</body>




<style>
body {
	height: 2000px;
}

table {
	margin: auto;
	width: 80%;
}

.sideBanner {
	align-content: center;
	position: absolute;
	width: 150px;
	height: 200px;
	top: 120px;
	background-color: azure;
	color: black;
	right: 0;
}
</style>


<script>
	// 기본 위치(top)값
	var floatPosition = parseInt($(".sideBanner").css('top'))

	// scroll 인식
	$(window).scroll(function() {

		// 현재 스크롤 위치
		var currentTop = $(window).scrollTop();
		var bannerTop = currentTop + floatPosition + "px";

		//이동 애니메이션
		$(".sideBanner").stop().animate({
			"top" : bannerTop
		}, 500);

	}).scroll();
</script>

</body>
</html>