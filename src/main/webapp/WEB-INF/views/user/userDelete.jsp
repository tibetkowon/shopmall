<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>

<body class="hold-transition skin-blue sidebar-mini">
<script>
	
	$(function() {
		
		function check() {
			
			if ($("#now_pw").val() == '') {
				alert("비밀번호를 입력 하세요.");
				$("#now_pw").focus();
				return false;
			}
			$.ajax({
				url	: "/userDelete",
				type : "POST",
				data : {
					id : '${sessionScope.userVO.user_id}',
					pw : $("#check_pw").val()
					},
				success : function(data) {
					if (data == 1) {
						alert("탈퇴 완료 되었습니다.");
						location.href = "/";
					} else {
						alert("비밀번호가 맞지 않습니다.");
						$("#check_pw").val();
						$("#check_pw").focus();
					}
					;
				}
			});
		}

		$("#btn-delete").on("click", function() {
			check();
		});

		$("form[role='delete'] input").keydown(function(e) {
			if (e.keyCode == 13) {
				check();
			}
		});

	}); // ready

	function cancel() {
		if (confirm("취소하고 홈화면으로 가시겠습니까?")) {
			location.href = "/";
		}
		return false;

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
				<h2>회원가입</h2>
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
						<div class="box box-primary center">
						<div class="container" style="width: 100%">
							<!-- /.box-header -->
							<div class="box-header"></div>

							<form action="#" method="post" role="delete"
								class="center-block">
								<div class="form-group">
									<label for="exampleInputEmail1">비밀번호 확인</label>
									<div class="row">
										<div class="col-xs-5">
											<input type="password" id="check_pw" name="check_pw"
											placeholder="현재 비밀번호"	class="form-control has-warning">
										</div>
									</div>
								</div>								
								<!-- /.box-body -->

								<div class="box-footer text-center">
									<button type="button" class="btn btn-primary" id="btn-delete">탈퇴</button>
									<button type="button" class="btn btn-danger" onclick="cancel()">취소</button>
								</div>
							</form>

						</div>
						</div>
					</div>
					<!-- /.box -->
				</div>
				<!--/.col (left) -->
	        	

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