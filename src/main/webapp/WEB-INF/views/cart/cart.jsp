<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<body class="hold-transition skin-blue sidebar-mini">
<script>
	$(function(){

		$(".modBtn").on("click",function(){
				
				var data = {
					user_id : '${sessionScope.userVO.user_id}',
					product_code : $(this).attr("data-code"),
					product_count : $(this).parent().prev().children("input[name='product_count']").val()
						};

				$.ajax({
					url : "/cart/updateCount",
					type : "POST",
					data : data ,
					success : function(data){
							if(data == 1){
								alert("수정되었습니다.");
								location.reload();
								}
						}
					});
			});
		$(".delBtn").on("click",function(){
				var code = $(this).attr("data-code");
				$.ajax({
					url : "/cart/delete/"+code,
					type : "POST",
					success : function(data){
							if(data == 1){
								alert("삭제 되었습니다.");
								location.reload();
								}
						}
					});
			});
		
		$("#delAllBtn").on("click",function(){
			if(confirm("장바구니를 비우겠습니까?")){
				var user_id = "${sessionScope.userVO.user_id}";
				$.ajax({
					url : "/cart/deleteAll/"+user_id,
					type : "POST",
					success : function(data){
							if(data == 1){
								alert("전부 삭제 되었습니다.");
								location.reload();
								}
						}
					});
				}
			});

		$("#all-check").on("click",function(){
			var chk = $(this).is(":checked");
			if(chk){
				$("input[name='check_cart']").prop('checked',true);
			}else {		
				$("input[name='check_cart']").prop('checked',false);
				}
			});

		$("input[name='check_cart']").on("click",function(){
				var chk = $(this).is(":checked");
				if(!chk){
					$("#all-check").prop('checked',false);
					}
			});

		$("#checkDelBtn").on("click",function(){
			if($("input[name='check_cart']").is(":checked")){
				var checkArr = [];
				$("input[name='check_cart']:checked").each(function(i){
					checkArr.push($(this).val());
					});
				$.ajax({
					url : "/cart/checkDelete",
					type : "POST",
					data : {
					checkArr : checkArr
						},
					success : function(data){
						if(data == 1){
							alert("삭제되었습니다.");
							location.reload();
							}
						}

					});
				
				} else {
					alert("체크된 항목이 없습니다.");
					}
			});

			$("#buyAllBtn").on("click",function(){
				location.href="/order/order";
				});

			$("#buyBtn").on("click",function(){
				if($("input[name='check_cart']").is(":checked")){
					$("form[role='checkOrder']").submit();
					} else {
						alert("체크된 항목이 없습니다.");
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
			<section class="content-header">
				<h1>
					장바구니
				</h1>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
        | Your Page Content Here |
        -------------------------->
        		<div class="row">
					<!-- left column -->

					<div class="col-md-12">
						<div class="box" style="border: none;">
							<div class="box-header">
								<button id="checkDelBtn" class="btn btn-warning">선택 삭제</button>
								<button id="delAllBtn" class="btn btn-warning">장바구니 비우기</button><br>
							
							</div>
							<form action="/order/checkOrder" method="post" role="checkOrder">
							<div class="box-body">
								<%-- <c:set var="totalPrice" value="0" /> --%>
								
								
								<table class="table table-striped text-center" id="cartList">
									<tr>
										<th><input type="checkbox" id="all-check"></th>
										<th>이미지</th>
										<th>상품명</th>
										<th>판매가</th>
										<th>수량</th>
										<th>비고</th>
									</tr>
									<c:if test="${empty cartList}">
										<tr height="70">
											<td colspan="5" align="center">
												<p style="line-height: 70px;">장바구니가 비었습니다</p>
											</td>
										</tr>
									</c:if>
									<c:if test="${!empty cartList}">
										<c:forEach items="${cartList}" var="cart" varStatus="status">
											<tr>
												<td class="col-md-1"><input type="checkbox" name="check_cart" value="${cart.cart_code}"> </td>
												<td class="col-md-1"><img src="/admin/product/displayImage?filename=${cart.product_image}" class="img-thumbnail img-responsive"></td>
												<td class="col-md-4"><b>${cart.product_name}</b></td>
												<td class="col-md-1">
													<span class="price">
													<fmt:formatNumber value="${cart.product_price*cart.product_count}" pattern="#,###.##"/> 원
													<%--<fmt:formatNumber value="${cart.product_price*cart.product_count}" type="currency" currencySymbol="￦" />--%>
													<input type="hidden" name="product_price" value="${cart.product_price}">
													</span>
												</td>
												<td class="col-md-1">
													<input type="text" name="product_count" value="${cart.product_count}" size="5">
												</td>
												<td class="col-md-4">
													<button type="button" class="btn btn-default modBtn" data-code="${cart.product_code}">수량수정</button> <!-- cart_code, cart_amount -->
													<button type="button" class="btn btn-danger delBtn" data-code="${cart.cart_code}">삭제</button> <!-- cart_code -->
												</td>
											</tr>
										</c:forEach>
									</c:if>
									
								</table>
								
							</div>
							<!-- /.box-body -->
								<div class="box-footer text-center">
							
							
									<button type="button" id="buyBtn" class="btn btn-info">선택 구매</button>
									<button type="button" id="buyAllBtn" class="btn btn-primary">모두 구매</button>
									<button id="listBtn" class="btn btn-default" onClick="location.href='/'">목록으로</button>
								</div>
								
							<!-- /.box-footer-->
						</form>
						</div>
					</div>
					<!--/.col (left) -->

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