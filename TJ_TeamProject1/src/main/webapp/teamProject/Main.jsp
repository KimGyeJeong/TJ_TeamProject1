<%@page import="team.project.dao.LeeDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.model.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.InstanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장물아비 메인페이지</title>

<%-- 최근본상품 보여주는 페이지 --%>
<jsp:include page='floatingAdvertisement.jsp' />

<%
String uid = null;

if (session.getAttribute("UID") == null) { // 로그인 안했을때 
	uid = (String) session.getAttribute("UID");
	// 쿠키가 있는지 검사 
	String cid = null, pw = null, auto = null;
	Cookie[] coos = request.getCookies();
	if (coos != null) {
		for (Cookie c : coos) {
	// 쿠키가 있다면 쿠키에 저장된 값꺼내 변수에 담기
	if (c.getName().equals("autoId"))
		cid = c.getValue();
	if (c.getName().equals("autoPw"))
		pw = c.getValue();
	if (c.getName().equals("autoCh"))
		auto = c.getValue();
		}
		System.out.println("main쿠키확인 :" + cid + pw + auto);
	}

	// 세개 변수에 값이 들어있을 경우 (쿠키 제대로 생성되서 다 갖고 있다.)
	if (auto != null && cid != null && pw != null) {
		// 로그인 처리되도록 loginPro.jsp 처리 페이지로 이동시키기 
		response.sendRedirect("loginPro.jsp");
	}
}
%>


<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#special {
	width: 150px;
	align: "center";
}

table {
	margin: auto;
	width: 80%;
}

#mypagelist {
	list-style: none;
	display: inline-block;
}

#mypagelist li {
	margin: 20px;
	font-size: 18px;
}

#mypagebody {
	position: relative;
	left: 50px;
	display: inline-block;
}

#seller p {
	display: inline;
}
</style>

<%
request.setCharacterEncoding("UTF-8");
InstanceDAO dao = new InstanceDAO();
List<CategoryDTO> category = dao.getCategory();
List<ProductDTO> sellerProduct = dao.getSellerProduct(uid);
SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");

//상품리스트,이미지 불러오기
LeeDAO daoL = new LeeDAO();
List recentProductList = daoL.recentProductList();
List viewsProductList = daoL.viewsProductList();
%>




</head>
<jsp:include page='Header.jsp' />




<body>


	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<style>
.mySlides {
	display: none
}

.w3-left, .w3-right, .w3-badge {
	cursor: pointer
}

.w3-badge {
	height: 13px;
	width: 13px;
	padding: 0
}
</style>
<body>

	<!-- 151~198 까지 슬라이쇼 복붙맨 -->
	<div class="w3-container"></div>
	 
	<div style="padding: 5px 1px 2px 3px;"></div>

	<div class="w3-content w3-display-container">
		<a href="selPage/ProductList.jsp"><img class="mySlides"
			src="img_nature_wide.jpg"></a> <a href="selPage/ProductList.jsp"><img
			class="mySlides" src="img_snow_wide.jpg"></a> <a
			href="selPage/ProductList.jsp"><img class="mySlides"
			src="img_mountains_wide.jpg"></a>
		<div
			class="w3-center w3-container w3-section w3-large w3-text-white w3-display-bottommiddle"
			style="width: 100%">
			<div class="w3-left w3-hover-text-khaki" onclick="plusDivs(-1)">&#10094;</div>
			<div class="w3-right w3-hover-text-khaki" onclick="plusDivs(1)">&#10095;</div>
			<span class="w3-badge demo w3-border w3-transparent w3-hover-white"
				onclick="currentDiv(1)"></span> <span
				class="w3-badge demo w3-border w3-transparent w3-hover-white"
				onclick="currentDiv(2)"></span> <span
				class="w3-badge demo w3-border w3-transparent w3-hover-white"
				onclick="currentDiv(3)"></span>
		</div>
	</div>
	<div align="center">
		<button
			onclick="window.location.href='/TJ_TeamProject1/teamProject/Notice.jsp'"
			style="width: 120px;">공지사항</button>
	</div>

	<script>
<%--슬라이드쇼 자바스크립트부분--%>
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function currentDiv(n) {
  showDivs(slideIndex = n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("demo");
  if (n > x.length) {slideIndex = 1}
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" w3-white", "");
  }
  x[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " w3-white";
}
</script>

	<div style="padding: 20px 300px 20px 300px;">
		<!-- 상품리스트 시작 -->
		<table border="1">
			<tr>
				<td><h3>상품-조회수</h3></td>
			</tr>
			<tr>
				<%
				for (int i = 0; i < recentProductList.size(); i++) {
					ProductDTO dto = (ProductDTO) viewsProductList.get(i);

					if (i % 4 == 0) {
				%>
			
			<tr>
				<%
				}
				%>
				<td id="special"><a id="idAtag" href="#"
					onclick="setSession('<%=dto.getP_no()%>','save/<%=dto.getP_img1()%>')"
					data-p_no="<%=dto.getP_no()%>" rel="noopener noreferrer"> <img
						align="center" src="save/<%=dto.getP_img1()%>" width="250px" /><br /><%=dto.getP_title()%>
				</a></td>

				<%
				}
				%>
			
		</table>
		<br /> <br />

		<table border="1">

			<tr>
				<td><h3>상품-최신순</h3></td>
			</tr>
			<tr>
				<%
				for (int i = 0; i < recentProductList.size(); i++) {
					ProductDTO dto = (ProductDTO) recentProductList.get(i);

					if (i % 4 == 0) {
				%>
			
			<tr>
				<%
				}
				%>
				<td id="special"><a id="idAtag" href="#"
					onclick="setSession('<%=dto.getP_no()%>','save/<%=dto.getP_img1()%>')"
					data-p_no="<%=dto.getP_no()%>" rel="noopener noreferrer"> <img
						align="center" src="save/<%=dto.getP_img1()%>" width="300" /><br /><%=dto.getP_title()%>
				</a></td>

				<%
				}
				%>
			
		</table>
	</div>
	<!-- 상품리스트 끝 -->


	<script type="text/javascript">
        let key = document.getElementById("idAtag").getAttribute('data-p_no');
        console.log("script key : ", key);

        var i = 0;

        var recentView = [];	//배열

        function setSession(pno, img) {
            window.i++;
            console.log("out Function.value i : ", i);

            var Product = {
                p_no: pno,
                testNum: window.i,
                expire: Date.now() + 30000,
                imglink : img
            }

            recentView.unshift(Product);
            localStorage.setItem('First', JSON.stringify(recentView));

            function save(name, val) {
                localStorage.setItem(name, JSON.stringify(val));
            }
            function get(name) {
                return JSON.parse(localStorage.getItem(name));
            }

            var newArray = JSON.parse(localStorage.getItem("First")).reduce(function (acc, current) {
                if (acc.findIndex(({ p_no }) => p_no === current.p_no) === -1) {
                    acc.push(current);
                }
                return acc;
            }, []);
            save("Test", newArray);

            for (let arrRecent = 0; arrRecent < newArray.length; arrRecent++) {
                console.log("for2문 recentView.length Value : ", recentView.length);
                console.log("for2문 arrRecent 값 보기 recentView[arrRecent].p_no.. : ", recentView[arrRecent].p_no);
                console.log("for2문 arrRecent 값 보기 get(Test).. : ", get("Test"));
                console.log("for2문 arrRecent 값 보기 get(Test)[arrRecent].p_no.. : ", get("Test")[arrRecent].p_no);

                let getObj = get("Test");
                console.log("for2문 arrRecent 값 보기 Object.. : ", getObj[arrRecent].p_no);
            }

            window.open('selPage/ProductDetailBuyForm.jsp?p_no='+pno,'_blank');
            location.reload;
            
             
        }
        </script>






	<%@ include file="Footer.jsp"%>
</body>

</html>





</body>
</html>
