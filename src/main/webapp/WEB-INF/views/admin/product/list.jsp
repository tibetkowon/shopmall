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

			$('#searchBtn').on(
					"click",
					function(event) {
						self.location = "list" + '${pageMaker.makeQuery(1)}'
								+ "&mainCategory="
								+ $("#mainCategory option:selected").val()
								+ "&subCategory="
								+ $("#subCategory option:selected").val()
								+ "&searchType="
								+ $("#searchType option:selected").val()
								+ "&keyword=" + $('#keywordInput').val();
					});

			$("#mainCategory").on(
					"change",
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

			$(".btn-danger")
					.on(
							"click",
							function() {
								var data = {
									code : $(this).attr("data-code")
								};

								if (confirm("삭제하시겠습니까?")) {
									$
											.ajax({
												url : "delete",
												type : "POST",
												data : data,
												success : function(data) {
													if (data == 'success') {
														alert("삭제되었습니다.");
														location.href = "/admin/product/list${pageMaker.makeCateSearch(pageMaker.cri.page)}";
													}
												}

											});
								}

							});

			$("#all-check").on("click", function() {
				var chk = $(this).is(":checked");
				if (chk) {
					$("input[name='check_product']").prop('checked', true);
				} else {
					$("input[name='check_product']").prop('checked', false);
				}
			});
			$("input[name='check_cart']").on("click", function() {
				var chk = $(this).is(":checked");
				if (!chk) {
					$("#all-check").prop('checked', false);
				}
			});

			$("#sel-delete")
					.on(
							"click",
							function() {
								if ($("input[name='check_product']").is(
										":checked")) {
									if (confirm("삭제하시겠습니까?")) {
										var checkArr = [];
										$("input[name='check_product']:checked")
												.each(
														function(i) {
															checkArr
																	.push($(
																			this)
																			.val());
														});
										$
												.ajax({
													url : "/admin/product/deleteArr",
													type : "POST",
													dataType : 'text',
													data : {
														codeArr : checkArr
													},
													success : function(data) {
														if (data == "success") {
															alert("삭제되었습니다.");
															location.href = "/admin/product/list${pageMaker.makeCateSearch(pageMaker.cri.page)}";
														}
													}

												});
									}
								} else {
									alert("선택된 상품이 없습니다.");
								}
							});

			$("#sel-change")
					.on(
							"click",
							function() {
								if ($("input[name='check_product']").is(
										":checked")) {
									var checkArr = [];
									var buyArr = [];
									var nameArr = [];
									var priArr = [];
									var amoArr = [];

									$("input[name='check_product']:checked")
											.each(
													function(i) {
														var code = $(this)
																.val();
														var buy = '';
														if ($(
																"input[name='buy_"
																		+ code
																		+ "']")
																.is(":checked")) {
															buy = 'Y';
														} else {
															buy = 'N';
														}
														nameArr.push($(
																"input[name='name_"
																		+ code
																		+ "']")
																.val());
														priArr.push($(
																"input[name='pri_"
																		+ code
																		+ "']")
																.val());
														amoArr.push($(
																"input[name='amo_"
																		+ code
																		+ "']")
																.val());
														checkArr.push(code);
														buyArr.push(buy);
													});
									$
											.ajax({
												url : "/admin/product/quickModify",
												type : "POST",
												dataType : 'text',
												data : {
													codeArr : checkArr,
													buyArr : buyArr,
													nameArr : nameArr,
													priArr : priArr,
													amoArr : amoArr

												},
												success : function(data) {
													if (data == "success") {
														alert("수정되었습니다.");
														location.href = "/admin/product/list${pageMaker.makeCateSearch(pageMaker.cri.page)}";
													}
												}

											});

								} else {
									alert("수정상품을 선택 하세요");
								}

							});
		}); // ready
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
				<h1>상품 목록</h1>

			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
        | Your Page Content Here |
        -------------------------->

				<div class="row">
					<!-- left column -->


					<div class="col-md-12">
						<!-- general form elements -->
						<div class='box'>
							<div class="box-header with-border">
								<h3 class="box-title">상품 검색</h3>
							</div>

							<div class='box-body'>
								<div class="col-xs-3">
									<select id="mainCategory" name="mainCategory"
										class="form-control">
										<option value=""
											<c:out value="${pageMaker.cri.mainCategory == null?'selected':''}"/>>상위
											카테고리</option>
										<c:forEach items="${cateList }" var="cate">
											<option value="${cate.category_code }"
											<c:out value="${pageMaker.cri.mainCategory eq cate.category_code ? 'selected':'' }" />>
												${cate.category_name }</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-xs-3">
									<select id="subCategory" name="subCategory"
										class="form-control">
										<option value="" class="form-control">하위 카테고리</option>
									</select>
								</div>
							</div>
							<div class='box-body'>
								<div class="col-xs-3">
									<select id="searchType" name="searchType" class="form-control">
										<option value="name"
											<c:out value="${pageMaker.cri.searchType eq 'name'?'selected':''}"/>>
											상품명</option>
										<option value="inform"
											<c:out value="${pageMaker.cri.searchType eq 'inform'?'selected':''}"/>>
											상품설명</option>
										<option value="price"
											<c:out value="${pageMaker.cri.searchType eq 'price'?'selected':''}"/>>
											가격</option>
										<option value="nainform"
											<c:out value="${pageMaker.cri.searchType eq 'nainform'?'selected':''}"/>>
											상품명 / 상품설명</option>
									</select>
								</div>
								<div class="col-xs-6">
									<input type="text" name='keyword' id="keywordInput"
										class="form-control" value='${pageMaker.cri.keyword }'>
								</div>
								<div class="col-xs-1">
									<button id='searchBtn' class="btn btn-default">Search</button>
								</div>
							</div>
						</div>


						<div class="box">
							<div class="box-header with-border">
								<h4 class="box-title">목록</h4>
							</div>
							<div class="box-body">
								<table class="table table-striped text-center">
									<tr>
										<th><input type="checkbox" id="all-check"></th>
										<th>상품번호</th>
										<th>상품이미지</th>
										<th>상품명</th>
										<th>가격</th>
										<th>할인</th>
										<th>등록일</th>
										<th>수량</th>
										<th>진열</th>
										<th>미답변</th>
										<th>수정</th>
										<th>삭제</th>
									</tr>

									<c:forEach items="${products}" var="product">

										<tr>
											<td><input type="checkbox" name="check_product"
												value="${product.product_code}"></td>
											<td class="col-md-1"><a href="/product/${product.product_code}" style="color : black;" >${product.product_code}</a></td>
											<td class="col-md-2"><img
												src="/admin/product/displayImage?filename=${product.product_image }"
												class="img-thumbnail img-responsive" /></td>
											<td class="col-md-3"><input type="text"
												name="name_${product.product_code }"
												value="${product.product_name }" class="form-control">
											</td>
											<td class="col-md-1"><input type="text"
												name="pri_${product.product_code }"
												value="${product.product_price }" class="form-control"></td>
											<td class="col-md-1"><fmt:formatNumber type="percent"
													value="${product.product_discount/100 }" /></td>
											<td class="col-md-1"><fmt:formatDate
													value="${product.product_createdate}"
													pattern="yyyy-MM-dd HH:mm" /></td>
											<td class="col-md-1"><input type="text"
												name="amo_${product.product_code }"
												value="${product.product_amount }" class="form-control"></td>
											<td class="col-md-1"><input type="checkbox" value="Y"
												name="buy_${product.product_code }"
												<c:if test="${product.product_display.toString() eq 'Y' }">checked</c:if>>
											</td>
											<td class="col-md-1"><c:forEach items="${QnA }"
													var="qna">
													<c:choose>
														<c:when
															test="${qna.PRODUCT_CODE eq product.product_code }">
															<c:if test="${qna.COUNT != 0 }">
										 			${qna.COUNT } 개
										 		</c:if>
															<c:if test="${qna.COUNT eq 0 }">
										 			0 개
										 		</c:if>
														</c:when>
													</c:choose>
												</c:forEach></td>
											<td class="col-md-2"><button type="button"
													id="btn_modify" class="btn btn-primary"
													onclick="location.href = 'modify/${product.product_code}${pageMaker.makeCateSearch(pageMaker.cri.page)}'">
													수정</button></td>
											<td class="col-md-2">
												<button type="button" class="btn btn-danger"
													data-code="${product.product_code }">삭제</button>
											</td>
										</tr>

									</c:forEach>

								</table>

							</div>
							<!-- /.box-body -->


							<div class="box-footer">
								<button type="button" id="sel-change" class="btn btn-warning">선택
									상품 수정</button>
								<button type="button" id="sel-delete" class="btn btn-warning">선택
									상품 삭제</button>
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

							</div>
							<!-- /.box-footer-->
						</div>
					</div>
					<!--/.col (left) -->

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