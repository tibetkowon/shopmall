<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<body class="hold-transition skin-blue sidebar-mini">
<script>
$(function(){
		
	$('#searchBtn').on("click", function(event) {
		self.location = "/product/list/"
				+ '${cate_code }'
				+ '${pageMaker.makeQuery(1)}'
				+ "&subCategory="
				+ '${cate_code }'
				+ "&searchType="
				+ $("#searchType option:selected").val()
				+ "&keyword=" + $('#keywordInput').val();
	});

	$("button[name='btnAddCart']").on("click",function(){

		if('${sessionScope.userVO.user_id}' == ''){
				alert("로그인 하세요");
				return false;
			} else {
				var data = {
					product_code : $(this).attr("data-code"),
					user_id : '${sessionScope.userVO.user_id}',
					product_count : 1
				};	

			$.ajax({
				url : "/cart/addCart",
				type : "POST",
				data : data,
				success : function(){
							if(confirm("장바구니 추가 되었습니다. 장바구니로 이동하시겠습니까?")){
								location.href = "/cart/cart";
								} else {}
							}
				});				
			}
		});
	$("button[name='quickBuy']").on("click",function(){
	location.href = "/order/quickOrder/"+ $(this).attr("data-code");	
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
			<section class="content-header" id="category-title">
				
			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
        | Your Page Content Here |
        -------------------------->
				<div class="box box-danger">
					<div class="box-header">상품 검색</div>
					<div class='box-body'>
						<div class="col-xs-3">	
							<select id="searchType" name="searchType" class="form-control">
								<option value="name"
									<c:out value="${cri.searchType eq 'name'?'selected':''}"/>>
									상품명</option>
								<option value="inform"
									<c:out value="${cri.searchType eq 'inform'?'selected':''}"/>>
									상품설명</option>
								<option value="price"
									<c:out value="${cri.searchType eq 'price'?'selected':''}"/>>
									가격</option>
								<option value="nainform"
									<c:out value="${cri.searchType eq 'nainform'?'selected':''}"/>>
									상품명 / 상품설명</option>
							</select>
						</div>
						<div class="col-xs-6">
							 <input type="text" name='keyword' id="keywordInput" class="form-control"
								value='${cri.keyword }'>
						</div>
						<div class="col-xs-1">
							<button id='searchBtn' class="btn btn-default">Search</button>
						</div>
					</div>
	        		
	        	</div>
	        	
	        	<div class="box box-primary center">
					<div class="box-header"><strong>상품목록</strong></div>
	        		<table style="border-collapse: collapse; width:80%; margin: 0 auto;" class="table">
	        			<tr>
	        				<c:forEach items="${ProductList}" var="productVO" varStatus="status">
	        					<c:if test="${status.index%5==0}">
	        						</tr><tr height="200">
	        					</c:if>
	        					<td align="center" >
	        						<a href="/product/${productVO.product_code}" style="color: black;">
		        						<img src="/admin/product/displayImage?filename=${productVO.product_image}" class="img-thumbnail img-responsive">
		        						<br><br>
		        						<Strong>${productVO.product_name} </Strong>
		        						<c:if test="${productVO.product_event.toString() eq 'Y' }">
		        						<i class="glyphicon glyphicon-gift"></i>
		        						</c:if>
		        					</a><br/>
		        					 <fmt:formatNumber value="${productVO.product_price }" pattern="#,###.##"/> <i class="fa fa-krw"></i><br>
		        					<button class="btn btn-info" name="btnAddCart" data-code="${productVO.product_code }">담기</button>
		        					<button class="btn btn-warning" name="quickBuy" data-code="${productVO.product_code}">구매</button>
		        					
	        					</td>
	        				</c:forEach>
	        			</tr>
	        		</table>
	        		<div class="box-footer">
	        		<div class="text-center">
						<ul class="pagination">

							<c:if test="${pageMaker.prev}">
								<li><a
									href="/product/list/${cate_code }${pageMaker.makeCate(pageMaker.startPage - 1) }">&laquo;</a></li>
							</c:if>

							<c:forEach begin="${pageMaker.startPage }"
								end="${pageMaker.endPage }" var="idx">
								<li
									<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
									<a href="/product/list/${cate_code }${pageMaker.makeCate(idx)}">${idx}</a>
								</li>
							</c:forEach>

							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li><a
									href="/product/list/${cate_code }${pageMaker.makeCate(pageMaker.endPage +1) }">&raquo;</a></li>
							</c:if>

						</ul>
					</div>
	        		</div>
	        	</div>

			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%@include file="../include/footer.jsp" %>
	<!-- Control Sidebar -->	
		<%@include file="../include/right.jsp" %>
	</div>
	<!-- ./wrapper -->

</body>
</html>