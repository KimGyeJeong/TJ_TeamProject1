<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.js"></script> 
<body>
  <div class="sideBanner">
    <span class="txt-label">
      최근본 상품
    </span>
    <tabe>
            
    </tabe>
    
    
  </div>
</body>




<style>

body { height: 2000px; }


table{
			margin: auto;
			width: 80%;
		}

.sideBanner {
  align-content: center;
  position: absolute ;
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