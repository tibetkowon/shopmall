<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<%@include file="include/header.jsp"%>
<body class="hold-transition skin-blue sidebar-mini">

	<script type="text/javascript"
		src="https://www.gstatic.com/charts/loader.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.3/handlebars.js"></script>

	<script type="text/javascript">
		$(function() {
			//기본 도넛
			if ($("input[name='cateRadio']").is(":checked")) {
				var check = $("input[name='cateRadio']:checked").val();
				var defaultdata;
				var elementID = "donutchart";
				if (check == 'default') {
					defaultdata = $.ajax({
						url : "/chart/getPrt_cateChart",
						dataType : "json",
						async : false
					}).responseText;
					dounut_chart(JSON.parse(defaultdata), elementID);
				}
			}
			//기본 막대
			var rankTop5 = $.ajax({
				url : "/chart/getAllRank",
				type : "GET",
				dataType : "json",
				async : false,
			}).responseText;
			bar_chart(JSON.parse(rankTop5), "ranking");

			//라디오 체크시
			$("input[name='cateRadio']").on("click", function() {
				$("input[name='multi-cate']:checked").prop("checked", false);

				var check = $("input[name='cateRadio']:checked").val();

				var jsondata;
				var elementID = "donutchart";
				if (check == 'default') {
					jsondata = $.ajax({
						url : "/chart/getPrt_cateChart",
						dataType : "json",
						async : false
					}).responseText;
				} else {
					jsondata = $.ajax({
						url : "/chart/getCateChart?prt_code=" + check,
						dataType : "json",
						async : false
					}).responseText;
				}
				dounut_chart(JSON.parse(jsondata), elementID);
			});
			//체크박스 체크시
			$("input[name='multi-cate']").on("click", function() {
				$("input[name='cateRadio']:checked").prop("checked", false);

				var checked = [];
				var elementID = "donutchart";
				$("input[name='multi-cate']:checked").each(function(i) {
					checked.push($(this).val());

				});
				if ($("input[name='multi-cate']").is(":checked")) {
					var jsondata = $.ajax({
						url : "/chart/getMulti_CateChart",
						type : "POST",
						data : {
							codes : checked,
						},
						dataType : "json",
						async : false
					}).responseText;
					dounut_chart(JSON.parse(jsondata), elementID);
				} else {
					return false;
				}
			});

			var rank_prt_code;
			//랭킹 카테고리 선택
			$(".prtCate-dropdown").on(
					"click",
					function() {
						rank_prt_code = $(this).val();
						var elementID = "ranking";

						if (rank_prt_code != 0) {
							$.getJSON('/product/getCate/' + rank_prt_code,
									function(data) {
										var template = Handlebars.compile($(
												"#rank_subcate").html());
										var html = template(data);
										$(".cate-rank")
												.children(".subCateTaps")
												.remove();
										$(".cate-rank").append(html);
									});
							rankTop5 = $.ajax({
								url : "/chart/getPrtRank?prt_code="
										+ rank_prt_code,
								type : "GET",
								dataType : "json",
								async : false
							}).responseText;
							bar_chart(JSON.parse(rankTop5), elementID);

						} else {
							$(".cate-rank").children(".subCateTaps").remove();
							rankTop5 = $.ajax({
								url : "/chart/getAllRank",
								type : "GET",
								dataType : "json",
								async : false
							}).responseText;
							bar_chart(JSON.parse(rankTop5), elementID);
						}

					});

			//랭킹 2차카테 선택
			$(".cate-rank").on("click", ".subCateTaps", function() {
				var cate_code = $(this).attr("data-code");
				rankTop5 = $.ajax({
					url : "/chart/getCateRank?cate_code=" + cate_code,
					type : "GET",
					dataType : "json",
					async : false
				}).responseText;
				bar_chart(JSON.parse(rankTop5), "ranking");
			});

			//2차 전체
			$(".all-cate").on("click", function() {
				rankTop5 = $.ajax({
					url : "/chart/getPrtRank?prt_code=" + rank_prt_code,
					type : "GET",
					dataType : "json",
					async : false
				}).responseText;
				bar_chart(JSON.parse(rankTop5), "ranking");
			});

			//기간 검색
			var search = false;
			$("#searchBtn").on("click", function() {
				var start_date = $("#start_date").val();
				var end_date = $("#end_date").val();

				if (start_date == '' || end_date == '') {
					alert("날짜를 입력하세요");
					return false;
				}
				if (start_date > end_date) {
					alert("날짜를 정확히 입력하세요");
					return false;
				}

				if (start_date > getToday()) {
					alert("날짜를 정확히 입력하세요");
					return false;
				}
				search = true;
				$.ajax({
					url : "/chart/searchChart",
					type : "POST",
					data : {
						start_date : start_date,
						end_date : end_date
					},
					dataType : "json",
					async : false,
					success : function(data) {
						var option = {
							title : "기간 매출"
						}
						var option2 = {
							title : "가입자 수, 주문 수",
							 curveType: 'function'
						}
						line_chart(data.periodSales, "search-sales", option);
						line_chart(data.count,"serach-order-create", option2)
						bar_chart(data.top10, "search-top10");
						bar_chart(data.prt_sales, "search-prtcate");
					}
				});
			});
			//리셋 버튼
			$("#resetBtn").on("click", function() {
				$("#start_date").val("");
				$("#end_date").val("");
			});
			//기간 2차 카테 검색
			$("input[name='search-cate']").on(
					"click",
					function() {
						if (search) {
							var start_date = $("#start_date").val();
							var end_date = $("#end_date").val();

							if (start_date == '' || end_date == '') {
								alert("날짜를 입력하세요");
								return false;
							}
							if (start_date > end_date) {
								alert("날짜를 정확히 입력하세요");
								return false;
							}

							if (start_date > getToday()) {
								alert("날짜를 정확히 입력하세요");
								return false;
							}
							var checked = [];
							var elementID = "search-category";
							if ($("input[name='search-cate']").is(":checked")) {
								$("input[name='search-cate']:checked").each(
										function(i) {
											checked.push($(this).val());
										});
								var jsondata = $.ajax({
									url : "/chart/search_cateSales",
									type : "POST",
									data : {
										start_date : start_date,
										end_date : end_date,
										cate_code : checked
									},
									dataType : "json",
									async : false
								}).responseText;
								dounut_chart(JSON.parse(jsondata), elementID);
							} else {
								return false;
							}
						} else {
							alert("기간을 먼저 검색하세요.");
							return false;
						}
					});

		}) //ready

		//오늘 날짜 뽑기
		function getToday() {
			var now = new Date();
			var year = now.getFullYear();
			var month = now.getMonth() + 1;
			var date = now.getDate();

			if ((month + "").length < 2) {
				month = "0" + month;
			}
			return today = "" + year + "-" + month + "-" + date;
		}
		//도넛 생성 함수
		function dounut_chart(jsondata, elementID) {
			google.charts.load("current", {
				packages : [ "corechart" ]
			});

			google.charts.setOnLoadCallback(drawChart);

			function drawChart() {
				var data = google.visualization.arrayToDataTable(jsondata);

				var options = {
					pieHole : 0,
				};

				var chart = new google.visualization.PieChart(document
						.getElementById(elementID));
				chart.draw(data, options);
			}
		}

		//막대기 생성 함수
		function bar_chart(jsondata, elementID) {
			google.charts.load('current', {
				'packages' : [ 'bar' ]
			});
			google.charts.setOnLoadCallback(drawChart);

			function drawChart() {
				var data = google.visualization.arrayToDataTable(jsondata);

				var options = {
					chart : {}
				};

				var chart = new google.charts.Bar(document
						.getElementById(elementID));

				chart.draw(data, google.charts.Bar.convertOptions(options));
			}
		}
		//라인 차트 생성 함수
		function line_chart(jsondata, elementID, option) {
			google.charts.load('current', {
				'packages' : [ 'corechart' ]
			});
			google.charts.setOnLoadCallback(drawChart);

			function drawChart() {
				var data = google.visualization.arrayToDataTable(jsondata);

				var options = {
					title : 'Company Performance',
					curveType : 'function',
					legend : {
						position : 'bottom'
					}
				};

				var chart = new google.visualization.LineChart(document
						.getElementById(elementID));

				chart.draw(data, option);
			}
		}
	</script>
	<script id="rank_subcate" type="text/x-handlebars-template">	
	{{#each .}}
	<li class="subCateTaps" data-code="{{category_code}}"><a href="#ranking" data-toggle="tab" aria-expanded="false">{{category_name}}</a></li>
	{{/each}}
	</script>
	<div class="wrapper">
		<!-- Main Header -->
		<%@include file="include/admin_header.jsp"%>

		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="include/left.jsp"%>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>관리자 페이지</h1>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
        | Your Page Content Here |
        -------------------------->
				<!-- 왼쪽 -->
				<div class="col-md-6">
					<%-- 전체기간 판매량 --%>
					<div class="box box-danger">
						<div class="box-header">
							<b>전체기간 판매량</b>
							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse" data-toggle="tooltip" title=""
									data-original-title="Collapse">
									<i class="fa fa-minus"></i>
								</button>
							</div>
						</div>

						<div class="box-body" id="donutchart" style="width: 100%;"></div>
						<div class="box-footer text-center">
							<label> 1차 <input type="radio" name="cateRadio"
								value="default" checked />&nbsp;
							</label>
							<c:forEach items="${prtList}" var="prtCate" varStatus="status">
								<label> ${prtCate.category_name } <input type="radio"
									name="cateRadio" value="${prtCate.category_code }" />&nbsp;
								</label>
							</c:forEach>
							&nbsp;&nbsp; <b>카테고리 선택</b> (
							<c:forEach items="${prtList }" var="prtCate" varStatus="status">
								<label> ${prtCate.category_name } <input type="checkbox"
									name="multi-cate" value="${prtCate.category_code }" />
								</label>
							</c:forEach>
							)

						</div>
					</div>

					<%-- 전체기간 top5 --%>
					<div>
						<div class="box box-danger">
							<div class="box-header">
								<b>전체기간 TOP 5</b>
								<div class="box-tools pull-right">
									<button type="button" class="btn btn-box-tool"
										data-widget="collapse" data-toggle="tooltip" title=""
										data-original-title="Collapse">
										<i class="fa fa-minus"></i>
									</button>
								</div>
							</div>
							<div class="box-body">
								<div class="nav-tabs-custom">
									<ul class="nav nav-tabs pull-right">
										<li class="pull-left header"></li>
										<li class="dropdown"><a class="dropdown-toggle"
											data-toggle="dropdown" href="#" aria-expanded="false">카테고리
												<span class="caret"></span>
										</a>
											<ul class="dropdown-menu">
												<li role="presentation" class="prtCate-dropdown" value="all"><a>전체</a></li>

												<li role="presentation" class="divider"></li>

												<c:forEach items="${prtList }" var="prtCate"
													varStatus="status">
													<li role="presentation" class="prtCate-dropdown"
														value="${prtCate.category_code }"><a>${prtCate.category_name }</a></li>
												</c:forEach>
											</ul></li>
									</ul>
									<ul class="nav nav-tabs cate-rank">
										<li class="all-cate active"><a href="#ranking"
											data-toggle="tab" aria-expanded="false">전체</a></li>
									</ul>
									<div class="tab-content">
										<div class="tab-pane active">
											<div id="ranking"></div>
										</div>
										<!-- /.tab-pane -->
									</div>
								</div>
							</div>
						</div>
						<!-- /.tab-content -->
						<%-- 슬라이드 --%>
						<div class="box box-solid">
							<div class="box-header">
								<b>News</b>
								<div class="box-tools pull-right">
									<button type="button" class="btn btn-box-tool"
										data-widget="collapse" data-toggle="tooltip" title=""
										data-original-title="Collapse">
										<i class="fa fa-minus"></i>
									</button>
								</div>
							</div>
							<div class="box-body">
								<div id="carousel-example-generic" class="carousel slide"
									data-ride="carousel">
									<ol class="carousel-indicators">
										<li data-target="#carousel-example-generic" data-slide-to="0"
											class=""></li>
										<li data-target="#carousel-example-generic" data-slide-to="1"
											class=""></li>
										<li data-target="#carousel-example-generic" data-slide-to="2"
											class="active"></li>
									</ol>
									<div class="carousel-inner">
										<div class="item text-center bg-maroon">
											<a href="/admin/product/QnA" style="color: white;"> 미답변 상품
												QnA&nbsp;:&nbsp;${no_reply } 개 </a>

											<div class="carousel-caption bg-maroon">1</div>
										</div>
										<div class="item text-center bg-orange">
											<a href="/admin/FAQ/list" style="color: white;"> 신규
												FAQ&nbsp;:&nbsp;${newFAQ } 개 </a>
											<div class="carousel-caption bg-orange">2</div>
										</div>
										<div class="item text-center active bg-teal">
											<a href="/admin/order/list" style="color: white;">전날 총
												주문 수 &nbsp;:&nbsp;${newOrder } 개</a>

											<div class="carousel-caption bg-teal">3</div>
										</div>
									</div>
									<a class="left carousel-control"
										href="#carousel-example-generic" data-slide="prev"> <span
										class="fa fa-angle-left"></span>
									</a> <a class="right carousel-control"
										href="#carousel-example-generic" data-slide="next"> <span
										class="fa fa-angle-right"></span>
									</a>
								</div>
							</div>
							<div class="box-footer"></div>
						</div>

					</div>
					<!-- /왼쪽 -->

				</div>
				<!-- 오른쪽 -->
				<div class="col-md-6">
					<%-- 날짜 검색 --%>
					<div class="box box-success">
						<div class="box-header">
							<b>날짜 검색</b>
							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse" data-toggle="tooltip" title=""
									data-original-title="Collapse">
									<i class="fa fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="box-body">
							<div>
								<div class="col-md-5">
									<label> <input type="date" class="form-control"
										name="start_date" id="start_date"> 부터 ~
									</label>
								</div>
								<div class="col-md-5">
									<label> <input type="date" class="form-control"
										name="end_date" id="end_date"> 까지
									</label>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<button type="button" class="btn btn-xs btn-primary pull-right"
								id="searchBtn">검색</button>
							<div class="pull-right">&nbsp; &nbsp; &nbsp;</div>
							<button type="reset" class="btn btn-xs btn-primary pull-right"
								id="resetBtn">초기화</button>
						</div>
					</div>

					<%-- 검색기간 매출 --%>
					<div class="box">
						<div class="box-header">
							<b>주문 수 ,가입 수</b>
							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse" data-toggle="tooltip" title=""
									data-original-title="Collapse">
									<i class="fa fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="box-body" id="serach-order-create"></div>
					</div>
					<div class="box">
						<div class="box-header">
							<b>매출</b>
							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse" data-toggle="tooltip" title=""
									data-original-title="Collapse">
									<i class="fa fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="box-body" id="search-sales"></div>
					</div>

					<%-- 검색기간 판매량 --%>
					<div class="box box-warning">
						<div class="box-header">
							<b>판매량 TOP 10</b>
							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse" data-toggle="tooltip" title=""
									data-original-title="Collapse">
									<i class="fa fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="box-body" id="search-top10"></div>
					</div>

					<%-- 검색기간 1차카테 판매량--%>
					<div class="box box-info">
						<div class="box-header">
							<b>1차 카테고리 판매량</b>
							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse" data-toggle="tooltip" title=""
									data-original-title="Collapse">
									<i class="fa fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="box-body" id="search-prtcate"></div>
					</div>

					<%-- 검색기간 2차카테 판매량--%>
					<div class="box box-primary">
						<div class="box-header">
							<b>2차 카테고리 판매량</b>
							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse" data-toggle="tooltip" title=""
									data-original-title="Collapse">
									<i class="fa fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="box-body" id="search-category"></div>
						<div class="box-footer">
							<c:forEach items="${prtList }" var="prtCate" varStatus="status">
								<label> ${prtCate.category_name } <input type="checkbox"
									name="search-cate" value="${prtCate.category_code }" />
								</label>
							</c:forEach>
						</div>
					</div>
				</div>

			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%@include file="include/footer.jsp"%>
		<!-- Control Sidebar -->
		<%@include file="include/right.jsp"%>
	</div>
	<!-- ./wrapper -->

</body>
</html>