<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<%@include file="include/header.jsp"%>

<body class="hold-transition skin-blue sidebar-mini">
<script>
	
	$(function() {
		
		function check() {

			var pwCheck = RegExp(/^[\w\!\@\#\$\%\^\&\*]{8,20}$/);
			
			if ($("#now_pw").val() == '') {
				alert("현재 비밀번호를 입력 하세요.");
				$("#now_pw").focus();
				return false;
			}
			if ($("#change_pw").val() == '') {
				alert("변경될 비밀번호를 입력 하세요.");
				$("#change_pw").focus();
				return false;
			}
			if ($("#check_pw").val() == '') {
				alert("비밀번호 확인을 입력 하세요.");
				$("#check_pw").focus();
				return false;
			}
			if(!pwCheck.test($("#change_pw").val())){
				alert("비밀번호는 영어 대소문자,숫자 !,@,#,$,%,^,&,*를 이용한 8~20자만 가능합니다.");
				$("#change_pw").focus();
				return false;
				}
			if ($("#change_pw").val() != $("#check_pw").val()) {
				alert("비밀번호가 일치하지 않습니다.");
				$("#check_pw").focus();
				return false;
			}
			if ($("#now_pw").val() == $("#change_pw").val()) {
				alert("현재 비밀번호 와 변경될 비밀번호가 같습니다.");
				$("#now_pw").focus();
				return false;
			}
			$.ajax({
				url	: "/admin/pw_modify",
				type : "POST",
				data : {
					admin_id : '${sessionScope.admin.admin_id}',
					now_pw : $("#now_pw").val(),
					change_pw : $("#change_pw").val()
					},
				success : function(data) {
					if (data == 1) {
						alert("비밀번호가 변경 되었습니다, 다시 로그인 하세요.");
						location.href = "/admin/login";
					} else {
						alert("현재 비밀번호가 맞지 않습니다.");
						$("#now_pw").val();
						$("#now_pw").focus();
					}
					;
				}
			});
		}

		$("#btn-modify").on("click", function() {
			check();
		});

		$("form[role='modify'] input").keydown(function(e) {
			if (e.keyCode == 13) {
				check();
			}
		});

	}); // ready

	function cancel() {
		if (confirm("취소하고 홈화면으로 가시겠습니까?")) {
			location.href = "/admin";
		}
		return false;

	}
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
				<h2>관리자 비밀번호 수정</h2>
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

							<form action="/user/pw_modify" method="post" role="modify"
								class="center-block">
								<div class="form-group">
									<label for="exampleInputEmail1">현재 비밀번호</label>
									<div class="row">
										<div class="col-xs-5">
											<input type="password" id="now_pw" name="now_pw"
											placeholder="현재 비밀번호"	class="form-control has-warning">
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">비밀번호</label>
									<div class="row">
										<div class="col-xs-5">
											<input type="password" id="change_pw" name="change_pw" 
											placeholder=" 영어 대소문자  , 숫자  !  @  #  $  %  ^ &  *  8~20자리" class="form-control">
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">비밀번호 확인</label>
									<div class="row">
										<div class="col-xs-5">
											<input type="password" id="check_pw" name="check_pw"
												placeholder="비밀번호 확인" class="form-control">
										</div>
									</div>
								</div>
								<!-- /.box-body -->

								<div class="box-footer text-center">
									<button type="button" class="btn btn-primary" id="btn-modify">수정</button>
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
		<%@include file="include/footer.jsp" %>

		<!-- Control Sidebar -->
		<%@include file="include/right.jsp" %>
		
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->
</body>
</html>