<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Create the tabs -->
			<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
				<li class="active">
				</li>
			</ul>
			<!-- Tab panes -->
			<div class="tab-content">
				<!-- Home tab content -->
				<div class="tab-pane active" id="control-sidebar-home-tab">
				<c:if test="${sessionScope.userVO != null }">
					<h3 class="control-sidebar-heading">${sessionScope.userVO.user_name }</h3>
					<ul class="control-sidebar-menu">
						<li>						
							<div class="menu-info">
								<h4 class="control-sidebar-subheading">기타회원 정보</h4>
								<p>가입 날짜 : <fmt:formatDate value="${sessionScope.userVO.user_createdate }" pattern="yyyy-MM-dd" /> </p>
								<p>포인트 : ${sessionScope.userVO.user_point } 점</p>
								<p>이메일 수신 여부 :${sessionScope.usreVO.user_mail_check eq "Y" ? "예":"아니요" } </p>
							</div>
						</li>
					</ul>
					<ul class="control-sidebar-menu">
						<li>
							<a href="/user/modify/${sessionScope.userVO.user_id }">
									<span style="color: white;">회원 정보 수정</span>
							</a>
						</li>
						<li>
							<a href="/user/pw_modify">
									<span style="color: white;">비밀번호 변경</span>
							</a>
						</li>
						<li>
							<a href="/user/userDelete">
									<span style="color: white;">회원 탈퇴</span>
							</a>
						</li>
					</ul>
					</c:if>
					<c:if test="${sessionScope.userVO == null }"></c:if>
					
					<!-- /.control-sidebar-menu -->


					<!-- /.control-sidebar-menu -->

				</div>
				<!-- /.tab-pane -->
				<!-- Stats tab content -->
				<!-- /.tab-pane -->
			</div>
		</aside>
		<!-- /.control-sidebar -->
		<!-- Add the sidebar's background. This div must be placed immediately after the control sidebar -->
		<div class="control-sidebar-bg"></div>