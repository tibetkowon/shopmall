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
			<li class="header">Category</li>
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
					<c:forEach items="${prt_cateCode }" var="prt_code">
					
						<li class="treeview" id="${prt_code.category_code}">
							<a href="#">
								<i class="fa fa-circle-o"></i>
									<span>${prt_code.category_name}</span>
									<span class="pull-right-container">
									 <i class="fa fa-angle-left pull-right"></i>
								</span>
							</a>
								<ul class="treeview-menu">
								</ul>
						</li>
					</c:forEach>
			<li class="header"></li>
			<li><a href="/FAQ/list"><i class="fa fa-circle-o text-yellow"></i> <span>FAQ</span></a></li>
		</ul>
		<!-- /.sidebar-menu -->
	</section>
	<!-- /.sidebar -->
</aside>