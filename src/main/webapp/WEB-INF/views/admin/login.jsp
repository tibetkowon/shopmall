<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<%@include file="include/header.jsp"%>
<body class="hold-transition skin-blue sidebar-mini">
<script>
	$(function(){
		
	function check(form) {
			if ($("input[name='id']").val() == '') {
				alert("아이디를 입력하세요.");
				$("input[name='id']").focus();
				return false;
			}
			if ($("input[name='pw']").val() == '') {
				alert("비밀번호를 입력하세요.");
				$("input[name='pw']").focus();
				return false;
			}
			form.submit();
		}
		$("form[role='login'] input").keydown(function(e) {
			if (e.keyCode == 13) {
				var form = $("form[role='login']");
				check(form);
			}
		});
		$("#btn-login").on("click", function() {
			var form = $("form[role='login']");
			check(form);
		});

	}); //ready
</script>
	<div class="wrapper">
		<%@include file="include/admin_header.jsp"%>

		<%@include file="include/left.jsp"%>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h3>관리자 로그인</h3>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">

			<div class="container">
					<div class="row center-block" style="max-width: 500px;">
						<form action="/admin/login" method="post" role="login">
							<div class="form-group has-feedback">
								<input type="text" name="id" class="form-control" placeholder="ID" />
								<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
							</div>
							<div class="form-group has-feedback">
								<input type="password" name="pw" class="form-control" placeholder="Password" />
								<span class="glyphicon glyphicon-lock form-control-feedback"></span>
							</div>
							<div class="form-group">
								<div class="checkbox icheck">
									<label>
										<input type="checkbox" name="useCookie" style="position: relative; margin: 0;">
										Remember Me
									</label>
								</div>
							</div>
							<div class="form-group">
								<button type="button" class="form-control btn btn-primary" id="btn-login">로그인</button>
							</div>
						</form>
					</div>
				</div>


			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%@include file="include/footer.jsp"%>

		<!-- Control Sidebar -->
		<%@include file="include/right.jsp" %>
	</div>
	<!-- ./wrapper -->

</body>
</html>