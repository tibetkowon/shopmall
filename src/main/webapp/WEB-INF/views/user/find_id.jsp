<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>

<body class="hold-transition skin-blue sidebar-mini">
<script>
	 
	$(function() {
		
		function check() {

			var mailCheck = RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i);
			
			if ($("#user_name").val() == '') {
				alert("이름을 입력 하세요.");
				$("#user_name").focus();
				return false;
			}
			if ($("#user_email").val() == '') {
				alert("이메일 주소를 입력 하세요.");
				$("#user_email").focus();
				return false;
			}
			if(!mailCheck.test($("#user_email").val())){
				alert("이메일 주소를 정확히 입력해 주세요.");
				$("#user_email").focus();
				return false;
				}
			$.ajax({
				url	: "/user/find_id",
				type : "POST",
				data : {
					user_name : $("#user_name").val(),
					user_email : $("#user_email").val()
					},
				success : function(data) {
					if (data == 1) {
						alert("메일로 아이디가 발송되었습니다.");
						location.href = "/user/login";
					} else {
						alert("존재하지 않는 회원 정보 입니다.");
					}
					;
				}
			});
		}

		$("#btn-find").on("click", function() {
			check();
		});

		$("form[role='find'] input").keydown(function(e) {
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
				<h2>아이디 찾기</h2>
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

							<form action="#" method="post" role="find"
								class="center-block">
								<div class="form-group">
									<label for="exampleInputEmail1">이름</label>
									<div class="row">
										<div class="col-xs-5">
											<input type="text" id="user_name" name="user_name"
											placeholder="이름"	class="form-control has-warning">
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">이메일 주소</label>
									<div class="row">
										<div class="col-xs-5">
											<input type="text" id="user_email" name="user_email" 
											placeholder="이메일 주소" class="form-control">
										</div>
									</div>
								</div>
								<!-- /.box-body -->

								<div class="box-footer text-center">
									<button type="button" class="btn btn-primary" id="btn-find">찾기</button>
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
</body>
</html>