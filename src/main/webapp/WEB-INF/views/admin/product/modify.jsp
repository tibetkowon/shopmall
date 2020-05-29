<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<body class="hold-transition skin-blue sidebar-mini">
	<script src="/ckeditor/ckeditor.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.3/handlebars.js"></script>
	<script>
		$(function() {

			var ckeditor_config = {
				resize_enable : false,
				enterMode : CKEDITOR.ENTER_BR,
				shiftEnterMode : CKEDITOR.ENTER_P,
				filebrowserUploadUrl : '/admin/product/imgUpload' // editor에서 이미지 업로드 하고 서버로 전송을 누르면 이 링크로 전송됨
			};

			CKEDITOR.replace('product_inform', ckeditor_config);


		$("#mainCategory").change(
					function() {

						var mainCateCode = $(this).val();
						$.getJSON('/admin/product/subCateList/' + mainCateCode,
								function(data) {
									var template = Handlebars.compile($(
											"#subCateListTemplate").html());
									var html = template(data);
									$("#subCategory option").remove();
									$("#subCategory").append(html);
								});

					});

			function readURL(input) {
				if (input.files && input.files[0]) {
					var reader = new FileReader();
					reader.onload = function(e) {
						$("#image").attr('src', e.target.result);
					}
					reader.readAsDataURL(input.files[0]);
				}
			}
			$("#file1").change(function() {
				readURL(this);
			});

			function check(form){
				var getCheck = RegExp(/^[0-9]{1,15}$/);

				if ($("#not-category").is(":selected")) {
					alert("카테고리를 선택하세요.");
					$("#mainCategory").focus();
					return false;
				}
				if ($("#product_name").val() == "") {
					alert("상품명을 입력 하세요.");
					$("#product_name").focus();
					return false;
				}
				if ($("#product_price").val() == "") {
					alert("상품가격을 입력 하세요.");
					$("#product_price").focus();
					return false;
				}
				if (!getCheck.test($("#product_price").val())) {
					alert("상품가격을 숫자로 입력 하세요.");
					$("#product_price").focus();
					return false;
				}
				if ($("#product_discount").val() == "") {
					$("#product_discount").val(000);
				}
				if (!getCheck.test($("#product_discount").val())) {
					alert("할인율을 숫자로 입력 하세요.");
					$("#product_discount").focus();
					return false;
				}
				if ($("#product_company").val() == "") {
					alert("공급처를 입력 하세요.");
					$("#product_company").focus();
					return false;
				}
				if ($("#product_amount").val() == "") {
					$("#product_amount").val(9999);
				}
				if (!getCheck.test($("#product_amount").val())) {
					alert("수량을 숫자로 입력 하세요.");
					$("#product_amount").focus();
					return false;
				} 
				if (CKEDITOR.instances.product_inform.getData() == '') {
					alert('test');
					alert('testse1');
					return false;
				}
				form.submit();
				}
			
			$("#btn-submit").on("click", function() {
				var form = $("form[role='modify']");
				check(form);
			});	
			$("form[role='modify'] input").keydown(function(e) {
				if (e.keyCode == 13) {
					var form = $("form[role='modify']");
					check(form);
				}
			});

		});//ready
	</script>
	<script id="subCateListTemplate" type="text/x-handlebars-template">
		{{#each .}}
			<option value="{{category_code}}">
			{{category_name}}
			</option>
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
				<h1>상품 수정</h1>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
        | Your Page Content Here |
        -------------------------->

				<!-- 하위 카테고리 목록 -->
		
				<div class="container text-center">
					<form class="form-horizontal center-block"
						action="/admin/product/modify" method="post"
						enctype="multipart/form-data" role="modify">
						<input type="hidden" name="product_code"
							value="${product.product_code }" />
						<div class="form-group">
							<label class="col-xs-3 control-label">상위 카테고리</label>
							<div class="col-xs-2">

								<select id="mainCategory" name="parents_code"
									class="form-control">
									<option value="">상위</option>
									<c:forEach items="${cateList }" var="cate">
										<option value="${cate.category_code }"
											<c:out value="${product.parents_code  eq cate.category_code ? 'selected':''}" />>
											${cate.category_name }</option>
									</c:forEach>
								</select>
							</div>
							<label class="col-xs-2 control-label">하위 카테고리</label>
							<div class="col-xs-2">
								<select id="subCategory" name="category_code"
									class="form-control">
									<c:forEach items="${subCate }" var="sub">
										<option value="${sub.category_code }"
											<c:out value="${product.category_code  eq sub.category_code ? 'selected':''}" />>
											${sub.category_name }</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">상품명</label>
							<div class="col-xs-6">
								<input type="text" class="form-control" name="product_name"
									id="product_name" value="${product.product_name }" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">상품 가격</label>
							<div class="col-xs-6">
								<input type="text" class="form-control" name="product_price"
									id="product_price" value="${product.product_price }" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">할인율</label>
							<div class="col-xs-6">
								<input type="text" class="form-control" name="product_discount"
									id="product_discount" value="${product.product_discount }" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">공급처</label>
							<div class="col-xs-6">
								<input type="text" class="form-control" name="product_company"
									id="product_company" value="${product.product_company }" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">상품 수량</label>
							<div class="col-xs-6">
								<input type="text" class="form-control" name="product_amount"
									id="product_amount" value="${product.product_amount }" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">상품 설명</label>
							<div class="col-xs-6">
								<textarea class="form-control" rows="5" cols="50"
									name="product_inform" id="product_inform">${product.product_inform }</textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">상품 이미지</label>
							<div class="col-xs-6">
								<input type="file" accept="image/*" name="file1" id="file1" class="col-xs-8 control-label">
								<img src="/admin/product/displayImage?filename=${product.product_image }" class="img-thumbnail img-responsive col-md-4" id="image"
								 alt="현재 이미지"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">행사 여부</label>
							<div class="col-xs-6">
								<input type="radio" name="product_event" value="Y"
									<c:if test="${product.product_event.toString() eq 'Y'}">checked</c:if>>Yes
								<input type="radio" name="product_event" value="N"
									<c:if test="${product.product_event.toString() eq 'N'}">checked</c:if>>No
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">구매 가능 여부</label>
							<div class="col-xs-6">
								<input type="radio" name="product_buy" value="Y"
									<c:if test="${product.product_buy.toString() eq 'Y'}">checked</c:if>>Yes
								<input type="radio" name="product_buy" value="N"
									<c:if test="${product.product_buy.toString() eq 'N'}">checked</c:if>>No
							</div>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-primary" id="btn-submit">수정</button>
							<button type="reset" class="btn btn-primary">초기화</button>
							<button type="button" class="btn btn-primary"
								onClick="location.href='/admin/product/list${pageMaker.makeCateSearch(pageMaker.cri.page)}'">목록</button>
						</div>
					</form>
				</div>
				<!-- 상품 리스트 -->


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