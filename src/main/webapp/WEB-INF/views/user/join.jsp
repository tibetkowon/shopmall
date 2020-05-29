<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>

<body class="hold-transition skin-blue sidebar-mini">
<script>
	
	$(function() {
		var id_check = false;
		var email_check = false;
		
		$("#user_id").on("change",function(){
			id_check = false;
			$("#btnIDCheck").attr('class',"btn btn-primary");
			});
		
		$("#btnIDCheck").on("click",function(){
			var idCheck = RegExp(/^[a-z0-9\-\_]{4,20}$/);
			if(!idCheck.test($("#user_id").val())){
				alert("아이디는 영어 소문자,숫자, -,_ 로 4~20 자 가능합니다.");
				$("#user_id").focus();
				return false;
				}
			var user_id = $("#user_id").val();
			$.ajax({
					url : "/user/check_id/"+user_id ,
					type : "GET" , 
					success : function(data){
						if(data == 0){
							alert("사용 가능");
							id_check = true;
							$("#btnIDCheck").attr('class',"btn btn-success");
							} else {
							alert("사용 불가능");
							$("#user_id").focus();
							id_check = false;
							$("#btnIDCheck").attr('class',"btn btn-danger");
								}
						}

				});

			});

		
		function check(form) {

			var idCheck = RegExp(/^[a-z0-9\-\_]{4,20}$/);
			var pwCheck = RegExp(/^[\w\!\@\#\$\%\^\&\*]{8,20}$/);
			var nameCheck= RegExp(/^[가-힣]{2,15}$/);
			var phoneCheck = RegExp(/^\d{3}-\d{3,4}-\d{4}$/);
			

			
			if ($("#user_id").val() == '') {
				alert("아이디를 입력 하세요.");
				$("#user_id").focus();
				return false;
			}
			if(!idCheck.test($("#user_id").val())){
				alert("아이디는 영어 소문자,숫자, -,_ 를 이용한 4~20 자만 가능합니다.");
				$("#user_id").focus();
				return false;
				}
			if (!id_check){
				alert("중복확인 하세요.");
				$("#user_id").focus();
				return false;
				}
			if ($("#user_pw").val() == '') {
				alert("비밀번호를 입력 하세요.");
				$("#user_pw").focus();
				return false;
			}
			if(!pwCheck.test($("#user_pw").val())){
				alert("비밀번호는 영어 대소문자,숫자 !,@,#,$,%,^,&,*를 이용한 8~20자만 가능합니다.");
				$("#user_pw").focus();
				return false;
				}
			if ($("#user_pw2").val() == '') {
				alert("비밀번호 확인을 입력 하세요.");
				$("#user_pw2").focus();
				return false;
			}
			if ($("#user_pw").val() != $("#user_pw2").val()) {
				alert("비밀번호가 일치하지 않습니다.");
				$("#user_pw2").focus();
				return false;
			}
			if ($("#user_pw").val() == $("#user_id").val()){
				alert("아이디 비밀번호가 동일합니다.");
				$("#user_pw").focus();
				return false;
				}
			if ($("#user_name").val() == '') {
				alert("이름을 입력 하세요.");
				$("#user_name").focus();
				return false;
			}
			if(!nameCheck.test($("#user_name").val())){
				alert("이름을 정확히 입력 하세요.");
				$("#btn-email").focus();
				return false;
				}
			if(!email_check){
				alert("이메일 주소 인증 하세요");
				$("#user_email").focus();
				return false;
				}
			if ($("#postcode").val() == '') {
				alert("우편번호를 입력 하세요.");
				$("#btn-postcode").focus();
				return false;
			}
			if ($("#detailaddr").val() == '') {
				alert("주소를 입력 하세요.");
				$("#detailaddr").focus();
				return false;
			}
			if ($("#user_phonenum").val() == '') {
				alert("전화번호를 입력 하세요.");
				$("#user_phonenum").focus();
				return false;
			}
			if(!phoneCheck.test($("#user_phonenum").val())){
				alert("전화번호를 정확히 입력 하세요.");
				$("#user_phonenum").focus();
				return false;
				}
			form.submit();
		}
		
		$("#btn-join").on("click", function() {
			var form = $("form[role='join']");
			check(form);
		});
		
		$("form[role='join'] input").keydown(function(e) {
			if (e.keyCode == 13) {
				var form = $("form[role='join']");
				check(form);
			}
		});

		$("#user_email").on("change",function(){
			email_check = false;
			$("#btn-email").attr('class',"btn btn-primary");
			$("#btn-email").attr('value',"이메일 인증");
			});
		
		//메일 인증 버튼
		$("#btn-email").on("click",function(){
			var mailCheck = RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/);
			if ($("#user_email").val() == '') {
				alert("이메일을 입력 하세요.");
				$("#user_email").focus();
				return false;
			}
			if(!mailCheck.test($("#user_email").val())){
				alert("메일형식이 틀립니다.");
				$("#user_email").focus();
				return false;
				}
			$("div[role='mailCheck']").attr('style', "");

			$.ajax({
				url : "/user/mailCheck" ,
				type : "POST" ,
				data : {
						email : $("#user_email").val()
						},
				success : function(data){
					$("#btn-auth").on("click",function(){
						if(data == $("#user_auth").val()){
							alert("인증되었습니다.");
							$("div[role='mailCheck']").attr('style', "display: none;");
							$("#user_auth").val('Y');
							$("#btn-email").attr('class',"btn btn-success");
							$("#btn-email").attr('value',"인증 완료");
							$("#user_email").attr('readonly',true);
							email_check = true;
							}else{
							alert("인증번호를 정확히 입력하세요.");
							$("#user_auth").focus();
								}
						});
					}

				});
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

							<form action="/user/join" method="post" role="join"
								class="center-block">
								<div class="form-group">
									<label for="user_id">아이디</label>
									<div class="row" id="div_id">
										<div class="col-xs-5">
											<input type="text" name="user_id" id="user_id"
												class="form-control"
												placeholder="영어 소문자 , 숫자 , - , _  4~20자리">
										</div>
										<button type="button" id="btnIDCheck" class="btn btn-primary">ID
											중복 체크</button>
									</div>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">비밀번호</label>
									<div class="row">
										<div class="col-xs-5">
											<input type="password" id="user_pw" name="user_pw"
												placeholder=" 영어 대소문자  , 숫자  !  @  #  $  %  ^ &  *  8~20자리"
												class="form-control">
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">비밀번호 확인</label>
									<div class="row">
										<div class="col-xs-5">
											<input type="password" id="user_pw2" name="user_pw2"
												class="form-control">
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">이름</label>
									<div class="row">
										<div class="col-xs-5">
											<input type="text" name="user_name" id="user_name"
												class="form-control" placeholder="최대  15자리">
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">이메일</label>
									<div class="row">
										<div class="col-xs-5">
											<input type="text" name="user_email" id="user_email"
												class="form-control">
										</div>
										<input type="button" id="btn-email"
											value="이메일 인증" class="btn btn-primary">
									</div>
								</div>
								<div class="form-group" role="mailCheck" style="display: none;">
									<label for="exampleInputEmail1">인증번호</label>
									<div class="row">
										<div class="col-xs-5">
											<input type="text" name="user_auth" id="user_auth"
												class="form-control">
										</div>
											<input type="button" id="btn-auth"
												value="확인" class="btn btn-primary">
									</div>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">우편번호</label>
									<div class="row">
										<div class="col-xs-3">
											<input type="text" name="user_postcode" id="postcode"
												placeholder="우편번호" class="form-control" readonly="readonly">
										</div>
										<input type="button" onclick="sample2_execDaumPostcode()" id="btn-postcode"
											value="우편번호 찾기" class="btn btn-primary">
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1">주소</label>
										<div class="row">
											<div class="col-xs-10">
												<input type="text" name="user_address" id="addr"
													class="form-control" placeholder="주소" readonly="readonly">
											</div>
										</div>
									</div>
									<label for="exampleInputEmail1">상세주소</label>
									<div class="row">
										<div class="col-xs-5">
											<input type="text" name="user_detailaddr" id="detailaddr"
												class="form-control" placeholder="상세주소">
										</div>
										<div class="col-xs-5">
											<input type="text" name="extraAddress" id="extraAddress" class="form-control"
												placeholder="기타 주소" readonly="readonly">
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">전화번호 (-포함)</label>
									<div class="row">
										<div class="col-xs-5">
											<input type="text" name="user_phonenum" class="form-control"
												id="user_phonenum">
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">이메일 수신 여부</label> <br /> <input
										type="radio" name="user_mail_check" value="N"
										checked="checked"> NO <input type="radio"
										name="user_mail_check" value="Y"> YES
								</div>

								<!-- /.box-body -->

								<div class="box-footer text-center">
									<button type="button" class="btn btn-primary" id="btn-join">가입</button>
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
	<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

	function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("addr").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailaddr").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
</body>
</html>