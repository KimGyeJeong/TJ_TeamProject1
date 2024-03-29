
<%@page import="team.project.model.WishListDTO"%>
<%@page import="team.project.dao.InstanceDAO"%>

<%@page import="java.text.SimpleDateFormat"%>

<%@page import="team.project.model.CategoryDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="team.project.model.UserListDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.project.model.ProductQuestionDTO"%>
<%@page import="team.project.model.BiddingDTO"%>
<%@page import="team.project.model.ProductDTO"%>
<%@page import="team.project.dao.BeomSuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 판매 페이지</title>
<link href="/TJ_TeamProject1/teamProject/style.css" rel="stylesheet" type="text/css" />
<style>
#fox{
	display: block;
	margin-left:25%;
	margin-top: 3%;
	
}
textarea {
    width: 100%;
    height: 40em;
  
 
  }
</style>
</head>
<%
	request.setCharacterEncoding("utf-8");
	LocalDateTime now = LocalDateTime.now();
	Date today = Timestamp.valueOf(now);
	System.out.println(today);
	String UID = (String)session.getAttribute("UID");
	String pageNum = (String)request.getParameter("pageNum");
	if(pageNum == null || pageNum == "" || pageNum == "null"){
		pageNum = "0";
	}
	SimpleDateFormat sdf = new SimpleDateFormat("YY-MM-dd HH:mm");
	SimpleDateFormat sdf2 = new SimpleDateFormat("YY-MM-dd");
	String p = request.getParameter("p_no");
	if(p == null){
		p = "-1";
	}
	int p_no = Integer.parseInt(p);
	
	BeomSuDAO dao = new BeomSuDAO();
	InstanceDAO instanceDao = new InstanceDAO();
	ProductDTO dto = null;
	List list = null;
	dto = dao.productDetailBuy(p_no);
	if(dto.getP_delete() == 0){
	int ca_no = dto.getCa_no();
	dao.readCountUp(p_no);
	list = dao.ProductQuestionList(p_no);
	UserListDTO userDTO = dao.userCheck(dto.getP_sellerId());
	int result = today.compareTo(dto.getP_start());
	System.out.println(dto.getP_start());
	System.out.println(dto.getP_end());
	int result2 = today.compareTo(dto.getP_end());
	if(dto.getP_finish() == 0 || dto.getP_finish() == 3){
		if(result < 0){
			dto = dao.ProductDateCheck(p_no);
		}else if (result > 0){
			dto = dao.ProductDateCheck3(p_no);
		}
		if(result2 > 0){
			dto = dao.ProductDateCheck2(p_no);
			List bidList = dao.biddingGet(p_no);
			if(bidList != null){
				for(int i = 0; i<bidList.size(); i++){
					BiddingDTO bidDTO = (BiddingDTO)bidList.get(i);
					if(bidDTO.getB_status() == 0){
					dao.userMoneyReturn(bidDTO.getUser_id(), bidDTO.getB_bidding());
					}
				}
			}
		}
	}
	
	CategoryDTO caDTO = dao.getCategoryName(ca_no);
	
%>
<body>
<jsp:include page='../Header.jsp'/>
<br />
<%if(dto.getP_finish() == 0){ %>	
	<table id='fox'>
		<tr>
			<td rowspan="5"><img src="../save/<%=dto.getP_img1()%>" style="width:300px; height:300px;" /></td>
			<td>상품 제목 : <%=dto.getP_title() %></td>
			<td>조회수 : <%=dto.getP_readCount() %></td>
			<td>작성 일자 : <%=sdf.format(dto.getP_reg()) %><br/>
			판매 시작 일자 : <%=sdf2.format(dto.getP_start())%><br/>
			판매 종료 일자 : <%=sdf2.format(dto.getP_end())%></td>
		</tr>
		<tr>
			<td>판매자 : <%=dto.getP_sellerId() %>&nbsp;별점 : <%=userDTO.getUser_stars() %>/5</td>
			<td>카테고리 : <%=caDTO.getCa_name() %></td>
			<td><button onclick="window.open('ReportForm.jsp?p_no=<%=p_no%>&p_sellerId=<%=dto.getP_sellerId()%>', '상품 신고', 'width=500, height=500, location=no, left=100, top=200')">신고하기</button></td>
		</tr>
<% 			if(dto.getP_status() == 0){%>
		<tr>
			<td colspan="3" align="left">가격 : <%=dto.getP_price() %></td>
		</tr>
		<tr>
			<%	int checkWishList= instanceDao.checkWishList(p_no, UID);
				if(checkWishList == 0){%>
				
			<td><button onclick="window.open('Wish.jsp?p_no=<%=dto.getP_no()%>', '찜', 'width=500, height=500, location=no, left=100, top=200')">찜하기</button></td>
			<%	}else if(checkWishList == 1){ %>
			<td>이미 찜한 상품입니다.</td>
			<% 	} %>
			<td><button onclick="window.location='ProductDetailBuyPro.jsp?p_no=<%=dto.getP_no()%>&p_status=<%=dto.getP_status()%>'">구매하기</button></td>
		</tr>	
<%			}else{%>
		<form action="ProductDetailBuyPro.jsp" method="post">
		<input type="hidden" name="p_status" value="<%=dto.getP_status()%>" />
		<input type="hidden" name="p_no" value="<%=dto.getP_no()%>" />
		<tr>
			<td align="left">희망 입찰가 : <input type="number" name="b_bidding" min="<%=dto.getP_minPrice() %>", max="<%=dto.getP_maxPrice() %>" required /></td>
			<td align="left">하한가 : <%=dto.getP_minPrice() %></td>
			<td align="left">상한가 : <%=dto.getP_maxPrice() %></td>
		</tr>
		<tr>
			<%	int checkWishList= instanceDao.checkWishList(p_no, UID);
				if(checkWishList == 0){%>
			<td><input type="button" onclick="window.open('Wish.jsp?p_no=<%=dto.getP_no()%>', '찜', 'width=500, height=500, location=no, left=100, top=200')" value="찜하기"/></td>
			<%	}else{ %>
			<td>이미 찜한 상품입니다.</td>
			<% 	} %>
			<td><input type="button" onclick="window.location='ProductDetailBuyPro.jsp?p_no=<%=dto.getP_no()%>&p_status=0'" value="즉시구매(상한가구매)"/></td>
			<td><input type="submit" value="입찰하기" /></td>
		</tr>
		</form>
<%			} %>
		<tr>
			<td><button onclick="window.location='ProductDetailBuyForm.jsp?pageNum=0&p_no=<%=p_no%>&ca_no=<%=ca_no%>'">상품 정보</button></td>
			<td><button onclick="window.location='ProductDetailBuyForm.jsp?pageNum=1&p_no=<%=p_no%>&ca_no=<%=ca_no%>'">상품 문의</button></td>
<%		if(UID == null){ 
			UID = " ";
		}%>
<%		if(UID.equals(dto.getP_sellerId())){ %>
			<td><button onclick="window.location='ProductModifyForm.jsp?p_no=<%=p_no%>'">상품 수정</button></td>
<%		}
		if(UID.equals(" ")){
			UID = null;
		}
		%>

		</tr>
<%		if(pageNum.equals("0")){%>
		<tr>
			<td colspan="4">
<%			if(dto.getP_img2() != null){ %>
				<img src="../save/<%=dto.getP_img2() %>" style="width:300px; height:300px;" />
<%			} %>
<%			if(dto.getP_img3() != null){ %>
				<img src="../save/<%=dto.getP_img3() %>" style="width:300px; height:300px;" />
<%			} %>
<%			if(dto.getP_img4() != null){ %>
				<img src="../save/<%=dto.getP_img4() %>" style="width:300px; height:300px;"/>
<%			} %>
				
				<br/>
				<textarea rows="50" cols="80" readonly><%=dto.getP_content() %></textarea>
			</td>
		</tr>       
<%		}else{ %>
		<tr>
			<td colspan="4" align="left">
<%			if(list != null){
				for(int i = 0; i<list.size(); i++){
					ProductQuestionDTO que_dto = (ProductQuestionDTO)list.get(i);
					if(UID == null){
						UID ="";
					}
					if(que_dto.getPq_secret() == 1){ 
						if(que_dto.getUser_id().equals(UID) || UID.equals(dto.getP_sellerId())){%>
					
					
					<h6>제목 : <%=que_dto.getPq_title() %>
<%					if(UID != null){
						if(que_dto.getPq_answer() == null && UID.equals(dto.getP_sellerId())){ %>
						<button onclick="window.open('ProductAnswer.jsp?p_no=<%=p_no%>&pq_no=<%=que_dto.getPq_no() %>&p_sellerId=<%=dto.getP_sellerId() %>', '문의 답변', 'width=500, height=500, location=no, left=100, top=200')">답변하기</button>
<%						}
					}%>
						</h6>
					
					<textarea rows="2" cols="50" readonly><%=que_dto.getPq_content() %></textarea>
					<text readonly>작성자 : <%=que_dto.getUser_id() %> &nbsp; 작성 시간 : <%=que_dto.getPq_writeReg() %></text><br/>
<%						if(que_dto.getPq_answer() != null){%>
							<h6>답변내용</h6>
							&nbsp;&nbsp;&nbsp;<textarea rows="2" cols="50" readonly><%=que_dto.getPq_answer() %></textarea>
							<text readonly>답변 시간 : <%=que_dto.getPq_answerReg() %></text>
				
<%					}	}
					}else{%>
	
							<h6>제목 : <%=que_dto.getPq_title() %>
		<%					if(UID != null){
								if(que_dto.getPq_answer() == null && UID.equals(dto.getP_sellerId())){ %>
								<button onclick="window.open('ProductAnswer.jsp?p_no=<%=p_no%>&pq_no=<%=que_dto.getPq_no() %>&p_sellerId=<%=dto.getP_sellerId() %>', '문의 답변', 'width=500, height=500, location=no, left=100, top=200')">답변하기</button>
		<%						}
							}%>
							</h6>
						
							<textarea rows="2" cols="50"readonly><%=que_dto.getPq_content() %></textarea>
							<text readonly>작성자 : <%=que_dto.getUser_id() %> &nbsp; 작성 시간 : <%=que_dto.getPq_writeReg() %></text><br/>
	<%						if(que_dto.getPq_answer() != null){%>
								<h6>답변내용</h6>
								&nbsp;&nbsp;&nbsp;<textarea rows="2" cols="50" readonly><%=que_dto.getPq_answer() %></textarea>
								<text readonly>답변 시간 : <%=que_dto.getPq_answerReg() %></text>	
	<%						}
					} %>
	<%			if(UID.equals("")){
					UID = null;
				}
			}%>
<%			}else{%>
				<h3>작성된 문의글이 없습니다!</h3>
<%			} %>
			</td>
		</tr>
<%		} %>
		<tr>
			<td colspan="2"><button onclick="window.open('ProductQuestion.jsp?p_no=<%=p_no%>&p_sellerId=<%=dto.getP_sellerId()%>&p_title=<%=dto.getP_title() %>', '상품 문의', 'width=500, height=500, location=no, left=100, top=200')">상품 문의하기</button></td>
			<td colspan="2"><button onclick="window.location='ProductList.jsp?ca_no=<%=dto.getCa_no() %>'">뒤로 가기</button>
<%		if(UID == null){ 
			UID = " ";
		}%>
<%		if(UID.equals(dto.getP_sellerId())){ %>
			<button onclick="func_prompt()" value="confirm">삭제하기</button>
			<script>
			function func_prompt() {
				var con_test = confirm("게시글은 한번 삭제하면 복구할 수 없습니다. 정말로 삭제하시겠습니까?");
				if(con_test == true){
					window.location.assign("ProductDeletePro.jsp?p_no="+<%=p_no%>);	
				}else if(con_test == false){
					window.location.assign("ProductDetailBuyForm.jsp?p_no="+<%=p_no%>);
				}
			}
			</script>
<%		}
		if(UID.equals(" ")){
			UID = null;
		}
		%>
			</td>
		</tr>
	</table>	
<%}else if(dto.getP_finish() == 1){ %>
	<table id='fox'>
		<tr>
			<td rowspan="5"><img src="../save/<%=dto.getP_img1()%>" style="width:300px; height:300px;"/></td>
			<td>상품 제목 : <%=dto.getP_title() %>&nbsp;(판매완료)</td>
			<td>조회수 : <%=dto.getP_readCount() %></td>
			<td>작성 일자 : <%=dto.getP_reg() %><br/>
			판매 시작 일자 : <%=dto.getP_start() %><br/>
			판매 종료 일자 : <%=dto.getP_tempReg() %></td>
		</tr>
		<tr>
			<td>판매자 : <%=dto.getP_sellerId() %>&nbsp;별점 : <%=userDTO.getUser_stars() %>/5</td>
			<td>카테고리 : <%=caDTO.getCa_name() %></td>
			<td><button onclick="window.open('ReportForm.jsp?p_no=<%=p_no%>&p_sellerId=<%=dto.getP_sellerId()%>', '상품 신고', 'width=500, height=500, location=no, left=100, top=200')">신고하기</button></td>
		</tr>
<% 			if(dto.getP_status() == 0){%>
		<tr>
			<td colspan="3" align="left">가격 : <%=dto.getP_price() %></td>
		</tr>
		<tr>
			<td>판매가 완료된 상품입니다!</td>
			<td>판매가 완료된 상품입니다!</td>
		</tr>	
<%			}else{%>
		<form action="ProductDetailBuyPro.jsp" method="post">
		<input type="hidden" name="p_status" value="<%=dto.getP_status()%>" />
		<input type="hidden" name="p_no" value="<%=dto.getP_no()%>" />
		<tr>
			<td align="left">판매가 완료된 상품입니다!</td>
			<td align="left">하한가 : <%=dto.getP_minPrice() %></td>
			<td align="left">상한가 : <%=dto.getP_maxPrice() %></td>
		</tr>
		<tr>
			<td>판매가 완료된 상품입니다!</td>
			<td>판매가 완료된 상품입니다!</td>
			<td>판매가 완료된 상품입니다!</td>
		</tr>
		</form>
<%			} %>
		<tr>
			<td><button onclick="window.location='ProductDetailBuyForm.jsp?pageNum=0&p_no=<%=p_no%>&ca_no=<%=ca_no%>'">상품 정보</button></td>
			<td><button onclick="window.location='ProductDetailBuyForm.jsp?pageNum=1&p_no=<%=p_no%>&ca_no=<%=ca_no%>'">상품 문의</button></td>
		</tr>
<%		if(pageNum.equals("0")){%>
		<tr>
			<td colspan="4">
				<%			if(dto.getP_img2() != null){ %>
				<img src="../save/<%=dto.getP_img2() %>" style="width:300px; height:300px;" />
<%			} %>
<%			if(dto.getP_img3() != null){ %>
				<img src="../save/<%=dto.getP_img3() %>" style="width:300px; height:300px;" />
<%			} %>
<%			if(dto.getP_img4() != null){ %>
				<img src="../save/<%=dto.getP_img4() %>" style="width:300px; height:300px;" />
<%			} %><br/>
				<textarea rows="30" cols="100" readonly><%=dto.getP_content() %></textarea>
			</td>
		</tr>
<%		}else{ %>
		<tr>
			<td colspan="3">
<%			if(list != null){
	for(int i = 0; i<list.size(); i++){
		ProductQuestionDTO que_dto = (ProductQuestionDTO)list.get(i);
		if(UID == null){
			UID ="";
		}
		if(que_dto.getPq_secret() == 1){ 
			if(que_dto.getUser_id().equals(UID) || UID.equals(dto.getP_sellerId())){%>
		
		
		<h6>제목 : <%=que_dto.getPq_title() %>
<%					if(UID != null){
		}%>
			</h6>
		
		<textarea rows="2" cols="50"readonly><%=que_dto.getPq_content() %></textarea>
		<text readonly>작성자 : <%=que_dto.getUser_id() %> &nbsp; 작성 시간 : <%=que_dto.getPq_writeReg() %></text><br/>
<%						if(que_dto.getPq_answer() != null){%>
				<h6>답변내용</h6>
				&nbsp;&nbsp;&nbsp;<textarea rows="2" cols="50" readonly><%=que_dto.getPq_answer() %></textarea>
				<text readonly>답변 시간 : <%=que_dto.getPq_answerReg() %></text>
	
<%					}	}
		}else{%>

				<h6>제목 : <%=que_dto.getPq_title() %>
<%					if(UID != null){
					
				}%>
				</h6>
			
				<textarea rows="2" cols="50"readonly><%=que_dto.getPq_content() %></textarea>
				<text readonly>작성자 : <%=que_dto.getUser_id() %> &nbsp; 작성 시간 : <%=que_dto.getPq_writeReg() %></text><br/>
<%						if(que_dto.getPq_answer() != null){%>
					<h6>답변내용</h6>
					&nbsp;&nbsp;&nbsp;<textarea rows="2" cols="50" readonly><%=que_dto.getPq_answer() %></textarea>
					<text readonly>답변 시간 : <%=que_dto.getPq_answerReg() %></text>	
<%						}
		} %>
<%			if(UID.equals("")){
		UID = null;
	} %>
<%				}%>
<%			}else{%>
				<h3>작성된 문의글이 없습니다!</h3>
<%			} %>
			</td>
		</tr>
<%		} %>
		<tr>
			<td colspan="2">판매가 완료된 상품입니다!</td>
			<td colspan="2"><button onclick="window.location='ProductList.jsp?ca_no=<%=dto.getCa_no() %>'">뒤로 가기</button>
<%		if(UID == null){ 
			UID = " ";
		}%>
<%		if(UID.equals(dto.getP_sellerId())){ %>
			<button onclick="func_prompt()" value="confirm">삭제하기</button>
			<script>
			function func_prompt() {
				var con_test = confirm("게시글은 한번 삭제하면 복구할 수 없습니다. 정말로 삭제하시겠습니까?");
				if(con_test == true){
					window.location.assign("ProductDeletePro.jsp?p_no="+<%=p_no%>);	
				}else if(con_test == false){
					window.location.assign("ProductDetailBuyForm.jsp?p_no="+<%=p_no%>);
				}
			}
			</script>
<%		}
		if(UID.equals(" ")){
			UID = null;
		}
		%>
			</td>
		</tr>
	</table>
<%}else if(dto.getP_finish() == 2){ %>
	<table id='fox'>
		<tr>
			<td rowspan="5"><img src="../save/<%=dto.getP_img1()%>" style="width:300px; height:300px;"/></td>
			<td>상품 제목 : <%=dto.getP_title() %>&nbsp;(거래중지 상품)</td>
			<td>조회수 : <%=dto.getP_readCount() %></td>
			<td>작성 일자 : <%=dto.getP_reg() %><br/>
			판매 시작 일자 : <%=dto.getP_start() %><br/>
			판매 종료 일자 : <%=dto.getP_end() %></td>
		</tr>
		<tr>
			<td>판매자 : <%=dto.getP_sellerId() %>&nbsp;별점 : <%=userDTO.getUser_stars() %>/5</td>
			<td>카테고리 : <%=caDTO.getCa_name() %></td>
			<td><button onclick="window.open('ReportForm.jsp?p_no=<%=p_no%>&p_sellerId=<%=dto.getP_sellerId()%>', '상품 신고', 'width=500, height=500, location=no, left=100, top=200')">신고하기</button></td>
		</tr>
<% 			if(dto.getP_status() == 0){%>
		<tr>
			<td colspan="3" align="left">가격 : <%=dto.getP_price() %></td>
		</tr>
		<tr>
			<td>거래가 중지된 상품입니다!</td>
			<td>거래가 중지된 상품입니다!</td>
		</tr>	
<%			}else{%>
		<form action="ProductDetailBuyPro.jsp" method="post">
		<input type="hidden" name="p_status" value="<%=dto.getP_status()%>" />
		<input type="hidden" name="p_no" value="<%=dto.getP_no()%>" />
		<tr>
			<td align="left">거래가 중지된 상품입니다!</td>
			<td align="left">하한가 : <%=dto.getP_minPrice() %></td>
			<td align="left">상한가 : <%=dto.getP_maxPrice() %></td>
		</tr>
		<tr>
			<td>거래가 중지된 상품입니다!</td>
			<td>거래가 중지된 상품입니다!</td>
			<td>거래가 중지된 상품입니다!</td>
		</tr>
		</form>
<%			} %>
		<tr>
			<td><button onclick="window.location='ProductDetailBuyForm.jsp?pageNum=0&p_no=<%=p_no%>&ca_no=<%=ca_no%>'">상품 정보</button></td>
			<td><button onclick="window.location='ProductDetailBuyForm.jsp?pageNum=1&p_no=<%=p_no%>&ca_no=<%=ca_no%>'">상품 문의</button></td>
		</tr>
<%		if(pageNum.equals("0")){%>
		<tr>
			<td colspan="4">
				<%			if(dto.getP_img2() != null){ %>
				<img src="../save/<%=dto.getP_img2() %>" style="width:300px; height:300px;" />
<%			} %>
<%			if(dto.getP_img3() != null){ %>
				<img src="../save/<%=dto.getP_img3() %>" style="width:300px; height:300px;" />
<%			} %>
<%			if(dto.getP_img4() != null){ %>
				<img src="../save/<%=dto.getP_img4() %>" style="width:300px; height:300px;" />
<%			} %><br/>
				<textarea rows="30" cols="150"  readonly><%=dto.getP_content() %></textarea>
			</td>
		</tr>
<%		}else{ %>
		<tr>
			<td colspan="3">
<%			if(list != null){
	for(int i = 0; i<list.size(); i++){
		ProductQuestionDTO que_dto = (ProductQuestionDTO)list.get(i);
		if(UID == null){
			UID ="";
		}
		if(que_dto.getPq_secret() == 1){ 
			if(que_dto.getUser_id().equals(UID) || UID.equals(dto.getP_sellerId())){%>
		
		
		<h6>제목 : <%=que_dto.getPq_title() %>
<%					if(UID != null){
		}%>
			</h6>
		
		<textarea rows="2" cols="50"readonly><%=que_dto.getPq_content() %></textarea>
		<text readonly>작성자 : <%=que_dto.getUser_id() %> &nbsp; 작성 시간 : <%=que_dto.getPq_writeReg() %></text><br/>
<%						if(que_dto.getPq_answer() != null){%>
				<h6>답변내용</h6>
				&nbsp;&nbsp;&nbsp;<textarea rows="2" cols="50" readonly><%=que_dto.getPq_answer() %></textarea>
				<text readonly>답변 시간 : <%=que_dto.getPq_answerReg() %></text>
	
<%					}	}
		}else{%>

				<h6>제목 : <%=que_dto.getPq_title() %>
<%					if(UID != null){
				}%>
				</h6>
			
				<textarea rows="2" cols="50"readonly><%=que_dto.getPq_content() %></textarea>
				<text readonly>작성자 : <%=que_dto.getUser_id() %> &nbsp; 작성 시간 : <%=que_dto.getPq_writeReg() %></text><br/>
<%						if(que_dto.getPq_answer() != null){%>
					<h6>답변내용</h6>
					&nbsp;&nbsp;&nbsp;<textarea rows="2" cols="50" readonly><%=que_dto.getPq_answer() %></textarea>
					<text readonly>답변 시간 : <%=que_dto.getPq_answerReg() %></text>	
<%						}
		} %>
<%			if(UID.equals("")){
		UID = null;
	} %>
<%				}%>
<%			}else{%>
				<h3>작성된 문의글이 없습니다!</h3>
<%			} %>
			</td>
		</tr>
<%		} %>
		<tr>
			<td colspan="2">거래가 중지된 상품입니다!</td>
			<td colspan="2"><button onclick="window.location='ProductList.jsp?ca_no=<%=dto.getCa_no() %>'">뒤로 가기</button>
<%		if(UID == null){ 
			UID = " ";
		}%>
<%		if(UID.equals(dto.getP_sellerId())){ %>
			<button onclick="func_prompt()" value="confirm">삭제하기</button>
			<script>
			function func_prompt() {
				var con_test = confirm("게시글은 한번 삭제하면 복구할 수 없습니다. 정말로 삭제하시겠습니까?");
				if(con_test == true){
					window.location.assign("ProductDeletePro.jsp?p_no="+<%=p_no%>);	
				}else if(con_test == false){
					window.location.assign("ProductDetailBuyForm.jsp?p_no="+<%=p_no%>);
				}
			}
			</script>
<%		}
		if(UID.equals(" ")){
			UID = null;
		}
		%>
			</td>
		</tr>
	</table>
<%}else if(dto.getP_finish() == 3){ %>
	<table id='fox'>
		<tr>
			<td rowspan="5"><img src="../save/<%=dto.getP_img1()%>" style="width:300px; height:300px;"/></td>
			<td>상품 제목 : <%=dto.getP_title() %>&nbsp;(판매 준비중인 상품입니다!)</td>
			<td>조회수 : <%=dto.getP_readCount() %></td>
			<td>작성 일자 : <%=dto.getP_reg() %><br/>
			판매 시작 일자 : <%=dto.getP_start() %><br/>
			판매 종료 일자 : <%=dto.getP_end() %></td>
		</tr>
		<tr>
			<td>판매자 : <%=dto.getP_sellerId() %>&nbsp;별점 : <%=userDTO.getUser_stars() %>/5</td>
			<td>카테고리 : <%=caDTO.getCa_name() %></td>
			<td>판매 준비중인 상품입니다!</td>
		</tr>
<% 			if(dto.getP_status() == 0){%>
		<tr>
			<td colspan="3" align="left">가격 : <%=dto.getP_price() %></td>
		</tr>
		<tr>
			<td><button onclick="window.open('Wish.jsp?p_no=<%=dto.getP_no()%>', '찜', 'width=500, height=500, location=no, left=100, top=200')">찜하기</button></td>
			<td>판매 준비중인 상품입니다!</td>
		</tr>	
<%			}else{%>
		<form action="ProductDetailBuyPro.jsp" method="post">
		<input type="hidden" name="p_status" value="<%=dto.getP_status()%>" />
		<input type="hidden" name="p_no" value="<%=dto.getP_no()%>" />
		<tr>
			<td align="left">판매 준비중인 상품입니다!</td>
			<td align="left">하한가 : <%=dto.getP_minPrice() %></td>
			<td align="left">상한가 : <%=dto.getP_maxPrice() %></td>
		</tr>
		<tr>
			<td><input type="button" onclick="window.open('Wish.jsp?p_no=<%=dto.getP_no()%>', '찜', 'width=500, height=500, location=no, left=100, top=200')" value="찜하기"/></td>
			<td>판매 준비중인 상품입니다!</td>
			<td>판매 준비중인 상품입니다!</td>
		</tr>
		</form>
<%			} %>
		<tr>
			<td><button onclick="window.location='ProductDetailBuyForm.jsp?pageNum=0&p_no=<%=p_no%>&ca_no=<%=ca_no%>'">상품 정보</button></td>
			<td><button onclick="window.location='ProductDetailBuyForm.jsp?pageNum=1&p_no=<%=p_no%>&ca_no=<%=ca_no%>'">상품 문의</button></td>
<%		if(UID == null){ 
			UID = " ";
		}%>
<%		if(UID.equals(dto.getP_sellerId())){ %>
			<td><button onclick="window.location='ProductModifyForm.jsp?p_no=<%=p_no%>'">상품 수정</button></td>
<%		}
		if(UID.equals(" ")){
			UID = null;
		}
		%>
		</tr>
<%		if(pageNum.equals("0")){%>
		<tr>
			<td colspan="4">
				<%			if(dto.getP_img2() != null){ %>
				<img src="../save/<%=dto.getP_img2() %>" style="width:300px; height:300px;" />
<%			} %>
<%			if(dto.getP_img3() != null){ %>
				<img src="../save/<%=dto.getP_img3() %>" style="width:300px; height:300px;" />
<%			} %>
<%			if(dto.getP_img4() != null){ %>
				<img src="../save/<%=dto.getP_img4() %>" style="width:300px; height:300px;" />
<%			} %><br/>
				<textarea rows="30" cols="100" readonly><%=dto.getP_content() %></textarea>
			</td>
		</tr>
<%		}else{ %>
		<tr>
			<td colspan="3">
<%			if(list != null){
	for(int i = 0; i<list.size(); i++){
		ProductQuestionDTO que_dto = (ProductQuestionDTO)list.get(i);
		if(UID == null){
			UID ="";
		}
		if(que_dto.getPq_secret() == 1){ 
			if(que_dto.getUser_id().equals(UID) || UID.equals(dto.getP_sellerId())){%>
		
		
		<h6>제목 : <%=que_dto.getPq_title() %>
<%					if(UID != null){
			if(que_dto.getPq_answer() == null && UID.equals(dto.getP_sellerId())){ %>
			<button onclick="window.open('ProductAnswer.jsp?p_no=<%=p_no%>&pq_no=<%=que_dto.getPq_no() %>&p_sellerId=<%=dto.getP_sellerId() %>', '문의 답변', 'width=500, height=500, location=no, left=100, top=200')">답변하기</button>
<%						}
		}%>
			</h6>
		
		<textarea rows="2" cols="50" readonly><%=que_dto.getPq_content() %></textarea>
		<text readonly>작성자 : <%=que_dto.getUser_id() %> &nbsp; 작성 시간 : <%=que_dto.getPq_writeReg() %></text><br/>
<%						if(que_dto.getPq_answer() != null){%>
				<h6>답변내용</h6>
				&nbsp;&nbsp;&nbsp;<textarea rows="2" cols="50" readonly><%=que_dto.getPq_answer() %></textarea>
				<text readonly>답변 시간 : <%=que_dto.getPq_answerReg() %></text>
	
<%					}	}
		}else{%>

				<h6>제목 : <%=que_dto.getPq_title() %>
<%					if(UID != null){
					if(que_dto.getPq_answer() == null && UID.equals(dto.getP_sellerId())){ %>
					<button onclick="window.open('ProductAnswer.jsp?p_no=<%=p_no%>&pq_no=<%=que_dto.getPq_no() %>&p_sellerId=<%=dto.getP_sellerId() %>', '문의 답변', 'width=500, height=500, location=no, left=100, top=200')">답변하기</button>
<%						}
				}%>
				</h6>
			
				<textarea rows="2" cols="50"readonly><%=que_dto.getPq_content() %></textarea>
				<text readonly>작성자 : <%=que_dto.getUser_id() %> &nbsp; 작성 시간 : <%=que_dto.getPq_writeReg() %></text><br/>
<%						if(que_dto.getPq_answer() != null){%>
					<h6>답변내용</h6>
					&nbsp;&nbsp;&nbsp;<textarea rows="2" cols="50" readonly><%=que_dto.getPq_answer() %></textarea>
					<text readonly>답변 시간 : <%=que_dto.getPq_answerReg() %></text>	
<%						}
		} %>
<%			if(UID.equals("")){
		UID = null;
	}
}%>
<%			}else{%>
				<h3>작성된 문의글이 없습니다!</h3>
<%			} %>
			</td>
		</tr>
<%		} %>
		<tr>
			<td colspan="2"><button onclick="window.open('ProductQuestion.jsp?p_no=<%=p_no%>&p_sellerId=<%=dto.getP_sellerId()%>&p_title=<%=dto.getP_title() %>', '상품 문의', 'width=500, height=500, location=no, left=100, top=200')">상품 문의하기</button></td>
			<td colspan="2"><button onclick="window.location='ProductList.jsp?ca_no=<%=dto.getCa_no() %>'">뒤로 가기</button>
<%		if(UID == null){ 
			UID = " ";
		}%>
<%		if(UID.equals(dto.getP_sellerId())){ %>
			<button onclick="func_prompt()" value="confirm">삭제하기</button>
			<script>
			function func_prompt() {
				var con_test = confirm("게시글은 한번 삭제하면 복구할 수 없습니다. 정말로 삭제하시겠습니까?");
				if(con_test == true){
					window.location.assign("ProductDeletePro.jsp?p_no="+<%=p_no%>);	
				}else if(con_test == false){
					window.location.assign("ProductDetailBuyForm.jsp?p_no="+<%=p_no%>);
				}
			}
			</script>
<%		}
		if(UID.equals(" ")){
			UID = null;
		}
		%>
			</td>
		</tr>
	</table>
<%		}
	}else{%>
		<script type="text/javascript">
			alert("삭제된 게시물 입니다!");
			window.location.assign("../Main.jsp");
		</script>
<%	} %>	
<br />
 <jsp:include page='../floatingAdvertisement.jsp'/>
	
	<br/>
	<br/>
<%@ include file="../Footer.jsp" %>
</body>
</html>