<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 3 -->
<script src="/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="/dist/js/adminlte.min.js"></script>
<script
		src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.3/handlebars.js"></script>
<script>

	$(function() {
		var msg = '${msg}';

		if (msg == 'log_fail') {
			alert("로그인 실패");
		} else if (msg == 'user_update') {
			alert("수정완료");
		} else if (msg == 'join_success') {
			alert("등록 완료");
		} else if (msg == 'buy_success') {
			alert("구매 완료"); 		
		} else if (msg == 'log_used') {
			alert("이미 로그인 중입니다."); 		
		}

		$("li[class='treeview']").one("click",function(){

			var prt_code = $(this).attr('id');
			var prt_cate = $(this);
			
			$.getJSON('/product/getCate/' + prt_code,
					function(data){
						var template = Handlebars.compile($(
						"#subCateListTemplate").html());
						var html = template(data);
						prt_cate.children("ul").children().remove();
						prt_cate.children("ul[class='treeview-menu']").append(html);
				});

			});

	});

</script>
<script id="subCateListTemplate" type="text/x-handlebars-template">
	{{#each .}}
		<li><a href="/product/list/{{category_code}}">{{category_name}}</a></li>
	{{/each}}
</script>



<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->