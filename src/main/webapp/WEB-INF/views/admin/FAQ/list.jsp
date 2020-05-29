<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<body class="hold-transition skin-blue sidebar-mini">
<script type="text/javascript">
	$(function(){

		$(".faq_titleBtn").on("click",function(){
			location.href = "/admin/FAQ/read/" + $(this).val();
			});

		
		$(".del_faqBtn").on("click", function() {
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


		$("#allCheck").on("click", function() {
			var chk = $(this).is(":checked");
			if (chk) {
				$(".checkBox").prop('checked', true);
			} else {
				$(".checkBox").prop('checked', false);
			}
		});
		$(".checkBox").on("click", function() {
			var chk = $(this).is(":checked");
			if (!chk) {
				$("#allCheck").prop('checked', false);
			}
		});

		//선택 삭제
		$("#faq-delBtn").on("click",function(){
			if(!confirm("삭제하시겠습니까?")){
					return false;
				}
			if(!$(".checkBox").is(":checked")){
					alert("선택된 글이 없습니다.");
					return false;
				}
				var checkarr = [];
				$(".checkBox:checked").each(function(i){
					checkarr.push($(this).val());
					});
				$.ajax({
					url : "/admin/FAQ/deleteList",
					type : "POST",
					data : {
					checkarr : checkarr
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
				<h1>
					FAQ<small>관리자</small>
				</h1>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
		
			
			<div class="box">
					<div class="box-header with-border">
						<h4 class="box-title">목록</h4>
					</div>
					<div class="box-body">
							<!-- we are adding the .panel class so bootstrap.js collapse plugin detects it -->
							<table class="table text-center">
								<thead>
									<tr>
										<th><input type="checkbox" id="allCheck" style="position: relative; margin: 0;"></th>
										<th>제목</th>
										<th>작성자</th>
										<th>답변</th>
										<th>작성 날짜</th>
										<th>삭제</th>
									</tr>
								</thead>
								<c:forEach items="${faqList }" var="faq" varStatus="status">
									<tr>
										<td class="col-md-1"><input type="checkbox" value="${faq.faq_num }" class="checkBox" style="position: relative; margin: 0;"></td>
										<td class="col-md-5">
												<button type="button" class="btn btn-link faq_titleBtn" style="color: black;" value="${faq.faq_num }">
													<b>${faq.faq_title }</b>
													<small>
														<c:forEach items="${replyList }" var="reply">
															<c:if test="${reply.FAQ_REF eq faq.faq_num }">[${reply.COUNT }]</c:if>
														</c:forEach>
													</small>
														<c:if test="${faq.writer_only.toString() eq 'Y' }">
															<i class="fa fa-lock"></i>	
													</c:if>
												</button>
										</td>
										<td class="col-md-2">${faq.faq_writer }</td>
										<td class="col-md-1">
											<c:out value="${faq.admin_reply.toString() eq 'Y'? '완료':'미작성'}"/></td>
										<td class="col-md-2"><fmt:formatDate value="${faq.faq_writedate}"
												pattern="yyyy-MM-dd HH:mm" /></td>
										<td class="col-md-1">
											<button type="button" class="btn btn-danger del_faqBtn" value="${faq.faq_num}">삭제</button>
										</td>
									</tr>
								</c:forEach>
							</table>


					</div>
					<!-- /.box-body -->

					<div class="box-footer">
						<button type="button" id="faq-delBtn" class="btn btn-danger">선택 삭제</button>
					<div class="text-center">
						<ul class="pagination">

							<c:if test="${pageMaker.prev}">
								<li><a
									href="list${pageMaker.makeQuery(pageMaker.startPage - 1) }">&laquo;</a></li>
							</c:if>

							<c:forEach begin="${pageMaker.startPage }"
								end="${pageMaker.endPage }" var="idx">
								<li
									<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
									<a href="list${pageMaker.makeQuery(idx)}">${idx}</a>
								</li>
							</c:forEach>

							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li><a
									href="list${pageMaker.makeQuery(pageMaker.endPage +1) }">&raquo;</a></li>
							</c:if>

						</ul>
					</div>
					</div>
					<!-- /.box-footer-->
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