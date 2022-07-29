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
<body>
	<div class="sideBanner">
		<span class="txt-label"> 최근본 상품 </span>
		
		<script type="text/javascript">
		//세션스토리지값 가져오기..
		for(let getStorage = 0; getStorage<newAray.length;getStorage++){
			console.log("float Test.value : ",recentView.length);
			let objp_no = get("Test")[arrRecent].p_no;
			let objimg = get("Test")[arrRecent].imglink;
			
			console.log("FloatValue objp_no : ",objp_no);
			console.log("FloatValue objimg : ",objimg);
			
			document.getElementById('nameHere').value=objp_no;
			document.getElementById('nameHerePlz').value=objp_no;
			location.reload;
		}
		
		const objString = window.localStorage.getItem();
		
		function getStoragevalue(){
			
		}
		//document.getElementById('FirstImg').value = recentView[0].p_no;
			
		</script>

		<table>
			<tr>
				<td><a>
						<div> <img alt="" src=""> </div>
						<div id="nameHere">  </div>
				</a></td>
			</tr>
		</table>
<input type="text" readonly="readonly" id="nameHerePlz" name="nameHerePlz">

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