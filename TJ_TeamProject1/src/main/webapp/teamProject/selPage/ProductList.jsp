<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.dao.BeomSuDAO"%>
<%@page import="team.project.model.UserQuestionDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="team.project.dao.LeeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ProductList</title>
<link href="../style.css" rel="stylesheet" type="text/css" />

<%request.setCharacterEncoding("UTF-8");
	String ca = request.getParameter("ca_no");
	if(ca == null){
		ca = "3";
	}
	int ca_no = Integer.parseInt(ca);
 	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){ 
		pageNum = "1";   
	}
	System.out.println("pageNum : " + pageNum);
	
	int pageSize = 10;   
	int currentPage = Integer.parseInt(pageNum);  
	int startRow = (currentPage - 1) * pageSize + 1; 
	int endRow = currentPage * pageSize; 
 	
 	int count=0;
 	List list = null;
 	BeomSuDAO dao = new BeomSuDAO();
 	String sel = request.getParameter("sel");
 	//제목 , 글 본문 내용으로 검색기능
 	String search = request.getParameter("search");
 	if(sel != null && search != null){//검색게시판
 		
 		if(count >0){
 			
 		}
 	}else{ //일반게시판 
 		count = dao.getProductListCount(ca_no);
 		if(count >0){
 			list =dao.categorySelect(startRow, endRow, ca_no);
 		}
 	}
	int number = count - (currentPage - 1) * pageSize;
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm"); 
	System.out.println(ca_no);
	
	
	
 %>

</head>
<body>
<jsp:include page='../Header.jsp'/>

	
	<br />
	<h1 align="center">상품 리스트</h1>
	<br />

	<br />
		<table align="center" border="0" >
			<tr >
		<%
		if(list != null){
			for(int i = 0; i<list.size(); i++){
				int num = i;
				ProductDTO dto = (ProductDTO)list.get(i);
				if(i%5==0){%>
				<tr>
<%				} %>
<%				if(dto.getP_delete() == 0){	
	%>
	<td><a href="#" onclick="setSession('<%=dto.getP_no()%>','/TJ_TeamProject1/teamProject/save/<%=dto.getP_img1()%>')">
						<img src="../save/<%=dto.getP_img1() %>" style="width:300px; height:300px;" /><br/>
						<%switch(dto.getP_finish()){
						case 0: %>(판매중)<% break;
						case 1: %>(판매완료)<% break;
						case 2: %>(판매중지)<% break;
						case 3: %>(판매준비)<% break;
						default : %>(판매에러)<% break;
						}
						%>
						<%=dto.getP_title() %>
						</a>
						</td>
	<%-- 
	<%
		if(dto.getP_finish() != 0){%>
				 	ProductDetailBuyForm.jsp?p_no=<%=dto.getP_no()%>&ca_no=<%=dto.getCa_no()%> 
						<td><a href="#" onclick="setSession('<%=dto.getP_no()%>','/TJ_TeamProject1/teamProject/save/<%=dto.getP_img1()%>')">
						<h4>TestDTO.... <%=dto.getP_no() %></h4>
						<img src="../save/<%=dto.getP_img1() %>" width="250px"/><br/>
						<%=dto.getP_title() %>
						
						</a>
						</td>
				<%	}else if(dto.getP_finish() == 1){ %>
						<td><a href="#" onclick="setSession('<%=dto.getP_no()%>','/TJ_TeamProject1/teamProject/save/<%=dto.getP_img1()%>'">
						<h4>TestDTO.... <%=dto.getP_no() %></h4>
						<img src="../save/<%=dto.getP_img1() %>" width="250px"/><br/>
						<%=dto.getP_title() %>&nbsp;(이미 팔린 상품!)
						</a>
						</td>
				<%	}else if(dto.getP_finish() == 2){ %>
						<td><a href="#" onclick="setSession('<%=dto.getP_no()%>','/TJ_TeamProject1/teamProject/save/<%=dto.getP_img1()%>'">>
						<img src="../save/<%=dto.getP_img1() %>" width="250px"/><br/>
						<%=dto.getP_title() %>&nbsp;(판매 중지된 상품!)
						</a>
						</td>
				<%	}else{ %>
						<td><a href="#" onclick="setSession('<%=dto.getP_no()%>','/TJ_TeamProject1/teamProject/save/<%=dto.getP_img1()%>'">>
						<img src="../save/<%=dto.getP_img1() %>" width="250px"/><br/>
						<%=dto.getP_title() %>&nbsp;(판매 준비중인 상품!)
						</a>
						</td>
						</tr>
				<%	}//else 닫음 %>  
<%			}--%>
<%	}	//if
			}//for
		}else{%>
		<tr> <td>
		<h4>해당 카테고리에 상품이 없습니다!</h4>
		</td> </tr>
<%		} %>
			
		</table>


	<br />
	<div align="center">
		<%
			if(count >0){
				int pageCount = count/ pageSize +(count % pageSize == 0? 0:1);
				int pageNumSize = 3;
				int startPage = (int)((currentPage-1)/pageNumSize)*pageNumSize + 1; 
				int endPage = startPage + pageNumSize - 1;
				
				if(endPage > pageCount){ endPage = pageCount;}
				
				if(startPage > pageNumSize){%>
		<a class="pageNums" href="ProductList.jsp?pageNum=<%=startPage-1%>&ca_no=<%=ca_no%>">
			&lt; &nbsp; </a>
		<%}
				for(int l = startPage; l <= endPage; l++){ %>
		<a class="pageNums" href="ProductList.jsp?pageNum=<%=l%>&ca_no=<%=ca_no%>"> &nbsp;
			<%=l%> &nbsp;
		</a>
		<%}
			
				if(endPage < pageCount) { %>
		<a class="pageNums"
			href="ProductList.jsp?pageNum=<%=startPage+pageNumSize%>&ca_no=<%=ca_no%>"> &nbsp;
			&gt; </a>
		<%}
	}%>
	<br/>
	<br/>
	</div>
	
	<script type="text/javascript">
       // let key = document.getElementById("idAtag").getAttribute('data-p_no');
       // console.log("script key : ", key);

        var i = 0;

        var recentView = [];	//배열
        var newArray=[];

        function setSession(pno, img) {
        	
        	//alert("ProductList.Script 156 Session");
            window.i++;
            console.log("out Function.value i : ", i);

            let Product = {
                p_no: pno,
                testNum: window.i,
               // expire: Date.now() + 30000,
                imglink : img
            }

            recentView.unshift(Product);
            sessionStorage.setItem('First', JSON.stringify(recentView));

            function save(name, val) {
            	sessionStorage.setItem(name, JSON.stringify(val));
            }
            function get(name) {
                return JSON.parse(sessionStorage.getItem(name));
            }

            //배열 정리. 중복된값 있으면 삭제해줌
             newArray = JSON.parse(sessionStorage.getItem("First")).reduce(function (acc, current) {
                if (acc.findIndex(({ p_no }) => p_no === current.p_no) === -1) {
                    acc.push(current);
                }
                return acc;
            }, []);
            save("Test", newArray);

    /*        for (let arrRecent = 0; arrRecent < newArray.length; arrRecent++) {
                console.log("for2문 recentView.length Value : ", recentView.length);
                console.log("for2문 arrRecent 값 보기 recentView[arrRecent].p_no.. : ", recentView[arrRecent].p_no);
                console.log("for2문 arrRecent 값 보기 get(Test).. : ", get("Test"));
                console.log("for2문 arrRecent 값 보기 get(Test)[arrRecent].p_no.. : ", get("Test")[arrRecent].p_no);

                let getObj = get("Test");
                console.log("for2문 arrRecent 값 보기 Object.. : ", getObj[arrRecent].p_no);
            }*/

            window.open('ProductDetailBuyForm.jsp?p_no='+pno,'_blank');
           // location.reload;	//배열은 초기화되지않으나 float 는 새로고침이 안됨
            //스크립트는 초기화가 아니지만, float는 새로고침이 안됨 109번 alert도 안뜸 --> 새로고침이 아님,,?
            history.go(0);	//float 까지 새로고침 시키려면 사용해야하나. 배열이 초기화됨
            // 스크립트까지 초기화
           //alert("reload!");
            
            //Temp
    		let getWebStorage = JSON.parse(sessionStorage.getItem("Test"));
            
			let objp_no = getWebStorage[0].p_no;
			let objimg = getWebStorage[0].imglink;
			document.getElementById('nameTest').value=objp_no;
			
			document.getElementById('nameHerePlz').value=objimg;
			document.getElementById('nameHerePlz').src=objimg;
            /*
    		for(let webfor = 0; webfor < Object.keys(getWebStorage).length; webfor++){
    			let objp_no = getWebStorage[webfor].p_no;
    			let objimg = getWebStorage[webfor].imglink;
    			
    			console.log("Float.jsp Value pno : ", objp_no);
    			console.log("Float.jsp Value img : ", objimg);
    			
    		//	document.getElementById('nameHere').value=objp_no;
    			document.getElementById('nameTest').value=objp_no;
    			
    			document.getElementById('nameHerePlz').value=objimg;
    		}*/
            
             
        }
        </script>
        <jsp:include page='../floatingAdvertisement.jsp'/>
	
	<br/>
	<br/>
<%@ include file="../Footer.jsp" %>
</body>
</html>