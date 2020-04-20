<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="<c:url value="/resources/js/jquery-3.4.1.js/"/>"></script>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>화장실이 급할땐? - 부르르</title>
<!-- Favicon -->
<link href="<c:url value="/resources/assets/img/brand/favicon.png"/>" rel="icon" type="image/png">
<!-- Fonts -->
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
<!-- Icons -->
<link href="<c:url value="/resources/assets/js/plugins/nucleo/css/nucleo.css"/>" rel="stylesheet" />
<link href="<c:url value="/resources/assets/js/plugins/@fortawesome/fontawesome-free/css/all.min.css"/>" rel="stylesheet" />
<!-- CSS Files -->
<link href="<c:url value="/resources/assets/css/argon-dashboard.css?v=1.1.2"/>" rel="stylesheet" />
</head>

<body class="">
	<nav class="navbar navbar-vertical fixed-left navbar-expand-md navbar-light bg-white" id="sidenav-main">
		<div class="container-fluid">
			<!-- Toggler -->
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<!-- Brand -->
			<a class="navbar-brand pt-0" href="<c:url value="/maps/mapsMain"/>"> <img src="<c:url value="/resources/img/Logo.png"/>" class="navbar-brand-img" alt="...">
			</a>
			<!-- User -->
			<ul class="nav align-items-center d-md-none">
				<li class="nav-item dropdown"><a class="nav-link nav-link-icon" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="ni ni-bell-55"></i>
				</a>
					<div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right" aria-labelledby="navbar-default_dropdown_1">
						<a class="dropdown-item" href="#">Action</a> <a class="dropdown-item" href="#">Another action</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Something else here</a>
					</div></li>
				<li class="nav-item dropdown"><a class="nav-link" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<div class="media align-items-center">
							<span class="avatar avatar-sm rounded-circle"> <img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-1-800x800.jpg"/>">
							</span>
						</div>
				</a>
					<div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right">
						<div class=" dropdown-header noti-title">
							<h6 class="text-overflow m-0">Welcome!</h6>
						</div>
						<a href="<c:url value="/profile"/>" class="dropdown-item"> <i class="ni ni-single-02"></i> <span>My profile</span>
						</a> 
<%-- 						<a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-settings-gear-65"></i> <span>Settings</span> --%>
<%-- 						</a> <a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-calendar-grid-58"></i> <span>Activity</span> --%>
<%-- 						</a> <a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-support-16"></i> <span>Support</span> --%>
<!-- 						</a> -->
						<div class="dropdown-divider"></div>
						<a href="../member/logout" class="dropdown-item"> <i class="ni ni-user-run"></i> <span>Logout</span>
						</a>
					</div></li>
			</ul>
			<!-- Collapse -->
			<div class="collapse navbar-collapse" id="sidenav-collapse-main">
				<!-- Collapse header -->
				<div class="navbar-collapse-header d-md-none">
					<div class="row">
						<div class="col-6 collapse-brand">
							<a href="<c:url value="/examples/index"/>"> <img src="<c:url value="/resources/assets/img/brand/blue.png"/>">
							</a>
						</div>
						<div class="col-6 collapse-close">
							<button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle sidenav">
								<span></span> <span></span>
							</button>
						</div>
					</div>
				</div>
				<!-- Form -->
				<form class="mt-4 mb-3 d-md-none">
					<div class="input-group input-group-rounded input-group-merge">
						<input type="search" class="form-control form-control-rounded form-control-prepended" placeholder="Search" aria-label="Search">
						<div class="input-group-prepend">
							<div class="input-group-text">
								<span class="fa fa-search"></span>
							</div>
						</div>
					</div>
				</form>
				<!-- Navigation -->
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link  active " href="<c:url value="/maps/mapsMain"/>"> <i class="ni ni-pin-3 text-orange"></i> Maps
					</a></li>
					<li class="nav-item"><a class="nav-link " href="<c:url value="/examples/index"/>"> <i class="ni ni-tv-2 text-primary"></i> Board
					</a></li>
					<%-- <li class="nav-item  active "><a class="nav-link " href="<c:url value="/examples/index"/>">
							<i class="ni ni-tv-2 text-primary"></i> Dashboard
						</a></li> //nav-item  active는 무조건 검정색으로 표시됩니다. --%>
					<li class="nav-item"><a class="nav-link " href="<c:url value="/examples/icons"/>"> <i class="ni ni-planet text-blue"></i> Icons
					</a></li>

					<li class="nav-item"><a class="nav-link " href="<c:url value="/examples/tables"/>"> <i class="ni ni-bullet-list-67 text-red"></i> Tables
					</a></li>
					<c:if test="${sessionScope.sessionId == null }">
						<li class="nav-item"><a class="nav-link" href="<c:url value="/member/login"/>"> <i class="ni ni-key-25 text-info"></i> Login
						</a></li>
<%-- 						<li class="nav-item"><a class="nav-link" href="<c:url value="/examples/register"/>"> <i class="ni ni-circle-08 text-pink"></i> Sign up --%>
<!-- 						</a></li> -->
					</c:if>
					<c:if test="${sessionScope.sessionId != null }">
<%-- 						<li class="nav-item"><a class="nav-link " href="<c:url value="/examples/profile"/>"> <i class="ni ni-single-02 text-yellow"></i> User profile --%>
<!-- 						</a></li> -->
						<li class="nav-item"><a class="nav-link" href="<c:url value="logout"/>"> <i class="ni ni-key-25 text-info"></i> Logout
						</a></li>
						<!-- 네이버 로그인 시 -->
						<c:if test="${sessionScope.sessionNickname != null}">
					<li class="nav-item">
					<a class="nav-link " href="<c:url value="/deleteNaver"/>"> 
					<i class="ni ni-bullet-list-67 text-red"></i> 회원탈퇴
					</a></li>
					</c:if>
					<!-- 구글 로그인 시 -->
					<c:if test="${sessionScope.sessionNickname == null}">
					<li class="nav-item"><a class="nav-link " href="<c:url value="/deleteGoogle"/>"> <i class="ni ni-bullet-list-67 text-red"></i> 회원탈퇴
					</a></li>
						</c:if>
					</c:if>
				</ul>
				<!-- Divider -->
				<hr class="my-3">
				<!-- Heading -->
				<h6 class="navbar-heading text-muted">Documentation</h6>
				<!-- Navigation -->
				<ul class="navbar-nav mb-md-3">
					<li class="nav-item"><a class="nav-link" href="https://demos.creative-tim.com/argon-dashboard/docs/getting-started/overview.html"> <i class="ni ni-spaceship"></i> Getting started
					</a></li>
					<li class="nav-item"><a class="nav-link" href="https://demos.creative-tim.com/argon-dashboard/docs/foundation/colors.html"> <i class="ni ni-palette"></i> Foundation
					</a></li>
					<li class="nav-item"><a class="nav-link" href="https://demos.creative-tim.com/argon-dashboard/docs/components/alerts.html"> <i class="ni ni-ui-04"></i> Components
					</a></li>
				</ul>
				<ul class="navbar-nav">
					<li class="nav-item active active-pro"><a class="nav-link" href="<c:url value="/examples/upgrade"/>"> <i class="ni ni-send text-dark"></i> Upgrade to PRO
					</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="main-content">
		<!-- Navbar -->
		<nav class="navbar navbar-top navbar-expand-md navbar-dark" id="navbar-main">
			<div class="container-fluid">
				<!-- Brand -->
				<a class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block" href="<c:url value="/examples/index"/>">User Profile</a>
				<!-- Form -->
				<form class="navbar-search navbar-search-dark form-inline mr-3 d-none d-md-flex ml-lg-auto">
					<div class="form-group mb-0">
						<div class="input-group input-group-alternative">
							<div class="input-group-prepend">
								<span class="input-group-text"><i class="fas fa-search"></i></span>
							</div>
							<input class="form-control" placeholder="Search" type="text">
						</div>
					</div>
				</form>
				<!-- User -->
				<ul class="navbar-nav align-items-center d-none d-md-flex">
					<li class="nav-item dropdown"><a class="nav-link pr-0" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<div class="media align-items-center">
								<span class="avatar avatar-sm rounded-circle"> <img alt="Image placeholder" src="<c:url value="${sessionScope.Profile}"/>">
								</span>
								<div class="media-body ml-2 d-none d-lg-block">
									<span class="mb-0 text-sm  font-weight-bold">${sessionScope.sessionNickname}</span>
								</div>
							</div>
					</a>
						<div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right">
							<div class=" dropdown-header noti-title">
								<h6 class="text-overflow m-0">Welcome!</h6>
							</div>
<%-- 							<a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-single-02"></i> <span>My profile</span> --%>
<%-- 							</a> <a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-settings-gear-65"></i> <span>Settings</span> --%>
<%-- 							</a> <a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-calendar-grid-58"></i> <span>Activity</span> --%>
<%-- 							</a> <a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-support-16"></i> <span>Support</span> --%>
<!-- 							</a> -->
							<div class="dropdown-divider"></div>
							<a href="../logout" class="dropdown-item"> <i class="ni ni-user-run"></i> <span>Logout</span>
							</a>
						</div></li>
				</ul>
			</div>
		</nav>
		<!-- End Navbar -->
		<!-- Header -->
		<div class="header pb-8 pt-5 pt-lg-8 d-flex align-items-center" style="min-height: 600px; background-image: url(<c:url value="${sessionScope.Profile}"/>); background-size: cover; background-position: center top;">
			<!-- Mask -->
			<span class="mask bg-gradient-default opacity-8"></span>
			<!-- Header container -->
			<div class="container-fluid d-flex align-items-center">
				<div class="row">
					<div class="col-lg-7 col-md-10">
						<c:if test="${sessionScope.sessionNickname != null}">
						<h1 class="display-2 text-white">${sessionScope.sessionNickname}</h1>
						<p class="text-white mt-0 mb-5">${sessionScope.sessionNickname}님 brr를 이용해 주셔서 감사합니다.</p>
						</c:if>
						<c:if test="${sessionScope.sessionGooglename != null}">
						<h1 class="display-2 text-white">${sessionScope.sessionGooglename}</h1>
						<p class="text-white mt-0 mb-5">${sessionScope.sessionGooglename}님 brr를 이용해 주셔서 감사합니다.</p>
						</c:if>
<!-- 						<a href="#!" class="btn btn-info">Edit profile</a> -->
					</div>
				</div>
			</div>
		</div>
		<!-- Page content -->
		<div class="container-fluid mt--7">
			<div class="row">
				<div class="col-xl-4 order-xl-2 mb-5 mb-xl-0">
					<div class="card card-profile shadow">
						<div class="row justify-content-center">
							<div class="col-lg-3 order-lg-2">
								<div class="card-profile-image">
									<a href="#"> <img src="<c:url value="${sessionScope.Profile}"/>" class="rounded-circle">
									</a>
								</div>
							</div>
						</div>
						<div class="card-header text-center border-0 pt-8 pt-md-4 pb-0 pb-md-4">
							<div class="d-flex justify-content-between">
<!-- 								<a href="#" class="btn btn-sm btn-info mr-4">Connect</a> <a href="#" class="btn btn-sm btn-default float-right">Message</a> -->
							</div>
						</div>
						<div class="card-body pt-0 pt-md-4">
							<div class="row">
								<div class="col">
									<div class="card-profile-stats d-flex justify-content-center mt-md-5">
										<div>
											<span class="heading">22</span> <span class="description">Friends</span>
										</div>
										<div>
											<span class="heading">10</span> <span class="description">Photos</span>
										</div>
										<div>
											<span class="heading">89</span> <span class="description">Comments</span>
										</div>
									</div>
								</div>
							</div>
							<div class="text-center">
								<c:if test="${sessionScope.sessionNickname != null}">
								<h3>
									${sessionScope.sessionNickname}<span class="font-weight-light"></span>
								</h3>
								</c:if>
								<c:if test="${sessionScope.sessionGooglename != null}">
								<h3>
									${sessionScope.sessionGooglename}<span class="font-weight-light"></span>
								</h3>
								</c:if>
<!-- 								<div class="h5 font-weight-300"> -->
<!-- 									<i class="ni location_pin mr-2"></i>Bucharest, Romania -->
<!-- 								</div> -->
								<div class="h5 mt-4">
									<i class="ni business_briefcase-24 mr-2"></i>Solution Manager - Creative Tim Officer
								</div>
								<div>
									<i class="ni education_hat mr-2"></i>University of Computer Science
								</div>
								<hr class="my-4" />
								<p>Ryan — the name taken by Melbourne-raised, Brooklyn-based Nick Murphy — writes, performs and records all of his own music.</p>
								<a href="#">Show more</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col-xl-8 order-xl-1">
					<div class="card bg-secondary shadow">
						<div class="card-header bg-white border-0">
							<div class="row align-items-center">
								<div class="col-8">
									<h3 class="mb-0">My account</h3>
								</div>
								<div class="col-4 text-right">
<!-- 									<a href="#!" class="btn btn-sm btn-primary">Settings</a> -->
								</div>
							</div>
						</div>
						<div class="card-body">
							<form>
								<h6 class="heading-small text-muted mb-4">User information</h6>
								<div class="pl-lg-4">
									<div class="row">
										<div class="col-lg-6">
											<div class="form-group">
												<c:if test="${sessionScope.sessionNickname != null}">
												<label class="form-control-label" for="input-username">Username</label> <input type="text" id="input-username" class="form-control form-control-alternative" placeholder="Username" value="${sessionScope.sessionNickname}">
												</c:if>
												<c:if test="${sessionScope.sessionGooglename != null}">
												<label class="form-control-label" for="input-username">Username</label> <input type="text" id="input-username" class="form-control form-control-alternative" placeholder="Username" value="${sessionScope.sessionGooglename}">
												</c:if>
											</div>
										</div>
										<div class="col-lg-6">
											<div class="form-group">
												<label class="form-control-label" for="input-email">Email address</label> <input type="email" id="input-email" class="form-control form-control-alternative" placeholder="${sessionScope.sessionEmail}">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-6">
											<div class="form-group">
												<label class="form-control-label" for="input-first-name">First name</label> <input type="text" id="input-first-name" class="form-control form-control-alternative" placeholder="First name" value="Lucky">
											</div>
										</div>
										<div class="col-lg-6">
											<div class="form-group">
												<label class="form-control-label" for="input-last-name">Last name</label> <input type="text" id="input-last-name" class="form-control form-control-alternative" placeholder="Last name" value="Jesse">
											</div>
										</div>
									</div>
								</div>
								<hr class="my-4" />
								<!-- Address -->
								<h6 class="heading-small text-muted mb-4">Contact information</h6>
								<div class="pl-lg-4">
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="form-control-label" for="input-address">Address</label> <input id="input-address" class="form-control form-control-alternative" placeholder="Home Address" value="Bld Mihail Kogalniceanu, nr. 8 Bl 1, Sc 1, Ap 09" type="text">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-4">
											<div class="form-group">
												<label class="form-control-label" for="input-city">City</label> <input type="text" id="input-city" class="form-control form-control-alternative" placeholder="City" value="New York">
											</div>
										</div>
										<div class="col-lg-4">
											<div class="form-group">
												<label class="form-control-label" for="input-country">Country</label> <input type="text" id="input-country" class="form-control form-control-alternative" placeholder="Country" value="United States">
											</div>
										</div>
										<div class="col-lg-4">
											<div class="form-group">
												<label class="form-control-label" for="input-country">Postal code</label> <input type="number" id="input-postal-code" class="form-control form-control-alternative" placeholder="Postal code">
											</div>
										</div>
									</div>
								</div>
								<hr class="my-4" />
								<!-- Description -->
								<h6 class="heading-small text-muted mb-4">About me</h6>
								<div class="pl-lg-4">
									<div class="form-group">
										<label>About Me</label>
										<textarea rows="4" class="form-control form-control-alternative" placeholder="A few words about you ...">A beautiful Dashboard for Bootstrap 4. It is Free and Open Source.</textarea>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- Footer -->
			<footer class="footer">
				<div class="row align-items-center justify-content-xl-between">
					<div class="col-xl-6">
						<div class="copyright text-center text-xl-left text-muted">
							&copy; 2020 <a href="https://www.creative-tim.com" class="font-weight-bold ml-1" target="_blank">Creative Tim</a>
						</div>
					</div>
					<div class="col-xl-6">
						<ul class="nav nav-footer justify-content-center justify-content-xl-end">
							<li class="nav-item"><a href="https://www.creative-tim.com" class="nav-link" target="_blank">Creative Tim</a></li>
							<li class="nav-item"><a href="https://www.creative-tim.com/presentation" class="nav-link" target="_blank">About Us</a></li>
							<li class="nav-item"><a href="http://blog.creative-tim.com" class="nav-link" target="_blank">Blog</a></li>
							<li class="nav-item"><a href="https://github.com/creativetimofficial/argon-dashboard/blob/master/LICENSE.md" class="nav-link" target="_blank">MIT License</a></li>
						</ul>
					</div>
				</div>
			</footer>
		</div>
	</div>
	<!--   Core   -->
	<script src="<c:url value="/resources/assets/js/plugins/jquery/dist/jquery.min.js"/>"></script>
	<script src="<c:url value="/resources/assets/js/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"/>"></script>
	<!--   Optional JS   -->
	<!--   Argon JS   -->
	<script src="<c:url value="/resources/assets/js/argon-dashboard.min.js?v=1.1.2"/>"></script>
	<script src="https://cdn.trackjs.com/agent/v3/latest/t.js"></script>
	<script>
		window.TrackJS && TrackJS.install({
			token : "ee6fab19c5a04ac1a32a645abde4613a",
			application : "argon-dashboard-free"
		});
	</script>
</body>

</html>
tml>
