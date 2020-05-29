<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<body class="hold-transition skin-blue sidebar-mini">
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.3/handlebars.js"></script>
	<script>
		$(function(){
			
			//장바구니 추가
			$("#btnAddCart").on("click",function(){

				if('${sessionScope.userVO.user_id}' == ''){
						alert("로그인 하세요");
						return false;
					} else {
						var data = {
							product_code : "${productVO.product_code}",
							user_id : '${sessionScope.userVO.user_id}',
							product_count : $("#inputAmount").val()
						};	

					$.ajax({
						url : "/cart/addCart",
						type : "POST",
						data : data,
						success : function(){
									if(confirm("장바구니 추가 되었습니다. 장바구니로 이동하시겠습니까?")){
										location.href = "/cart/cart";
										} else {}
									}
						});				
					}
				});

			Handlebars.registerHelper("prettifyDate", function(timeValue) {
				var dateObj = new Date(timeValue);
				var year = dateObj.getFullYear();
				var month = dateObj.getMonth() + 1;
				var date = dateObj.getDate();
				return year + "/" + month + "/" + date;
			});
			
			Handlebars.registerHelper("writer", function(user_id) {
				var str;
				if(user_id == '${userVO.user_id}'){
					str  = '<button type="button" class="btn btn-box-tool reviewModbtn" data-toggle="modal" data-target="#modal-default"';
					str += '><i class="fa fa-cog"></i></button>';
					str += '<button type="button" class="btn btn-box-tool reviewDelbtn"><i class="fa fa-trash"></i></button>';
					} else{
					str = '';
						}
				return new Handlebars.SafeString(str);
			});
			
			$(".btn-box-tool").on("click",function(){
					$.getJSON("/product/readReview/"+'${productVO.product_code}' ,function(data){
						var template = Handlebars.compile($(
						"#reviewTemplate").html());
						var html = template(data);
						$("#reviewUl").empty();
						$("#reviewUl").append(html);
						});
				});


			var review_id;
			$('button[name="writeReview"]').on("click",function(){
					$.ajax({
						url : "/product/modifyReview",
						type : "POST",
						data : {
							review_id : review_id,
							review_content : $("input[name='review_content']").val()
							},
						success : function(data){
							if(data == 1){
								alert("수정되었습니다.");
								location.reload();
								}
							}
						});
				});

			$("#reviewUl").on("click",".reviewDelbtn",function(){
				if(confirm("삭제하시겠습니까?")){
					$.ajax({
						url : "/product/deleteReview",
						type : "POST",
						data : {
						review_id :	$(this).parents(".review-tools").attr("data-id")
						},
						success : function(data){
							if(data==1){
								alert("삭제되었습니다.");
								location.reload();
								}
							} 
						});
					} else {}
				});
			
			$("#reviewUl").on("click",".reviewModbtn",function(){
				review_id = $(this).parents(".review-tools").attr("data-id");
				});

			$(".write-qna").on("click",function(){
				$.ajax({
					url : "/QnA/write",
					type : "POST",
					data : {
						product_code : ${productVO.product_code},
						user_id : '${sessionScope.userVO.user_id}',
						board_title : $("input[name='board_title']").val(),
						board_content : $("textarea[name='board_content']").val()
						},
					success : function(data){
							if(data == 1 ){
							alert("작성 되었습니다.");
							location.reload();
								}
						}
					});
				});

			$(".board-title").on("click",function(){
					
				if('${sessionScope.userVO.user_id}' == $(this).find(".writer_id").html()){
					var board_num = $(this).find('.board_id').val();
					
					$.ajax({
						url : "/QnA/readBoard?board_num=" + board_num,
						type : "GET",
						success : function(data){
							$("#readQnA-title").val(data.board_title);
							$("#readQnA-content").text(data.board_content);
							$("#board_num").val(data.board_num);
						if(data.board_reply == 'Y'){
									$("#readQnA-reply").text(data.reply_content);
							} else {
								$("#readQnA-reply").text("아직 답변이 작성되지 않았습니다.");
								
								} 
						}
						});
					var btn = '<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>';
					btn +='<button type="button" class="btn btn-primary pull-left delete-qna">삭제</button>';
					btn += '<button type="button" class="btn btn-primary pull-left modify-qna">수정</button>';
						$(".readQnA-footer").html(btn);
					$("#read-QnA").modal('toggle');
					}else{
					alert("작성자본인만 확인 가능합니다.");
						$("#readQnA-reply").text("");
						$("#readQnA-title").val("");
						$("#readQnA-content").text("");
						$(".readQnA-footer").children().remove();
						}
				});

			$(".readQnA-footer").on("click",".delete-qna",function(){
				$.ajax({
					url : "/QnA/delBoard?board_num=" + $("#board_num").val(),
					type : "GET",
					success : function(data){
						if(data == 1){
							alert("삭제 되었습니다.");
							location.reload();
							}
						}

					});
				});
			$(".readQnA-footer").on("click",".modify-qna",function(){
				$("#readQnA-content").attr("readonly",false);
				$("#readQnA-title").attr("readonly",false);
				
				var btn = '<button type="button" class="btn btn-primary modify-btn">확인</button>';
				$(".readQnA-footer").html(btn);
				});

			$(".readQnA-footer").on("click",".modify-btn",function(){
				$.ajax({
					url : "/QnA/modifyBoard",
					type : "POST",
					data : {
					board_num : $("#board_num").val(),
					board_title : $("#readQnA-title").val(),
					board_content : $("#readQnA-content").val()
						},
					success : function(data){
						if(data == 1){
							alert("수정 되었습니다.");
							location.reload();
							}
						}

					});
				});
					
			}); //ready				
	</script>
	
	<script id="reviewTemplate" type="text/x-handlebars-template">	
	{{#each .}}
	<li class="replyLi">
 		<div class="timeline-item" >
  			<h5 class="timeline-header"><b>{{user_id}}</b>  <small><i class="fa fa-clock-o"></i>{{prettifyDate review_date}}</small></h5>
  			<div class="timeline-body"><i class="fa fa-commenting-o"></i> {{review_content}}
			<div class="box-tools pull-right review-tools" data-id={{review_id}}>
				{{writer user_id}}
			</div>
				</div>
    		<div class="timeline-footer"></div>
 			</div>
		</li>
	{{/each}}
	</script>
	<div class="wrapper">
		<!-- Main Header -->
		<%@include file="../include/main_header.jsp"%>

		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="../include/left.jsp"%>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">

			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
        | Your Page Content Here |
        -------------------------->
        <div class="box box-primary">
        	<div class="container" style="width: 100%">
        		<div class="box-header">
	    			<h4><strong>${productVO.product_name }</strong></h4>
	        	</div>
	       		<form class="form-horizontal" action="/order/quickOrder" method="post">
					<div class="form-group">
						<div class="col-xs-4">
		        			<img src="/admin/product/displayImage?filename=${productVO.product_image }" class="img-thumbnail img-responsive" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label">상품 가격</label>
						<div class="col-xs-6">
							<p class="form-control-static">${productVO.product_price}</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label">브랜드명</label>
						<div class="col-xs-6">
							<p class="form-control-static">${productVO.product_company}</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label">수량</label>
						<div class="col-xs-2">
							<input type="text" class="form-control" name="product_count" id="inputAmount" value="1">
							<input type="hidden" name="product_code" value="${productVO.product_code }">
						</div>
					</div>
	
					<div class="box-footer">
						<div class="col-md-12 text-center">
							<button type="button" class="btn btn-primary" id="btnAddCart">담기</button>&nbsp; &nbsp; 
							<button type="submit" class="btn btn-primary" id="btnBuy">구매</button>&nbsp; &nbsp; 
							<button type="button" class="btn btn-default" onClick="history.back()">목록</button>
						</div>
					</div>
				</form>	        	
        	</div>
        </div>
		<div class="box box-primary">
			<div class="box-header">
				<h4><strong>상품 설명</strong></h4>
			</div>
			<div class="container" style="width: 100%">
				<div class="form-group">
					<p class="form-control-static col-md-12">${productVO.product_inform}</p>
				</div>
			</div>
		</div>
		
			
			<div class="box box-warning collapsed-box">
				<div class="box-header">
					<font><b>상품 리뷰</b></font>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="" data-original-title="Collapse">
              <i class="fa fa-plus"></i></button>
					</div>
				</div>
				<div class="box-body" style="display:none" name="review_body">
					<ul id="reviewUl"class="pagination pagination-sm no-margin">
					</ul>
				</div>
				<div class="box-footer" style="display:none"></div>
			</div>
			
			<%-- 리뷰 수정 modal --%>
			<div class="modal fade in" id="modal-default" style="display: none; padding-right: 16px;">
				          <div class="modal-dialog">
				            <div class="modal-content">
				              <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                  <span aria-hidden="true">×</span></button>
				                <h4 class="modal-title">리뷰 수정</h4>
				              </div>
				              <div class="modal-body">
				                <input type="text" name="review_content" class="form-control">
				              </div>
				              <div class="modal-footer">
				                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
				                <button type="button" class="btn btn-primary" name="writeReview">확인</button>
				              </div>
				            </div>
				            <!-- /.modal-content -->
				          </div>
				          <!-- /.modal-dialog -->
				        </div>
				       <%-- 문의 작성 modal --%> 
				        <div class="modal fade in" id="modal-QnA" style="display: none; padding-right: 16px;">
				          <div class="modal-dialog">
				            <div class="modal-content">
				              <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                  <span aria-hidden="true">×</span></button>
				                <h4 class="modal-title">문의 작성</h4>
				              </div>
				              <div class="modal-body">
					              <div class="form-group">
								<label class="col-xs-3 control-label">문의 제목</label>
					                <input type="text" name="board_title" class="form-control">
								</div>
									<div class="form-group">
								<label class="col-xs-3 control-label">문의 내용</label>
					                <textarea rows="7" cols="100" style="width: 100%; resize: none;"
					                 class="form-control" name="board_content" maxlength="200" placeholder="최대 200자"></textarea>
								</div>
				              </div>
				              <div class="modal-footer">
				                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
				                <button type="button" class="btn btn-primary write-qna">확인</button>
				              </div>
				            </div>
				            <!-- /.modal-content -->
				          </div>
				          <!-- /.modal-dialog -->
				        </div>
					<%--문의 읽기 modal --%>
					<div class="modal fade in" id="read-QnA" style="display: none; padding-right: 16px;">
				          <div class="modal-dialog">
				            <div class="modal-content">
				              <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                  <span aria-hidden="true">×</span></button>
				                <h4 class="modal-title">QnA</h4>
				              </div>
				              <div class="modal-body">
					              <div class="form-group">
								<label class="col-xs-3 control-label">문의 제목</label>
					                <input type="text" name="board_title" id="readQnA-title" class="form-control" readonly="readonly" >
								</div>
									<div class="form-group">
								<label class="col-xs-3 control-label">문의 내용</label>
					                <textarea rows="7" cols="100" style="width: 100%; resize: none ;" class="form-control"
					                 name="board_content" maxlength="200" id="readQnA-content" readonly="readonly"></textarea>
					            	<input type="hidden" id="board_num" value=""> 
								</div>
								<div class="form-group read-reply">
									<label class="col-xs-1 control-label"><i class="fa fa-comment"></i></label>
									<font id="readQnA-reply"> </font>
								</div>
				              <div class="modal-footer readQnA-footer">
				               
				               </div>
				              </div>
				            </div>
				            <!-- /.modal-content -->
				          </div>
				          <!-- /.modal-dialog -->
				        </div>
					
					
					
			<div class="box box-info collapsed-box" >
				<div class="box-header" >
					<font><b>QnA</b></font>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="" data-original-title="Collapse">
              <i class="fa fa-plus"></i></button>
					</div>
				</div>
				<div class="box-body" style="display:none" name="review_body">
					<table class="table table-hover" id="qnaBoard">
						<thead>
							<tr>
								<th>#</th>
								<th>문의 제목</th>
								<th>질문자 ID</th>
								<th>작성일</th>
							</tr>
						</thead>
						<c:forEach items="${boardList}" var="board" varStatus="status">
							<tr class="board-title"> <!--  -->
								<td class="col-md-1">${status.index+1}<input type="hidden" class="board_id" value="${board.board_num }"></td>
								<td class="col-md-8">${board.board_title }</td>
								<td class="col-md-2 writer_id">${board.user_id }</td>
								<td class="col-md-1"><fmt:formatDate value="${board.board_createday }" pattern="yyyy-MM-dd" /></td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="box-footer" style="display:none">
					<c:if test="${sessionScope.userVO != null}">
					<button type="button" class="btn btn-default btn-xs" id="writeQnA" data-toggle="modal" data-target="#modal-QnA">QnA글쓰기</button>
					</c:if>
					<c:if test="${sessionScope.userVO == null}">
					<h6>QnA는 로그인 후에 이용 가능합니다.</h6>
					</c:if>
				</div>
			</div>
		
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%@include file="../include/footer.jsp" %>

		<!-- Control Sidebar -->
		<%@include file="../include/right.jsp" %>
		
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->

</body>
</html>