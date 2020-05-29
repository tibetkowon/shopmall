<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">

		<!-- Sidebar user panel (optional) -->
<!-- 		<div class="user-panel">
			<div class="pull-left image">
				<img src="/dist/img/user2-160x160.jpg" class="img-circle"
					alt="User Image">
			</div>
			<div class="pull-left info">
				<p>Alexander Pierce</p>
				Status
				<a href="#"> <i class="fa fa-circle text-success"></i> Online
				</a>
			</div>
		</div> -->

		<!-- search form (Optional) -->
		<!-- /.search form -->

		<!-- Sidebar Menu -->
		<ul class="sidebar-menu" data-widget="tree">
			<li class="header">MENU</li>
			<!-- <li class="active">
				<a href="#">
					<i class="fa fa-link"></i>
					<span>Link</span>
				</a>
			</li>
			<li>
				<a href="#">
					<i class="fa fa-link"></i>
					<span>Another Link</span>
				</a>
			</li> -->
			<c:if test="${sessionScope.admin != null }">
			
					
					
					<li class="treeview">
						<a href="#">
							<i class="fa fa-circle-o text-yellow"></i>
								<span>상품 관리</span>
								<span class="pull-right-container">
								 <i class="fa fa-angle-left pull-right"></i>
							</span>
						</a>
							<ul class="treeview-menu">
								<li><a href="/admin/product/insert">상품 등록</a></li>
								<li><a href="/admin/product/list">상품 목록</a></li>								
							</ul>
					</li>
					
					<li>
					<a href="/admin/category/list"><i class="fa fa-certificate"></i><span>카테고리 관리
					</span></a>
					</li>								
					<li>
						<a href="/admin/user/list"><i class="fa fa-users"></i><span>회원 관리</span></a>
					</li>
					<li>
						<a href="/admin/order/list"><i class="fa fa-shopping-cart"></i><span>주문 관리</span></a>
					</li>
					<li class="header">
						문의 관련
					</li>
					<li>
						<a href="/admin/product/QnA"><i class="fa  fa-question text-red"></i><span>상품 문의</span></a>
					</li>
					<li>
						<a href="/admin/FAQ/list"><i class="fa  fa-question text-yellow"></i><span>FAQ</span></a>
					</li>
					
					<!-- <li class="treeview">
						<a href="#">
							<i class="fa fa-link"></i>
								<span>주문 관리</span>
								<span class="pull-right-container">
								 <i class="fa fa-angle-left pull-right"></i>
							</span>
						</a>
							<ul class="treeview-menu">
								<li><a href="/admin/order/list">주문 목록</a></li>
								<li><a href="#">주문 수정</a></li>
							</ul>
					</li> -->
			</c:if>

		</ul>
		<!-- /.sidebar-menu -->
	</section>
	<!-- /.sidebar -->
</aside>