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

			$("#mainCategory").on(
					"change",
					function() {

						var mainCateCode = $(this).val();

						$.getJSON('/admin/product/subCateList/' + mainCateCode,
								function(data) {
									var template = Handlebars.compile($(
											"#subCateListTemplate").html());
									var html = template(data);
									$("#subCategory select").remove();
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
					alert("상품설명을 입력하세요.");
					CKEDITOR.instances.product_inform.focus();
					return false;
				}
				if ($("#file1").val() == "") {
					alert("상품 이미지를 업로드 하세요.");
					$("#file1").focus();
					return false;
				}
				form.submit();
				}
			$("#btn-submit").on("click", function() {				
				var form = $("form[role='insert']");
				check(form);
			});
			$("form[role='insert'] input").keydown(function(e) {
				if (e.keyCode == 13) {
					var form = $("form[role='insert']");
					check(form);
				}
			});
			
		});//ready
	</script>
	<script id="subCateListTemplate" type="text/x-handlebars-template">
		<select name="category_code" class="form-control">
			{{#each .}}
				<option value="{{category_code}}">{{category_name}}</option>
			{{/each}}
		</select>
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
				<h1>상품 등록</h1>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
        | Your Page Content Here |
        -------------------------->

				<!-- 하위 카테고리 목록 -->

				<div class="container text-center">
					<form class="form-horizontal center-block"
						action="/admin/product/insert" method="post" enctype="multipart/form-data" role="insert">
						<div class="form-group">
							<label class="col-xs-3 control-label">상위 카테고리</label>
							<div class="col-xs-2">

								<select id="mainCategory" name="parents_code"
									class="form-control">
									<option value="" id="not-category">상위</option>
									<c:forEach items="${cateList }" var="cate">
										<option value="${cate.category_code }">${cate.category_name }</option>
									</c:forEach>
								</select>
							</div>
							<label class="col-xs-2 control-label">하위 카테고리</label>
							<div class="col-xs-2" id="subCategory" >
								<select class="form-control" disabled="disabled">
									<option>상위를 선택하세요</option>	
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">상품명</label>
							<div class="col-xs-6">
								<input type="text" class="form-control" name="product_name"
									id="product_name" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">상품 가격</label>
							<div class="col-xs-6">
								<input type="text" class="form-control" name="product_price"
									id="product_price" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">할인율</label>
							<div class="col-xs-6">
								<input type="text" class="form-control" name="product_discount"
									id="product_discount" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">공급처</label>
							<div class="col-xs-6">
								<input type="text" class="form-control" name="product_company"
									id="product_company" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">상품 수량</label>
							<div class="col-xs-6">
								<input type="text" class="form-control" name="product_amount"
									id="product_amount" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">상품 설명</label>
							<div class="col-xs-6">
								<textarea class="form-control" rows="5" cols="50"
									name="product_inform" id="product_inform"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">상품 이미지</label>
							<div class="col-xs-6">
								<input type="file" accept="image/*" name="file1" id="file1"  class="col-xs-8 control-label" />
								<img src="#" class="img-thumbnail img-responsive col-md-4" id="image"
								 alt="현재 이미지"/>	
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">행사 여부</label>
							<div class="col-xs-6">
								<input type="radio" name="product_event" value="Y">Yes
								<input type="radio" name="product_event" value="N"
									checked="checked">No
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">구매 가능 여부</label>
							<div class="col-xs-6">
								<input type="radio" name="product_buy" value="Y"
									checked="checked">Yes <input type="radio"
									name="product_buy" value="N">No
							</div>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-primary" id="btn-submit">등록</button>
							<button type="reset" class="btn btn-primary">초기화</button>
							<button type="button" class="btn btn-primary"
								onClick="location.href='/admin/product/list'">목록</button>
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