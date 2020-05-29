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
			//댓글
			$(".write-reply").on("click", function() {
				var content = $(this).parent().prevAll(".reply-content");
				if ('${sessionScope.userVO.user_id}' == '') {
					alert("로그인 후 작성 가능합니다.");
					return false;
				}
				if (content.val() == '') {
					alert("내용을 입력하세요");
					content.focus();
					return false;
				}
				$.ajax({
					url : "/FAQ/write_Reply",
					type : "POST",
					data : {
						faq_writer : '${sessionScope.userVO.user_id}',
						faq_content : content.val(),
						faq_ref : '${faq.faq_num}'
					},
					success : function(data) {
						alert("작성 완료");
						location.reload();
					}
				});
			});
			//대댓글
			$(".write-re-reply").on("click", function() {
				var content = $(this).parent().prevAll(".reply-content");
				var data = $(this).parent().prevAll(".data");
				if ('${sessionScope.userVO.user_id}' == '') {
					alert("로그인 후 작성 가능합니다.");
					return false;
				}
				if (content.val() == '') {
					alert("내용을 입력하세요");
					content.focus();
					return false;
				}
				$.ajax({
					url : "/FAQ/write_re_reply",
					type : "POST",
					data : {
						faq_writer : '${sessionScope.userVO.user_id}',
						faq_content : content.val(),
						faq_ref : '${faq.faq_num}',
						faq_re_level : data.attr("data-level"),
						faq_re_step : data.attr("data-step")
					},
					success : function(data) {
						alert("작성 완료");
						location.reload();
					}
				});

			});
			//삭제
			$(".del_replyBtn").on("click", function() {
				if (confirm("삭제하시겠습니까?")) {
					$.ajax({
						url : "/FAQ/del_reply",
						type : "POST",
						data : {
							faq_num : $(this).val()
						},
						success : function(data) {
							alert("삭제 완료");
							location.reload();
						}
					});
				}
			});
			//수정 모달
			$(".modify_replyArea").on(
					"click",
					function() {
						var content = $(this).parent()
								.prevAll('.timeline-body').find("p").text();
						$("#reply-modify-modal").find("textarea").val(content);
						$("#reply-modify-modal").find("#reply-num").val(
								$(this).val());

						$("#reply-modify-modal").modal("toggle");

					});
			//대댓글 작성인풋
			$(".re-replyBtn").on(
					"click",
					function() {
						$(this).parent().prevAll(".timeline-body").children(
								".re-replyBox").toggle();
					});
			//수정
			$("#modify_replyBtn").on("click", function() {
				var modifyModal = $(this).parents("#reply-modify-modal");

				$.ajax({
					url : "/FAQ/modify_reply",
					type : "POST",
					data : {
						faq_content : modifyModal.find("textarea").val(),
						faq_num : modifyModal.find("#reply-num").val()
					},
					success : function(data) {
						alert("수정 완료");
						location.reload();
					}
				});
			});
			//글삭제
			$("#del_faqBtn").on("click", function() {
				if (confirm("삭제하시겠습니까?")) {
					$.ajax({
						url : "/FAQ/del_faq",
						type : "POST",
						data : {
							faq_num : $(this).val()
						},
						success : function(data) {
							alert("삭제 완료");
							location.href = "/FAQ/list";
						}
					});
				}
			});
			//글 수정 변환
			$("#modify_faqBtn")
					.on(
							"click",
							function() {
								var textarea = '<textarea rows="3" cols="100"';
								textarea += 'style="width: 100%; resize: none;" maxlength="100"';
								textarea += 'placeholder="최대 100자" class="form-control reply-content">${faq.faq_content}</textarea>';
								var button = '<button class="btn bg-orange" value="${faq.faq_num}" id="modify-faqBtn">';
								button += '수정</button> <button class="btn btn-danger"id="cancelBtn">취소</button>';
								var title = '<input type="text" class="form-control" id="faq_title" value="${faq.faq_title}">';
								$(".mailbox-read-message").empty();
								$(".mailbox-read-message").append(textarea);
								$(".mailbox-read-message").append(button);
								$(".mailbox-read-info").empty();
								$(".mailbox-read-info").append(title);
							});
			//수정 취소
			$(".mailbox-read-message")
					.on(
							"click",
							"#cancelBtn",
							function() {
								var content = '<p>${faq.faq_content }</p>';
								var title = '<h4><b>${faq.faq_title }</b></h4><h6>작성자 : ${faq.faq_writer } <span class="mailbox-read-time pull-right">';
								title += '<fmt:formatDate value="${faq.faq_writedate}" pattern="yyyy-MM-dd HH:mm" /></span></h6>';

								$(".mailbox-read-message").empty();
								$(".mailbox-read-message").append(content);
								$(".mailbox-read-info").empty();
								$(".mailbox-read-info").append(title);
							});
			//글 수정
			$(".mailbox-read-message").on("click", "#modify-faqBtn",
					function() {
						$.ajax({
							url : "/FAQ/modify_FAQ",
							type : "POST",
							data : {
								faq_num : $(this).val(),
								faq_title : $("#faq_title").val(),
								faq_content : $(this).prevAll("textarea").val()
							},
							success : function(data) {
								alert("수정 완료");
								location.reload();
							}
						});
					});

		});//ready
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
				<div class="box box-primary">
					<div class="mailbox-read-info">
						<h4>
							<b>${faq.faq_title }<c:if test="${faq.writer_only.toString() eq 'Y' }">
							<i class="fa fa-lock"></i>
							</c:if> </b>
						</h4>
						<h6>
							작성자 : ${faq.faq_writer } <span
								class="mailbox-read-time pull-right"><fmt:formatDate
									value="${faq.faq_writedate}" pattern="yyyy-MM-dd HH:mm" /></span>
						</h6>
					</div>
					<div class="mailbox-read-message">
						<p>${faq.faq_content }</p>
					</div>
					<div class="box-footer">
						<div class="pull-right">
							<c:if test="${faq.faq_writer eq sessionScope.userVO.user_id }">
								<button class="btn bg-orange btn-xs" id="modify_faqBtn"
									value="${faq.faq_num }">
									<i class="fa fa-refresh"></i>
								</button>
								<button class="btn btn-danger btn-xs" id="del_faqBtn"
									value="${faq.faq_num }">
									<i class="fa fa-trash"></i>
								</button>
							</c:if>
						</div>
					</div>
				</div>

				<ul class="timeline">
					<li class="time-label">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
						class="bg-blue"> 댓글 </span></li>
					<c:forEach items="${replys }" var="reply" varStatus="status">
						<li><c:if test="${reply.faq_re_level eq 1 }">
								<i class="fa fa-comments bg-blue"></i>
							</c:if>
							<div class="timeline-item">
								<span class="time"><i class="fa fa-clock-o"></i> <fmt:formatDate
										value="${reply.faq_writedate}" pattern="yyyy-MM-dd HH:mm" /></span>
								<h3 class="timeline-header">
									<c:if test="${reply.faq_re_level != 1 }">
										<c:forEach begin="1" end="${reply.faq_re_level }">
										 &nbsp; &nbsp;
										 </c:forEach>
										↳
										</c:if>
									<b> ${reply.faq_writer } </b>
								</h3>

								<div class="timeline-body">
									<p><c:forEach begin="1" end="${reply.faq_re_level }">
										 &nbsp; &nbsp;
										 </c:forEach>
										 ${reply.faq_content }</p>
									<div class="re-replyBox" style="display: none;">
										<textarea rows="3" cols="100"
											style="width: 100%; resize: none;" maxlength="100"
											placeholder="최대 100자" class="form-control reply-content"></textarea>
										<br /> <input type="hidden" class="data"
											data-ref="${reply.faq_ref }"
											data-step="${reply.faq_re_step }"
											data-level="${reply.faq_re_level }">
										<div class="pull-right">
											<button class="btn bg-navy write-re-reply">작성</button>
										</div>
									</div>
								</div>
								<div class="timeline-footer">
								<c:if test="${reply.faq_writer != ' ' }">
									<button class="btn btn-primary btn-xs re-replyBtn">
										<i class="fa fa-reply"></i>
									</button>
									<c:if
										test="${reply.faq_writer eq sessionScope.userVO.user_id }">
										
										<button class="btn bg-orange btn-xs modify_replyArea"
											value="${reply.faq_num }">
											<i class="fa fa-refresh"></i>
										</button>
										<button class="btn btn-danger btn-xs del_replyBtn"
											value="${reply.faq_num }">
											<i class="fa fa-trash"></i>
										</button>
									</c:if>
								</c:if>
								</div>
							</div></li>
					</c:forEach>
					<li><i class="fa fa-keyboard-o"></i></li>
				</ul>
				<br>
				<div class="box box-primary">
					<div class="box-header">
						<b>댓글 작성</b>
					</div>
					<div class="box-footer">
						<div class="col-md-12">
							<textarea rows="3" cols="100" style="width: 100%; resize: none;"
								maxlength="100" placeholder="최대 100자"
								class="form-control reply-content"></textarea>
							<br />
							<div class=" pull-right">
								<button class="btn bg-navy write-reply">작성</button>
							</div>
						</div>
					</div>
				</div>
				<%-- 수정 모달 --%>
				<div class="modal fade in" id="reply-modify-modal"
					style="display: none; padding-right: 16px;">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
								<h4 class="modal-title">댓글 수정</h4>
							</div>
							<div class="modal-body">
								<div class="form-group">
									<label class="col-xs-3 control-label">수정</label> <input
										type="hidden" id="reply-num" value="">
									<textarea rows="7" cols="100"
										style="width: 100%; resize: none;" class="form-control"
										name="board_content" maxlength="200" id="readQnA-content"></textarea>
								</div>
							</div>
							<div class="modal-footer readQnA-footer">
								<button class="btn bg-orange" id="modify_replyBtn">수정</button>
								<button type="button" class="btn btn-default pull-left"
									data-dismiss="modal">닫기</button>
							</div>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
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