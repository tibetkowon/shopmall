<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 3 -->
<script src="/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="/dist/js/adminlte.min.js"></script>

<!-- date-range-picker -->
<script src="/bower_components/moment/min/moment.min.js"></script>
<script src="/bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>

<!-- bootstrap datepicker -->
<script src="/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>

<script>

	$(function() {
		var msg = '${msg}';

		if (msg == 'log_fail') {
			alert("로그인 실패");
		} else if (msg == 'log_out') {
			alert("로그아웃 됨");
		} else if (msg == 'pro_update') {
			alert("수정완료");
		} else if (msg == 'pro_insert') {
			alert("등록 완료");
		} else if (msg == 'log_used') {
			alert("이미 로그인 되어있습니다.");
		} 
		
	//브라우저 종료

	});


</script>


<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->