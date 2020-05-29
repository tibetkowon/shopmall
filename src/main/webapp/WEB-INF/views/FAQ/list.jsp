<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<body class="hold-transition skin-blue sidebar-mini">
	<script>
		$(function() {
			//문의 작성
			$("#faq-writeBtn").on("click", function() {
				if ('${sessionScope.userVO.user_id}' != '') {
					$("#modal-FAQ").modal('toggle');
				} else {
					alert("로그인 후에 사용 가능합니다.");
				}
			});

			$(".write-FAQ").on("click", function() {
				var faq_title = $("input[name='faq_title']").val();
				var faq_content = $("textarea[name='faq_content']").val();

				if (faq_title == '') {
					alert("제목을 작성하세요.");
					return false;
				}
				if (faq_content == '') {
					alert("내용을 작성하세요.");
					return false;
				}
				var data;
				if ($("#writer_only").is(":checked")){
					data = {
							faq_title : faq_title,
							faq_content : faq_content,
							faq_writer : '${sessionScope.userVO.user_id}',
							writer_only : 'Y'
						};
					} else {
						data = {
								faq_title : faq_title,
								faq_content : faq_content,
								faq_writer : '${sessionScope.userVO.user_id}',
								writer_only : 'N'
							};
						}
				$.ajax({
					url : "/FAQ/write_FAQ",
					type : "POST",
					data : data,
					success : function(data) {
						if (data == 'success') {
							alert("작성되었습니다.");
							location.reload();
						}
					}

				});

			});


			$(".unlock_title").on("click",function(){
				location.href = "/FAQ/"+$(this).val();
				});
			$(".lock_title").on("click",function(){
				if($(this).attr("data-writer") == '${sessionScope.userVO.user_id}'){
				location.href = "/FAQ/"+$(this).val();
					}else{
				alert("비공개 글은 본인과 관리자만 접근 가능합니다.");
						}	
				});
		});
	</script>
	<div class="wrapper">
		<!-- Main Header -->
		<%@include file="../include/main_header.jsp"%>

		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="../include/left.jsp"%>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header" id="category-title"></section>

			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
        | Your Page Content Here |
        -------------------------->
				<div class="box">
					<div class="box-header with-border">
						<h4 class="box-title">목록</h4>
					</div>
					<div class="box-body">
							<!-- we are adding the .panel class so bootstrap.js collapse plugin detects it -->
							<table class="table text-center">
								<thead>
									<tr>
										<th>#</th>
										<th>제목</th>
										<th>작성자</th>
										<th>작성 날짜</th>
									</tr>
								</thead>
								<c:forEach items="${faq_list }" var="faq" varStatus="status">
									<tr>
										<td class="col-md-1">${status.index + 1 }</td>
										<td class="col-md-5">
										<c:if test="${faq.writer_only.toString() eq 'N' }">
										<button type="button" class="btn btn-link unlock_title" style="color: black;" value="${faq.faq_num }">
											<b>${faq.faq_title }</b>
											<small>
											<c:forEach items="${reply_list }" var="reply">
												<c:if test="${reply.FAQ_REF eq faq.faq_num }">[${reply.COUNT }]</c:if>
											</c:forEach>
											</small>
											</button>										
										</c:if>
										<c:if test="${faq.writer_only.toString() eq 'Y' }">
										<button type="button" class="btn btn-link lock_title" style="color: black;" value="${faq.faq_num }" data-writer="${faq.faq_writer }">
											<b>${faq.faq_title }</b>
											<small>
											<c:forEach items="${reply_list }" var="reply">
												<c:if test="${reply.FAQ_REF eq faq.faq_num }">[${reply.COUNT }]</c:if>
											</c:forEach>
											</small>
											<i class="fa fa-lock"></i>
										</button>
										</c:if>
										</td>
										<td class="col-md-2">${faq.faq_writer }</td>
										<td class="col-md-2"><fmt:formatDate value="${faq.faq_writedate}"
												pattern="yyyy-MM-dd HH:mm" /></td>
									</tr>
								</c:forEach>
							</table>


					</div>
					<!-- /.box-body -->

					<div class="box-footer">
						<button type="button" id="faq-writeBtn" class="btn bg-navy">문의
							작성</button>
					<div class="text-center">
						<ul class="pagination">

							<c:if test="${pageMaker.prev}">
								<li><a
									href="list${pageMaker.makeSearch(pageMaker.startPage - 1) }">&laquo;</a></li>
							</c:if>

							<c:forEach begin="${pageMaker.startPage }"
								end="${pageMaker.endPage }" var="idx">
								<li
									<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
									<a href="list${pageMaker.makeSearch(idx)}">${idx}</a>
								</li>
							</c:forEach>

							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li><a
									href="list${pageMaker.makeSearch(pageMaker.endPage +1) }">&raquo;</a></li>
							</c:if>

						</ul>
					</div>
						<%-- 문의 작성 modal --%>
						<div class="modal fade in" id="modal-FAQ"
							style="display: none; padding-right: 16px;">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">×</span>
										</button>
										<h4 class="modal-title">문의 작성</h4>
									</div>
									<div class="modal-body">
										<div class="form-group">
											<label class="col-xs-3 control-label">문의 제목</label> <input
												type="text" name="faq_title" class="form-control">
										</div>
										<div class="form-group">
											<label class="col-xs-3 control-label">문의 내용</label>
											<textarea rows="7" cols="100"
												style="width: 100%; resize: none;" class="form-control"
												name="faq_content" maxlength="200" placeholder="최대 200자"></textarea>
										</div>
											<input type="checkbox" value="Y" id="writer_only"> 비공개
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default pull-left"
											data-dismiss="modal">닫기</button>
										<button type="button" class="btn btn-primary write-FAQ">확인</button>
									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal-dialog -->
						</div>
					</div>
					<!-- /.box-footer-->
				</div>

			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%@include file="../include/footer.jsp"%>
		<!-- Control Sidebar -->
		<%@include file="../include/right.jsp"%>
	</div>
	<!-- ./wrapper -->

</body>
</html>