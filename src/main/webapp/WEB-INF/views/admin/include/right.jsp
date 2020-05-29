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
				<c:if test="${sessionScope.admin != null }">
					<h3 class="control-sidebar-heading">${sessionScope.admin.admin_id } / ${sessionScope.admin.admin_name }</h3>
					<ul class="control-sidebar-menu">
						<li>
								<div class="menu-info">
									<h4 class="control-sidebar-subheading">최근 접속일</h4>

									<p><fmt:formatDate value="${sessionScope.admin.last_date }" pattern="yyyy-MM-dd  hh:mm:ss" /></p>
								</div>
						</li>
						
					</ul>
					<ul class="control-sidebar-menu">
						<li>
							<a href="/admin/pw_modify">
									<span style="color: white;">비밀번호 수정</span>
							</a>
						</li>
					</ul>
					</c:if>
					<c:if test="${sessionScope.admin == null }"></c:if>
					
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