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
			
		});//ready
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
				<h1>카테고리 등록</h1>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
        | Your Page Content Here |
        -------------------------->

				<!-- 하위 카테고리 목록 -->

				<div class="box box-primary">
					<div class="box-body">
						<label>상위 카테고리
							<select class="form-control">
								<option >신규 상위</option>
								<c:forEach items="${prt_list }" var="prt">
								<option>${prt.category_name}</option>
								</c:forEach>
							</select>
						</label>
					</div>
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