<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<body class="hold-transition skin-blue sidebar-mini">
<script src="/ckeditor/ckeditor.js"></script>
<script>

$(function(){
	//메일전송용 ckeditor
	var ckeditor_config = {
		resize_enable : false,
		enterMode : CKEDITOR.ENTER_BR,
		shiftEnterMode : CKEDITOR.ENTER_P,
		filebrowserUploadUrl : '/admin/product/imgUpload' // editor에서 이미지 업로드 하고 서버로 전송을 누르면 이 링크로 전송됨
	};
	CKEDITOR.replace('mail_content', ckeditor_config);
	
	$(".user-detail").on("click",function(){
		$.ajax({
			url : "/admin/user/detail",
			type : "POST",
			data : {
				user_id : $(this).text()
				},
			success : function(data){
				if(data != null){
				$("#user_id").text(data.user_id);
				$("#user_name").text(data.user_name);
				$("#user_postcode").text(data.user_postcode);
				$("#user_address").text(data.user_address);
				$("#user_detailaddr").text(data.user_detailaddr);
				$("#user_phonenum").text(data.user_phonenum);
				$("#user_email").text(data.user_email);
				$("#writeEmail").attr("data-code",data.user_id);
				$("#user_email_check").text(data.user_mail_check);
					}
				}
			});
		});
	
	$("#all-check").on("click",function(){
		var chk = $(this).is(":checked");
		if(chk){
			$(".user-check").prop('checked',true);
		}else {		
			$(".user-check").prop('checked',false);
			}
		});
	
	$(".user-check").on("click",function(){
		var chk = $(this).is(":checked");
		if(!chk){
			$("#all-check").prop('checked',false);
			}
	});

	var mail = [];
	var all_send = false;

	//체크 메일 전송 
	$("#chk-mail").on("click",function(){
		if($(".user-check").is(":checked")){
			all_send = false;
			mail = [];
			$(".user-check:checked").each(function(i){
				mail.push($(this).val());
			});
			$("#write-mail").modal('toggle');
		}else{
			alert("체크된 항목이 없습니다.");
			}
	});
	//회원 상세 메일전송
	$("#writeEmail").on("click",function(){
		all_send = false;
		mail = [];
		mail.push($(this).attr("data-code"));
		});
	//전체 메일 전송
	$("#all-mail").on("click",function(){
		all_send = true;
		mail = [];
		});
	//메일 전송 버튼

	$("#send-mail").on("click", function() {
				var contents = CKEDITOR.instances.mail_content.getData();
			if (all_send == false) {
				$.ajax({
					url : "/admin/user/sendMail",
					type : "POST",
					data : {
						mail : mail,
						mail_title : $("#mail-title").val(),
						mail_content : contents
					},
					success : function(data) {
						if (data == 1) {
							alert("전송 되었습니다.");
							$("#write-mail").modal('toggle');
						}
					}
				});
			} else {
				$.ajax({
					url : "/admin/user/allMail",
					type : "POST",
					data : {
						mail_title : $("#mail-title").val(),
						mail_content : contents
					},
					success : function(data) {
						if (data == 1) {
							alert("전송 되었습니다.");
							$("#write-mail").modal('toggle');
						}
					}
				});
				}
		});

	//회원 삭제
	
	$(".delbtn").on("click", function() {
			if (confirm("회원 삭제?")) {
				$.ajax({
					url : "/admin/user/userDelete",
					type : "POST",
					data :$(this).attr("data-id"),
					success : function(data) {
						if(data == 1){
						alert("삭제 되었습니다.");
						location.reload();
							}
					}
				});
			}
		});
	$("#chk-del").on("click", function() {
		if($(".user-check").is(":checked")){
			if (confirm("회원 삭제?")) {
				var ids = [];
				$(".user-check:checked").each(function(i){
					ids.push($(this).val());
				});
				$.ajax({
					url : "/admin/user/checkDelete",
					type : "POST",
					data :{ ids : ids},
					success : function(data) {
						if(data == 1){
						alert("삭제 되었습니다.");
						location.reload();
							}
					}
				});
			}
		}else{
			alert("체크된 항목이 없습니다.");
			}
		});

	}); //ready
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
				<h1>
					회원 목록
				</h1>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
				
				<div class="row">
		<!-- left column -->


		<div class="col-md-12">
			<!-- general form elements -->
			<%-- <div class='box'>
				<div class="box-header with-border">
					<h3 class="box-title">상품 검색</h3>
				</div>

				<div class='box-body'>
					<div class="col-xs-3">
						<select id="mainCategory" name="mainCategory"
							class="form-control">
							<option value=""
							<c:out value="${mainCategory == null?'selected':''}"/>>상위 카테고리</option>
							<c:forEach items="${cateList }" var="cate">
								<option value="${cate.category_code }">	${cate.category_name }</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-xs-3">
						<select id="subCategory" name="subCategory"
							class="form-control">
							<option value="" class="form-control">하위 카테고리</option>
						</select>
					</div>
				</div>
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
			</div> --%>


			<div class="box">
				<div class="box-header with-border">
					<h4 class="box-title">목록</h4>
				</div>
				<div class="box-body">
					<table class="table table-striped text-center">
						<thead>
							<tr>
								<th><input type="checkbox" id="all-check"> </th>
								<th>순번</th>
								<th>회원 ID</th>
								<th>회원 이름</th>
								<th>가입일</th>
								<th>최근 수정일</th>
								<th>포인트</th>
								<th>주문횟수</th>
								<th>주문 총액</th>
								<th>삭제</th>
							</tr>
						</thead>
						<c:forEach items="${userList }" var="user" varStatus="status">

							<tr>
								<td><input type="checkbox" class="user-check" value="${user.user_id}"></td>
								<td class="col-md-1">${status.index+1 }</td>
								<td class="col-md-2">
									<button class="btn btn-link user-detail" style="color: black;"
									data-toggle="modal" data-target="#user_detail">${user.user_id }</button></td>
								<td class="col-md-2">${user.user_name }</td>
								<td class="col-md-2"><fmt:formatDate value="${user.user_createdate }" pattern="yyyy-MM-dd" /></td>
								<td class="col-md-2"><fmt:formatDate value="${user.user_update }" pattern="yyyy-MM-dd" /></td>
								<td class="col-md-1"><fmt:formatNumber value="${user.user_point }" pattern="#,###.##"/>P</td>
								<td class="col-md-1">${user.order_count }회</td>
								<td class="col-md-1"><fmt:formatNumber value="${user.total_price }" pattern="#,###.##"/> <i class="fa fa-krw"></i></td>
								<td class="col-md-1"><button type="button" class="btn btn-danger delbtn" data-id="${user.user_id }">삭제</button></td>
							</tr>

						</c:forEach>

					</table>

				</div>
				<!-- /.box-body -->


				<div class="box-footer">
					<button type="button" class="btn btn-warning" id="chk-mail">메일 전송</button>
					<button type="button" class="btn btn-warning" id="all-mail"
									data-toggle="modal" data-target="#write-mail">전체 메일</button>
					<button type="button" class="btn btn-danger" id="chk-del">계정 삭제</button>
					
					<div class="text-center">
						<ul class="pagination">

							<c:if test="${pageMaker.prev}">
								<li><a
									href="list${pageMaker.makeQuery(pageMaker.startPage - 1) }">&laquo;</a></li>
							</c:if>

							<c:forEach begin="${pageMaker.startPage }"
								end="${pageMaker.endPage }" var="idx">
								<li
									<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
									<a href="list${pageMaker.makeQuery(idx)}">${idx}</a>
								</li>
							</c:forEach>

							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li><a
									href="list${pageMaker.makeQuery(pageMaker.endPage +1) }">&raquo;</a></li>
							</c:if>

						</ul> 
					</div>
					
					<%-- 회원 상세 modal --%>
					<div class="modal fade in" id="user_detail" style="display: none; padding-right: 16px;">
				          <div class="modal-dialog">
				            <div class="modal-content">
				              <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                  <span aria-hidden="true">×</span></button>
				                <h4 class="modal-title">상세 정보</h4>
				              </div>
				              <div class="modal-body">
				                <div class="form-group">
									<label class="col-md-2 control-label">아이디</label>
									<font id="user_id"></font>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">이름</label>
									<font id="user_name"></font>
								</div>
								<div class="form-group">
									<div class="form-group">
									<label class="col-md-2 control-label">우편번호</label>
										<font id="user_postcode"></font>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">주소</label>
										<font id="user_address"></font>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">상세주소</label>
										<font id="user_detailaddr"></font>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">전화번호</label>
									<font id="user_phonenum"></font>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">e-mail</label>
									<font id="user_email"></font>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">메일 수신 여부</label>
									<font id="user_email_check"></font>
								</div>
				              </div>
				              <div class="modal-footer">
				                <button type="button" class="btn btn-default " data-dismiss="modal">닫기</button>
				                <button type="button" class="btn btn-primary pull-left" id="writeEmail"
									data-toggle="modal" data-target="#write-mail">메일 보내기</button>
				                <button type="button" class="btn btn-primary pull-left" id="readFAQ">작성 문의 보기</button>
				              </div>
				            </div>
				            <!-- /.modal-content -->
				          </div>
				          <!-- /.modal-dialog -->
				        </div>
				        <%--메일 전송 modal --%>
				        <div class="modal fade in" id="write-mail" style="display: none; padding-right: 16px;">
				          <div class="modal-dialog">
				            <div class="modal-content">
				              <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                  <span aria-hidden="true">×</span></button>
				                <h4 class="modal-title">메일 전송</h4>
				              </div>
				              <div class="modal-body">
				                <div class="form-group">
								<label class="col-xs-3 control-label">메일 제목</label>
					                <input type="text" id="mail-title" class="form-control">
								</div>
								<div class="form-group">
					                <textarea class="form-control" rows="7" cols="100" name="mail_content" id="mail_content"></textarea>
								</div>
				              </div>
				              <div class="modal-footer">
				                <button type="button" class="btn btn-default " data-dismiss="modal">닫기</button>
				                <button type="button" class="btn btn-primary pull-left" id="send-mail">메일 보내기</button>
				              </div>
				            </div>
				            <!-- /.modal-content -->
				          </div>
				          <!-- /.modal-dialog -->
				        </div>
				</div>
				<!-- /.box-footer-->
			</div>
		</div>
		<!--/.col (left) -->

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