<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<body class="hold-transition skin-blue sidebar-mini">
<script>
$(function(){
	
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

	$("button[name='delBtn']").on("click",function(){
		if(confirm("주문 취소하시겠습니까?"))
			$.ajax({
				url : "/order/delete/"+$(this).attr("data-code"),
				type : "POST",
				success : function(data){
						if(data == 1){
							alert("주문이 취소 되었습니다.");
							location.reload();
							}
					}
				});
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
				</h1>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
        | Your Page Content Here |
        -------------------------->
        		<div class="box box-warning">
				<div class="box-header with-border">
					<h4 class="box-title">목록</h4>
				</div>
				<div class="box-body">
					<table class="table table-striped text-center">
						<tr>
							<th>주문날짜</th>
							<th>주문번호</th>
							<th>상품 이름</th>
							<th>결제금액</th>
							<th>주문 취소</th>
						</tr>

						<c:forEach items="${orders}" var="order" varStatus="status">
							<tr>
								<td class="col-md-2"><fmt:formatDate value="${order.order_date}" pattern="yyyy-MM-dd HH:mm" /></td>
								<td class="col-md-1">
									<p>${order.order_code }</p>
								</td>
								<td class="col-md-3">
									<a href="/order/detail/${order.order_code}" style="color: black">${order.product_name}
									<c:choose>
									<c:when test="${order.product_amount > 1 }">
									 외 ${order.product_amount-1 } 개</a>
									</c:when> 
									</c:choose>
								</td>
								<td class="col-md-2">
									<p><fmt:formatNumber value="${order.order_sumprice }" pattern="#,###.##"/> <i class="fa fa-krw"></i></p>
								</td>
								 <td class="col-md-1">
								 <c:choose>
								 <c:when test="${order.order_check eq 'N'.charAt(0) }">
								 	<button type="button" name="delBtn" class="btn btn-danger" data-code="${order.order_code }">주문 취소</button>						 						 
								 </c:when>
								 <c:otherwise>
								 	<div class="btn btn-info">배송완료</div>
								 </c:otherwise>
								 </c:choose>
								 </td>
							</tr>
						</c:forEach>

					</table>

				</div>
				<!-- /.box-body -->


				<div class="box-footer">
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