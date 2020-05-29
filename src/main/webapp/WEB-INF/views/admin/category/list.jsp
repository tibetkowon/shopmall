<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<body class="hold-transition skin-blue sidebar-mini">
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.3/handlebars.js"></script>
	<script>
		$(function() {

			$("#all-check").on("click", function() {
				var chk = $(this).is(":checked");
				if (chk) {
					$("input[name='cate_code']").prop('checked', true);
				} else {
					$("input[name='cate_code']").prop('checked', false);
				}
			});
			$("input[name='cate_code']").on("click", function() {
				var chk = $(this).is(":checked");
				if (!chk) {
					$("#all-check").prop('checked', false);
				}
			});

			$("#new-category").on("click", function() {
				$("#insert_category").modal("toggle");
			});

			$("#new-cateBtn").on("click", function() {
				var form = $("form[role='create']");
				insert(form);
			});
			$("#insert_category").keydown(function(e) {
				if (e.keyCode == 13) {
					var form = $("form[role='create']");
					insert(form);
				}
			});

			$(".modifyBtn").on(
					"click",
					function() {
						var tr = $(this).parents("tr");

						$.ajax({
							url : "/admin/category/modify",
							type : "POST",
							data : {
								category_code : tr.find(
										"input[name='cate_code']").val(),
								category_name : tr.find(".cateName").val(),
								parents_code : tr.find(".prt_code").val()
							},
							success : function(data) {
								if(data == "success"){
								alert("수정되었습니다.");
								location.reload();
									} else {
								alert("상위 카테고리는 이름만 변경가능합니다.");
										}
							}

						});
					});

			$(".removeBtn").on("click", function() {
				if (confirm("삭제하시겠습니까?")) {
					$.ajax({
						url : "/admin/category/delete",
						type : "POST",
						data : {
							category_code : $(this).val()
						},
						success : function(data) {
							if (data == 'success') {
								alert("삭제 되었습니다.");
								location.reload();
							} else if (data == "subExist") {
								alert("하위 카테고리가 존재합니다.");
							}
						}

					});
				}
			});

		$("#sel-change").on("click",function(){

			});

		$("#sel-delete").on("click",function(){
			if (confirm("삭제하시겠습니까?"))
				if(!$("input[name='cate_code']").is(":checked")){
					alert("체크된 항목이 없습니다.");
					return false;
					}
				var check = [];
				$("input[name='cate_code']:checked").each(function(i){
					check.push($(this).val());
					});
					$.ajax({
						url : "/admin/category/checkDelete",
						type : "POST",
						data : {
						codes : check
							},
						success : function(data){
							if (data == "success"){
							alert("삭제되었습니다.");
							location.reload();
							}
							else if (data == "subExist") {
								alert("하위 카테고리가 존재합니다.");
							}
							}
						});
				
			});

		$("#sel-change").on("click",function(){
			if(!$("input[name='cate_code']").is(":checked")){
				alert("체크된 항목이 없습니다.");
				return false;
				}
			var names = [] , codes = [] , prts = [];
			$("input[name='cate_code']:checked").each(function(i){
				var tr = $(this).parents("tr");
				names.push(tr.find(".cateName").val());
				codes.push($(this).val());
				prts.push(tr.find(".prt_code").val());
				});
				$.ajax({
					url : "/admin/category/checkModify",
					type : "POST",
					data : {
						codes : codes,
						names : names,
						prts : prts
						},
						success : function(data){
							alert("수정되었습니다.");
							location.reload();
							}
					
					});
			});
			
		}); // ready
		function insert(form) {
			if (form.find("#cateName").val() == '') {
				alert("카테고리 이름을 작성하세요.");
				form.find("#cateName").focus;
				return false;
			}
			$.ajax({
				url : "/admin/category/insert",
				type : "POST",
				data : form.serialize(),
				success : function(data) {
					alert("생성되었습니다.");
					location.reload();
				}
			});
		}
	</script>
	<script id="subCateListTemplate" type="text/x-handlebars-template">
				<option value="" class="form-control">하위 카테고리</option>
		{{#each .}}
				<option value="{{category_code}}">{{category_name}}</option>
			{{/each}}
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
				<h1>카테고리 목록</h1>

			</section>

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
						<table class="table table-striped text-center">
							<thead>
								<tr>
									<th><input type="checkbox" id="all-check"></th>
									<th>카테고리 번호</th>
									<th>카테고리 이름</th>
									<th>상위 카테고리</th>
									<th>수정</th>
									<th>삭제</th>
								</tr>
							</thead>
							<c:forEach items="${all_list}" var="category">

								<tr>
									<td class="col-md-1"><input type="checkbox"
										name="cate_code" value="${category.category_code}"></td>
									<td class="col-md-2">${category.category_code }</td>
									<td class="col-md-3"><input type="text"
										class="form-control cateName"
										value="${category.category_name }"></td>
									<td class="col-md-3"><select class="form-control prt_code">
											<option value=""
												<c:if test="${category.parents_code == null}">selected</c:if>>없음</option>
											<c:forEach items="${prt_list }" var="prt">
												<option value="${prt.category_code }"
													<c:out value="${prt.category_code eq category.parents_code ? 'selected':'' }"/>>${prt.category_name }
											</c:forEach>
									</select></td>
									<td class="col-md-1"><button
											class="btn btn-info modifyBtn">수정</button></td>
									<td class="col-md-1"><button
											class="btn btn-danger removeBtn"
											value="${category.category_code }">삭제</button></td>
								</tr>

							</c:forEach>

						</table>

					</div>
					<!-- /.box-body -->


					<div class="box-footer">
						<button type="button" id="new-category" class="btn btn-primary">신규
							생성</button>
						<button type="button" id="sel-change" class="btn btn-info">선택
							수정</button>
						<button type="button" id="sel-delete" class="btn btn-danger">선택
							삭제</button>
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

				<div class="modal fade in" id="insert_category"
					style="display: none; padding-right: 16px;">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
								<h4 class="modal-title">신규 카테고리 생성</h4>
							</div>
							<div class="modal-body">
								<form role="create">
									<label>상위 카테고리 <select class="form-control"
										id="catePrt" name="parents_code">
											<option value="0">신규 상위</option>
											<c:forEach items="${prt_list }" var="prt">
												<option value="${prt.category_code }">${prt.category_name}</option>
											</c:forEach>
									</select>
									</label> <label>카테고리 명 <input type="text" class="form-control"
										id="cateName" name="category_name">
									</label>
								</form>
								<br />
								<div class="modal-footer">
									<button type="button" class="btn btn-default pull-left"
										data-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-primary" id="new-cateBtn">생성</button>
								</div>
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