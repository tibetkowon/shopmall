<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<body class="hold-transition skin-blue sidebar-mini">
<script>
	function home(){
		location.href = "/";
		}
	function cart(){
		location.href = "/cart/cart";
		}
	function orderList(){
		location.href = "/order/list";
		}
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
        		<div class="box box-danger text-center">
					<div class="box-header">
						<h3 class="box-title"><b>구매 완료</b></h3>
					</div>
					<div class="box-body">
					<br/>
					<br/>
					<div>
					주문이 완료 되었습니다.
					</div>
					<br/>
					<br/>
					<br/>
						<button type="button" class="btn btn-info" onClick="home()">홈 화면 이동</button>&nbsp; &nbsp; 
						<button type="button" class="btn btn-info" onClick="cart()">장바구니</button>&nbsp; &nbsp; 
						<button type="button" class="btn btn-info" onClick="orderList()">주문 목록</button>
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
		
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->

</body>
</html>