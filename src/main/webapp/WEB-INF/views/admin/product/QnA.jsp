<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<body class="hold-transition skin-blue sidebar-mini">
	<script type="text/javascript">
		$(function() {
			//문의 읽기
			$(".readBtn").on("click", function() {
				var board_num = $(this).val();

				$.ajax({
					url : "/QnA/readBoard?board_num=" + board_num,
					type : "GET",
					success : function(data) {
						$("#readQnA-title").text(data.board_title);
						$("#readQnA-content").text(data.board_content);
						$("#board_num").val(data.board_num);
						if (data.board_reply == 'Y') {
							$("#readQnA-reply").text(data.reply_content);
						} else {
							$("#readQnA-reply").text("아직 답변이 작성되지 않았습니다.");

						}
					}
				});

				$("#read-QnA").modal("toggle");
			});
			//작성 or 수정버튼
			var morwr;
			
			$(".replyBtn").on("click",function() {
				var board_num = $(this).val();
				getQnA(board_num);
				morwr = 'write';
							});

			$(".modifyBtn").on("click", function() {
				var board_num = $(this).val();
				getQnA(board_num);
				morwr = 'modify';
			});

			//작성 버튼
			$("#replyBtn").on("click", function() {
				if(morwr == 'write'){
				$.ajax({
					url : "/QnA/writeReply",
					type : "POST",
					data : {
						board_num : $(this).val(),
						user_id : '${sessionScope.admin.admin_name}',
						board_content : $("#reply-text").val()
					},
					success : function(data) {
						alert("작성 되었습니다.");
						location.reload();
					}

				});
					} else {
						$.ajax({
							url : "/QnA/modifyReply",
							type : "POST",
							data : {
								board_num : $(this).val(),
								board_content : $("#reply-text").val()
							},
							success : function(data) {
								alert("수정 되었습니다.");
								location.reload();
							}

						});
						}
			});

		});//ready
		function comma(str) {
			str = String(str);
			return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		}

		function getQnA(board_num){
			$.ajax({
				url : "/admin/product/readQnA/"
						+ board_num,
				type : "GET",
				success : function(data) {
					$("#product-name").text(
							data.product_name);
					$("#product-price")
							.text(
									comma(data.product_price));
					$("#product-amount").text(
							data.product_amount);
					$("#product-event").text(
							data.product_event);
					$("#product-image")
							.html(
									'<img src="/admin/product/displayImage?filename='
											+ data.product_image
											+ '" class="img-thumbnail img-responsive">');
					$("#product-inform").html(
							data.product_inform);
					$("#QnA-title").text(
							data.board_title);
					$("#QnA-content").text(
							data.board_content);
					$("#replyBtn").val(
							data.board_num);
				}
			});
	$("#QnA-reply").modal("toggle");
			}
	</script>
	<div class="wrapper">
		<!-- Main Header -->
		<%@include file="../include/admin_header.jsp"%>

		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="../include/left.jsp"%>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>상품 문의</h1>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<div class="box box-info">
					<div class="box-header with-border">
						<h4 class="box-title">목록</h4>
					</div>
					<div class="box-body">
						<table class="table table-striped text-center">
							<thead>
								<tr>
									<th><input type="checkbox" id="all-check"></th>
									<th>문의 제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>상품명</th>
									<th>답변</th>
									<th>삭제</th>
								</tr>
							</thead>

							<c:forEach items="${QnAList}" var="qna">

								<tr>
									<td><input type="checkbox" name="check_product"
										value="${qna.board_num}"></td>
									<td class="col-md-4"><button type="button"
											value="${qna.board_num }" class="btn btn-link readBtn"
											style="color: black;">${qna.board_title }</button></td>
									<td class="col-md-2">${qna.user_id }</td>
									<td class="col-md-1"><fmt:formatDate
											value="${qna.board_createday }" pattern="yyyy-MM-dd HH:mm" /></td>
									<td class="col-md-2"><a style="color: black;"
										href="/product/${qna.product_code }">${qna.product_name }</a></td>
									<td class="col-md-1"><c:choose>
											<c:when test="${qna.board_reply.toString() eq 'N' }">
												<button type="button" class="btn bg-teal replyBtn"
													value="${qna.board_num}">작성</button>
											</c:when>
											<c:when test="${qna.board_reply.toString() eq 'Y' }">
												<button type="button" class="btn btn-success modifyBtn"
													value="${qna.board_num}">완료</button>

											</c:when>
										</c:choose></td>
									<td class="col-md-1"><button type="button"
											class="btn btn-danger delBtn">삭제</button></td>
								</tr>

							</c:forEach>
						</table>
					</div>
					<div class="box-footer">
						<div class="text-center">
										<ul class="pagination">
	
											<c:if test="${pageMaker.prev}">
												<li><a
													href="QnA${pageMaker.makeQuery(pageMaker.startPage - 1) }">&laquo;</a></li>
											</c:if>
	
											<c:forEach begin="${pageMaker.startPage }"
												end="${pageMaker.endPage }" var="idx">
												<li
													<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
													<a href="QnA${pageMaker.makeQuery(idx)}">${idx}</a>
												</li>
											</c:forEach>
	
											<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
												<li><a
													href="QnA${pageMaker.makeQuery(pageMaker.endPage +1) }">&raquo;</a></li>
											</c:if>
	
										</ul>
						</div>
					</div>
				</div>

				<%--상품 정보 , 문의 내용 modal --%>
				<div class="modal fade in" id="QnA-reply"
					style="display: none; padding-right: 16px;">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
								<h4 class="modal-title">답변 작성</h4>
							</div>
							<div class="modal-body">
								<div class="box box-danger">
									<div class="box-header">
										<b>상품 정보</b>
									</div>
									<div class="box-body">
										<table id="product_tbl"
											class="table table-striped text-center">
											<tr>
												<th class="col-md-2">상품명</th>
												<td id="product-name"></td>
											</tr>
											<tr>
												<th class="col-md-2">가격</th>
												<td id="product-price"></td>
											</tr>
											<tr>
												<th class="col-md-2">재고량</th>
												<td id="product-amount"></td>
											</tr>
											<tr>
												<th class="col-md-2">이미지</th>
												<td id="product-image"></td>
											</tr>
											<tr>
												<th class="col-md-2">이벤트</th>
												<td id="product-event"></td>
											</tr>
											<tr>
												<td colspan="2" id="product-inform"></td>
											</tr>
										</table>
									</div>
								</div>

								<div class="box box-primary">
									<!-- 'ORDER_POSTCODE','ORDER_ADDRESS','ORDER_DETAILADDR','ORDER_PHONENUM','ORDER_SUMPRICE'    -->
									<div class="box-header">
										<b>문의 정보</b>
									</div>
									<div class="box-body">
										<table class="table table-condensed text-center">
											<tr>
												<th class="col-md-2">문의 제목</th>
												<td id="QnA-title"></td>
											</tr>
											<tr>
												<th class="col-md-2">문의 내용</th>
												<td id="QnA-content"></td>
											</tr>
										</table>
									</div>
									<div class="box-footer">
										<label>답변 <textarea rows="7" cols="100"
												style="width: 100%; resize: none;" class="form-control"
												id="reply-text" maxlength="200" placeholder="최대 200자"></textarea>
										</label>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default pull-left"
									data-dismiss="modal">닫기</button>
								<button type="button" class="btn btn-primary" id="replyBtn">작성</button>				
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<%-- 문의 읽기 modal --%>
				<div class="modal fade in" id="read-QnA"
					style="display: none; padding-right: 16px;">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
								<h4 class="modal-title">QnA</h4>
							</div>
							<div class="modal-body">
								<table class="table table-condensed text-center">
									<tr>
										<th class="col-md-2">문의 제목</th>
										<td id="readQnA-title"></td>
									</tr>
									<tr>
										<th class="col-md-2">문의 내용</th>
										<td id="readQnA-content"></td>
									</tr>
								</table>
								<div class="form-group read-reply">
									<label class="col-xs-1 control-label"><i
										class="fa fa-comment"></i></label> <font id="readQnA-reply"> </font>
								</div>
								<div class="modal-footer readQnA-footer"></div>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%@include file="../include/footer.jsp"%>

		<!-- Control Sidebar -->
		<%@include file="../include/right.jsp"%>

		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->

</body>
</html>