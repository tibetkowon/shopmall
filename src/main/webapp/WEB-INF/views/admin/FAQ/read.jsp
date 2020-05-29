<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<body class="hold-transition skin-blue sidebar-mini">
<script type="text/javascript">
	$(function(){
		//댓글
		$(".write-reply").on("click", function() {
			var content = $(this).parent().prevAll(".reply-content");

			if (content.val() == '') {
				alert("내용을 입력하세요");
				content.focus();
				return false;
			}
			$.ajax({
				url : "/admin/FAQ/writeReply",
				type : "POST",
				data : {
					faq_writer : '${sessionScope.admin.admin_name}',
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

			if (content.val() == '') {
				alert("내용을 입력하세요");
				content.focus();
				return false;
			}
			$.ajax({
				url : "/admin/FAQ/write_re_Reply",
				type : "POST",
				data : {
					faq_writer : '${sessionScope.admin.admin_name}',
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
		//글삭제
		$("#del_faqBtn").on("click", function() {
			if (confirm("삭제하시겠습니까?")) {
				$.ajax({
					url : "/admin/FAQ/deleteFAQ?num="+$(this).val(),
					type : "GET",
					success : function(data) {
						alert("삭제 완료");
						location.href = "/admin/FAQ/list";
					}
				});
			}
		});
		//대댓글 작성인풋
		$(".re-replyBtn").on("click",function() {
			$(this).parent().prevAll(".timeline-body").children(".re-replyBox").toggle();
		});

		//댓글 삭제
		$(".del_replyBtn").on("click",function(){
			if (confirm("삭제하시겠습니까?")) {
				$.ajax({
					url : "/admin/FAQ/deleteReply?faq_num="+$(this).val(),
					type : "GET",
					success : function(data) {
						alert("삭제 완료");
						location.reload();
					}
				});
			}
			});

		$(".replyAllCheck").on("click", function() {
			var chk = $(this).is(":checked");
			if (chk) {
				$(".replyCheck").prop('checked', true);
			} else {
				$(".replyCheck").prop('checked', false);
			}
		});
		$(".replyCheck").on("click", function() {
			var chk = $(this).is(":checked");
			if (!chk) {
				$(".replyAllCheck").prop('checked', false);
			}
		});

		$("#checkReply_delBtn").on("click",function(){
			if(!confirm("삭제하시겠습니까?")){
				return false;
			}
		if(!$(".replyCheck").is(":checked")){
				alert("선택된 댓글이 없습니다.");
				return false;
			}
			var checkarr = [];
			$(".replyCheck:checked").each(function(i){
				checkarr.push($(this).val());
				});
			$.ajax({
				url : "/admin/FAQ/deleteReplyList",
				type : "POST",
				data : {
				list : checkarr
					},
				success : function(data){
					alert("삭제되었습니다.");
					location.reload();
					}
					
				});
			});

	}); // ready
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
				<h1>FAQ<small>관리자</small></h1>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">


				<div class="box box-primary">
					<div class="mailbox-read-info">
						<h4>
							<b>${faq.faq_title }<c:if
									test="${faq.writer_only.toString() eq 'Y' }">
									<i class="fa fa-lock"></i>
								</c:if>
							</b>
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
								<button class="btn btn-danger btn-xs" id="del_faqBtn"
									value="${faq.faq_num }">
									<i class="fa fa-trash"></i>
								</button>
						</div>
					</div>
				</div>

				<ul class="timeline">
					<li class="time-label">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
						class="bg-blue"> 댓글  <input type="checkbox" class="replyAllCheck" style="position: relative; margin: 0;"></span></li>
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
									<p><c:if test="${reply.faq_re_level != 1 }">
										<c:forEach begin="1" end="${reply.faq_re_level }">
										 &nbsp; &nbsp;
										 </c:forEach>
										</c:if>${reply.faq_content }</p>
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
									<input type="checkbox" class="replyCheck" value="${reply.faq_num }" style="position: relative; margin: 0;">
									<button class="btn btn-primary btn-xs re-replyBtn">
										<i class="fa fa-reply"></i>
									</button>
									<button class="btn btn-danger btn-xs del_replyBtn"
										value="${reply.faq_num }">
										<i class="fa fa-trash"></i>
									</button>
									</c:if>
								</div>
							</div></li>
					</c:forEach>
					<li><i class="fa fa-keyboard-o"></i></li>
				</ul>
				<br>
				<div class="">
				<button class="btn btn-sm btn-danger" type="button" id="checkReply_delBtn">선택 댓글 삭제</button>
				</div>
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