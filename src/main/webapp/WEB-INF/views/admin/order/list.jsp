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
			//검색
			$('#searchBtn').on(
					"click",
					function(event) {
						var check = [];
						$("input[name='order_check']:checked").each(function(i){
							check.push($(this).val());
							});
						self.location = "list" + '${pageMaker.makeQuery(1)}'
								+ "&searchType="
								+ $("#searchType option:selected").val()
								+ "&keyword=" + $('#keywordInput').val()
								+ "&searchDate=" + $("#reservation").val()
								+ "&order_check=" + check;
					});

			//전체 체크
			$("#all-check").on("click", function() {
				var chk = $(this).is(":checked");
				if (chk) {
					$(".order-check").prop('checked', true);
				} else {
					$(".order-check").prop('checked', false);
				}
			});

			$(".order-check").on("click", function() {
				var chk = $(this).is(":checked");
				if (!chk) {
					$("#all-check").prop('checked', false);
				}
			});

			//개별 주문상태 변경
			$(".statusBtn").on("click", function() {
				if (confirm("상태를 변경 하시겠습니까?")) {
					var status = $(this).val();
					var code = $(this).attr("data-code");
					if (status == 'Y') {
						status = 'N'
					} else if (status == 'N') {
						status = 'Y'
					}

					$.ajax({
						url : "/admin/order/updateStatus",
						type : "POST",
						data : {
							order_check : status,
							order_code : code
						},
						success : function(data) {
							alert("변경되었습니다.");
							location.reload();
						}
					});
				}
			});
			//체크 주문 상태 변경
			$("#orders-success").on("click", function() {
				if ($(".order-check").is(":checked")) {
					if (confirm("상태를 변경 하시겠습니까?")) {
						var codes = [];
						$(".order-check:checked").each(function(i) {
							codes.push($(this).val());
						});
						$.ajax({
							url : "/admin/order/checkUpdate",
							type : "POST",
							data : {
								code : codes,
								status : 'Y'
							},
							success : function(data) {
								alert("변경 되었습니다.");
								location.reload();
							}
						});
					}
				} else {
					alert("체크된 항목이 없습니다.");
				}
			});
			$("#orders-ready").on("click", function() {
				if ($(".order-check").is(":checked")) {
					if (confirm("상태를 변경 하시겠습니까?")) {
						var codes = [];
						$(".order-check:checked").each(function(i) {
							codes.push($(this).val());
						});
						$.ajax({
							url : "/admin/order/checkUpdate",
							type : "POST",
							data : {
								code : codes,
								status : 'N'
							},
							success : function(data) {
								alert("변경 되었습니다.");
								location.reload();
							}
						});
					}
				} else {
					alert("체크된 항목이 없습니다.");
				}
			});

			//상품명 버튼
			$(".detailBtn").on("click", function() {
				var code = $(this).parents("tr").attr("data-code");
				$.ajax({
					url : "/admin/order/getOrder",
					type : "POST",
					data : {
						order_code : code
					},
					success : function(data) {
						var products = data.dto;
						var order = data.vo;

						detail_product(products);

						$("#order_name").val(order.order_name);
						$("#postcode").val(order.order_postcode);
						$("#address").val(order.order_address);
						$("#detail_addr").val(order.order_detailaddr);
						$("#phonenum").val(order.order_phonenum);
						$("#total_price").text(order.order_sumprice + '원');
						$("#order-detail").modal("toggle");

					}
				});
			})

			//템플릿 함수
			function detail_product(data) {
				var template = Handlebars.compile($("#detailTemplate").html());
				var html = template(data);
				$("#detail_tbl").empty();
				$("#detail_tbl").append(html);
			}

			//주문금액 계산기
			Handlebars.registerHelper("price_x_count", function(option) {
				var str;
				str = this.order_count * this.product_price;
				return str;
			});

			$("#datepicker").datepicker({
				autoclose : true
			})

			$('#reservation').daterangepicker()
		}); // ready
	</script>
	<script type="text/javascript">
		$(function() {

			$(".dateBtn").on("click", function() {
				$('#reservation').val(insert_date($(this).val()));
			});

			
		});//ready

		function insert_date(day) {
			var end = new Date().toLocaleDateString("en-US");
			var start = new Date();
			if (day != 0) {
				start.setDate(start.getDate() - day);
				start = start.toLocaleDateString("en-US");
			}
			var date = moment(start).format('L') + " - "
					+ moment(end).format('L');
			return date;
		}
	</script>
	<script id="detailTemplate" type="text/x-handlebars-template">
	<thead>
		<tr>
			<th>상품이미지</th>
			<th>상품명</th>
			<th>판매가</th>
			<th>수량</th>
			<th>주문금액</th>
		</tr>
		</thead>	
	{{#each .}}
		<tr>
			<td class="col col-md-2"><img src="/admin/product/displayImage?filename={{product_image}}"class="img-thumbnail img-responsive"/></td>	
			<td class="col col-md-3"><a href="/product/{{product_code}}" style="color : black;"><b>{{product_name}}</b></a></td>
			<td class="col col-md-2">{{product_price}} 원</td>
			<td class="col col-md-1">{{order_count}} 개</td>
			<td class="col col-md-2">{{price_x_count}} 원</td>
			
		</tr>
	{{/each}}

	<div class="box-footer">
	  <div>끝</div>
	</div>
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
				<h1>주문 목록</h1>

			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
        | Your Page Content Here |
        -------------------------->
				<div class="box box-danger">
					<div class="box-header">
						<b>검색</b>
					</div>
					<div class='box-body'>
						<table class="table table-bordered text-center">
							<tr>
								<th class="col-md-1 bg-gray">기간검색</th>
								<td>
									<div class="btn-group col-md-6">
										<button class="btn bg-navy dateBtn" type="button" value="0">오늘</button>
										<button class="btn bg-navy dateBtn" type="button" value="1">어제</button>
										<button class="btn bg-navy dateBtn" type="button" value="7">7일</button>
										<button class="btn bg-navy dateBtn" type="button" value="15">15일</button>
										<button class="btn bg-navy dateBtn" type="button" value="30">1개월</button>
										<button class="btn bg-navy dateBtn" type="button" value="90">3개월</button>
										<button class="btn bg-navy dateBtn" type="button" value="180">6개월</button>
									</div>
									<div class="col-md-3">
										<input type="text" class="form-control" id="reservation"
											value="<c:out value="${pageMaker.cri.searchDate != null ? pageMaker.cri.searchDate:''}"/>">
									</div>
								</td>
							</tr>
							<tr>
								<th class="col-md-1 bg-gray">주문상태</th>
								<td>
									<input type="checkbox" value="N" name="order_check"
										<c:out value="${pageMaker.cri.order_check.contains('N') ? 'checked':''}" />
									>배송준비 
									<input type="checkbox" value="Y" name="order_check"
										<c:out value="${pageMaker.cri.order_check.contains('Y') ? 'checked':''}" />
									>배송완료
								</td>
							</tr>
							<tr>
								<th class="col-md-1 bg-gray">검색어</th>
								<td>
									<div class="col-xs-3">
										<select id="searchType" name="searchType" class="form-control">
											<option value="code"
												<c:out value="${pageMaker.cri.searchType eq 'code'?'selected':''}"/>>
												주문번호</option>
											<option value="id"
												<c:out value="${pageMaker.cri.searchType eq 'id'?'selected':''}"/>>
												회원 ID</option>
										</select>
									</div>
									<div class="col-xs-6">
										<input type="text" name='keyword' id="keywordInput"
											class="form-control" value='${pageMaker.cri.keyword }'>
									</div>
									<div class="col-xs-1">
										<button id='searchBtn' class="btn btn-default">Search</button>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
				
				<div class="row">
					<!-- left column -->
					<div class="col-md-12">
						<!-- general form elements -->
						<div class="box box-primary">
							<div class="box-header with-border">
								<h4 class="box-title">목록</h4>
							</div>
							<div class="box-body">
								<table class="table table-striped text-center">
									<thead>
										<tr>
											<th><input type="checkbox" id="all-check"></th>
											<th>주문번호</th>
											<th>회원 ID</th>
											<th>상품명</th>
											<th>결제금액</th>
											<th>주문날짜</th>
											<th>주문상태</th>
											<th>삭제</th>
										</tr>
									</thead>

									<c:forEach items="${orders}" var="order" varStatus="status">
										<tr data-code="${order.order_code }">
											<td><input type="checkbox" class="order-check"
												value="${order.order_code}"></td>
											<td class="col-md-1">
												<p>${order.order_code }</p>
											</td>
											<td class="col-md-2">${order.user_id }</td>
											<td class="col-md-3"><button
													class="btn btn-link detailBtn" style="color: black;">
													${order.product_name}
													<c:choose>
														<c:when test="${order.product_amount > 1 }">
									 외 ${order.product_amount-1 } 개
									</c:when>
													</c:choose>
												</button></td>
											<td class="col-md-2">
												<p>
													<fmt:formatNumber value="${order.order_sumprice }"
														pattern="#,###.##" />
													<i class="fa fa-krw"></i>
												</p>
											</td>
											<td class="col-md-2"><fmt:formatDate
													value="${order.order_date}" pattern="yyyy-MM-dd HH:mm" /></td>
											<td class="col-md-1"><c:choose>
													<c:when test="${order.order_check eq 'Y'.charAt(0) }">
														<button class="btn btn-primary statusBtn"
															value="${order.order_check }"
															data-code="${order.order_code }">배송완료</button>
													</c:when>
													<c:when test="${order.order_check eq 'N'.charAt(0) }">
														<button class="btn btn-info statusBtn"
															value="${order.order_check }"
															data-code="${order.order_code }">배송준비</button>
													</c:when>
												</c:choose></td>
											<td class="col-md-1">
												<button class="btn btn-danger">삭제</button>
											</td>
										</tr>
									</c:forEach>

								</table>

							</div>
							<!-- /.box-body -->


							<div class="box-footer">
								<button type="button" id="orders-success"
									class="btn btn-primary">선택 배송완료</button>
								<button type="button" id="orders-ready" class="btn btn-info">선택
									배송준비</button>
								<button type="button" id="sel-delete" class="btn btn-danger">선택
									주문 삭제</button>
								<div class="text-center">
									<ul class="pagination">

										<c:if test="${pageMaker.prev}">
											<li><a
												href="list${pageMaker.makeOrderSearch(pageMaker.startPage - 1) }">&laquo;</a></li>
										</c:if>

										<c:forEach begin="${pageMaker.startPage }"
											end="${pageMaker.endPage }" var="idx">
											<li
												<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
												<a href="list${pageMaker.makeOrderSearch(idx)}">${idx}</a>
											</li>
										</c:forEach>

										<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
											<li><a
												href="list${pageMaker.makeOrderSearch(pageMaker.endPage +1) }">&raquo;</a></li>
										</c:if>

									</ul>
								</div>

							</div>
							<!-- /.box-footer-->
						</div>
					</div>
					<!--/.col (left) -->

				</div>
				<%--주문 상세 modal --%>
				<div class="modal fade in" id="order-detail"
					style="display: none; padding-right: 16px;">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
								<h4 class="modal-title">상세 정보</h4>
							</div>
							<div class="modal-body">
								<div class="box box-danger">
									<div class="box-header">
										<b>주문 상품</b>
									</div>
									<div class="box-body">
										<table id="detail_tbl" class="table table-striped text-center">
										</table>
									</div>
								</div>

								<div class="box box-primary">
									<!-- 'ORDER_POSTCODE','ORDER_ADDRESS','ORDER_DETAILADDR','ORDER_PHONENUM','ORDER_SUMPRICE'    -->
									<div class="box-header">
										<b>주문자 정보</b>
									</div>
									<div class="box-body">
										<div class="form-group">
											<label for="order_name">이름</label> <input type="text"
												class="form-control" id="order_name" readonly="readonly">
										</div>
										<div class="form-group">
											<label for="postcode">우편번호</label> <input type="text"
												class="form-control" id="postcode" readonly="readonly">
										</div>
										<div class="form-group">
											<label for="address">주소</label> <input type="text"
												class="form-control" id="address" readonly="readonly">
										</div>
										<div class="form-group">
											<label for="detail_addr">상세주소</label> <input type="text"
												class="form-control" id="detail_addr" readonly="readonly">
										</div>
										<div class="form-group">
											<label for="phonenum">연락처</label> <input type="text"
												class="form-control" id="phonenum" readonly="readonly">
										</div>
									</div>
									<div class="box-footer">
										<p class="text-right" style="padding-right: 20px;">
											총 주문 금액 &nbsp;&nbsp;:&nbsp;&nbsp; <span
												style="font-size: 20px;"><b id="total_price"></b></span>
										</p>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default "
									data-dismiss="modal">닫기</button>
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