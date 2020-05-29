<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<header class="main-header">
	<!-- Logo -->
	<a href="/admin/" class="logo"> <span class="logo-mini"></span> <span
		class="logo-lg"> <b>Admin</b>
	</span>
	</a>

	<!-- Header Navbar -->
	<nav class="navbar navbar-static-top" role="navigation">
		<!-- Sidebar toggle button-->
		<a href="#" class="sidebar-toggle" data-toggle="push-menu"
			role="button"> <span class="sr-only">Toggle navigation</span>
		</a>
		<!-- Navbar Right Menu -->
		<div class="navbar-custom-menu">
			<form role="logout" method="post" action="/admin/logout"></form>
			<ul class="nav navbar-nav">

				<c:if test="${sessionScope.admin != null}">
					<li class="dropdown user user-menu" id="btnlogout">
						<a href="/admin/logout">
							<span class="hidden-xs" >로그아웃</span>
						</a>
					</li>
				</c:if>
				<c:if test="${sessionScope.admin == null}">
					<li class="dropdown user user-menu">
						<a href="/admin/login">
							<span class="hidden-xs">로그인</span>
						</a>
					</li>
				</c:if>
				
				<!-- Control Sidebar Toggle Button -->
				<li><a href="#" data-toggle="control-sidebar"><i
						class="fa fa-gears"></i></a></li>
			</ul>
		</div>
	</nav>
</header>