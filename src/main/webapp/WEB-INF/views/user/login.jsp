<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>

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

	$("#btn-login").on("click", function() {
			var form = $("form[role='login']");
			check(form);
		});
		$("form[role='login'] input").keydown(function(e) {
			if (e.keyCode == 13) {
				var form = $("form[role='login']");
				check(form);
			}
		});

	}); //ready

	function find_id(){
		location.href = "/user/find_id";
		}
	function find_pw(){
		location.href = "/user/find_pw";
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
					회원 로그인
				</h1>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
        | Your Page Content Here |
        -------------------------->
				<div class="container">
					<div class="row center-block" style="max-width: 500px;">
						<form action="/user/loginPOST" method="post" role="login">
							<div class="form-group has-feedback">
								<input type="text" name="id" class="form-control"
									placeholder="ID" /> <span
									class="glyphicon glyphicon-envelope form-control-feedback"></span>
							</div>
							<div class="form-group has-feedback">
								<input type="password" name="pw" class="form-control"
									placeholder="Password" /> <span
									class="glyphicon glyphicon-lock form-control-feedback"></span>
							</div>
							<div class="form-group">
								<div class="checkbox icheck">
									<label> <input type="checkbox"
										style="position: relative; margin: 0;"> Remember Me
									</label>
								</div>
							</div>
							<div class="form-group">
								<button type="button" class="form-control btn btn-primary" id="btn-login">로그인</button>
							</div>
							<div class="form-group">
								<button type="button" class=" btn btn-link" onclick="find_id()">아이디찾기</button>
								<button type="button" class=" btn btn-link" onclick="find_pw()" >비밀번호 찾기</button>
							</div>
						</form>
					</div>
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