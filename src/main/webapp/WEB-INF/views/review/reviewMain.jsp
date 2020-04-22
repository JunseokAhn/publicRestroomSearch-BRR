<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<script src="<c:url value="/resources/js/jquery-3.4.1.js/"/>"></script>
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
<link href="<c:url value="/resources/css/boardStyle.css"/>" rel="stylesheet" />
<link href="<c:url value="/resources/assets/css/argon-dashboard.css?v=1.1.2"/>" rel="stylesheet" />
</head>

<body class="">
	<!-- 네비게이션[S] -->
	<div id="feedback-container"></div>
	<div id="feedback" class="col-xl-4">
		<form action="">
			<div class="card shadow">
				<div class="card-header bg-transparent">
					<div class="row align-items-center">
						<div class="col">
							<h2 class="mb-0" style="display: inline-block">Feedback Send</h2>
							<input id="x-button" name="feed-x-button" class="btn btn-sm btn-primary" value="X" onclick='$("#feedback").hide(), $("#feedback-container").fadeOut()'> <input id="register" name="feedback-send" class="btn btn-sm btn-primary" type="button" value="Send Feedback" onclick="SendFeedback()">
							<h6 id="review-ment" class="text-uppercase text-muted ls-1 mb-1">사용자님의 의견을 적어주세요! 적극 반영하겠습니다.</h6>
						</div>
					</div>
				</div>

				<div class="card-body2">
					<div class="col-xl-12 col-lg-6">
						<div class="card card-stats mb-4 mb-xl-0">
							<textarea class="card-body4 replyButton2" id="feedback-contents" onkeydown="resize(this)" onkeyup="resize(this)" style="resize: none;"></textarea>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>


	<nav class="navbar navbar-vertical fixed-left navbar-expand-md navbar-light bg-white" id="sidenav-main">
		<div class="container-fluid">
			<!-- Toggler -->
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<!-- Brand -->
			<a class="navbar-brand pt-0 pb-0" href="<c:url value="/maps/mapsMain"/>">
				<img src="<c:url value="/resources/img/Logo.png"/>" class="navbar-brand-img" alt="...">
			</a>
			<!-- User -->
			<ul class="nav align-items-center d-md-none">
				<li class="nav-item dropdown"><a class="nav-link nav-link-icon" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="ni ni-bell-55"></i>
					</a>
					<div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right" aria-labelledby="navbar-default_dropdown_1">
						<a class="dropdown-item" href="#">Action</a>
						<a class="dropdown-item" href="#">Another action</a>
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
						<a href="<c:url value="/examples/profile"/>" class="dropdown-item">
							<i class="ni ni-single-02"></i> <span>My profile</span>
						</a>
						<a href="<c:url value="/examples/profile"/>" class="dropdown-item">
							<i class="ni ni-settings-gear-65"></i> <span>Settings</span>
						</a>
						<a href="<c:url value="/examples/profile"/>" class="dropdown-item">
							<i class="ni ni-calendar-grid-58"></i> <span>Activity</span>
						</a>
						<a href="<c:url value="/examples/profile"/>" class="dropdown-item">
							<i class="ni ni-support-16"></i> <span>Support</span>
						</a>
						<div class="dropdown-divider"></div>
						<a href="#!" class="dropdown-item">
							<i class="ni ni-user-run"></i> <span>Logout</span>
						</a>
					</div></li>
			</ul>

			<!-- Collapse -->
			<div class="collapse navbar-collapse" id="sidenav-collapse-main">
				<!-- Collapse header -->
				<div class="navbar-collapse-header d-md-none">
					<div class="row">
						<div class="col-6 collapse-brand">
							<a href="<c:url value="/maps/mapsMain"/>">
								<img src="<c:url value="/resources/img/Logo.png"/>">
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
					<li class="nav-item"><a class="nav-link  active " href="<c:url value="/maps/mapsMain"/>">
							<i class="ni ni-pin-3 text-orange"></i> Maps
						</a></li>
					<li class="nav-item"><a class="nav-link " href="<c:url value="/sns/listSNS"/>">
							<i class="ni ni-tv-2 text-primary"></i> SNS
						</a></li>
					<%-- <li class="nav-item  active "><a class="nav-link " href="<c:url value="/examples/index"/>">
							<i class="ni ni-tv-2 text-primary"></i> Dashboard
						</a></li> //nav-item  active는 무조건 검정색으로 표시됩니다. 
					
						<%-- <li class="nav-item"><a class="icon icon-shape bg-danger text-white rounded-circle shadow" href="<c:url value="/diary/diaryMain"/>">
							<i class="fas fa-chart-bar"></i> Diary				
						</li>	
					 --%>
					<li class="nav-item"><a class="nav-link " href="<c:url value="/diary/diaryMain"/>">
							<i class="ni ni-bullet-list-67 text-red"></i> Diary
						</a></li>

					<!-- 로그인 영역 -->

					<c:if test="${sessionScope.sessionId == null }">
						<li class="nav-item"><a class="nav-link" href="<c:url value="/member/login"/>">
								<i class="ni ni-key-25 text-info"></i> Login
							</a></li>
						<li class="nav-item"><a class="nav-link " href="<c:url value="/member/profile"/>">
								<i class="ni ni-single-02 text-gray-dark"></i> User profile
							</a></li>
					</c:if>

					<c:if test="${sessionScope.sessionId != null }">
						<li class="nav-item"><a class="nav-link " href="<c:url value="/member/profile"/>">
								<i class="ni ni-single-02 text-gray-dark"></i> User profile
							</a></li>
						<li class="nav-item"><a class="nav-link" href="<c:url value="/member/logout"/>">
								<i class="ni ni-key-25 text-info"></i> Logout
							</a></li>
						<!-- 						네이버 로그인 시 -->
						<%-- 						<c:if test="${sessionScope.sessionNaver != null}"> --%>
						<%-- 							<li class="nav-item"><a class="nav-link " href="<c:url value="/member/deleteNaver"/>"> --%>
						<!-- 									<i class="ni ni-bullet-list-67 text-red"></i> Naver탈퇴 -->
						<!-- 								</a></li> -->
						<%-- 						</c:if> --%>
						<!-- 						구글 로그인 시 -->
						<%-- 						<c:if test="${sessionScope.sessionNaver == null}"> --%>
						<%-- 							<li class="nav-item"><a class="nav-link " href="<c:url value="/member/deleteGoogle"/>"> --%>
						<!-- 									<i class="ni ni-bullet-list-67 text-red"></i> Google탈퇴 -->
						<!-- 								</a></li> -->
						<%-- 						</c:if> --%>
					</c:if>
				</ul>
				<!-- Divider -->
				<hr class="my-3">
				<!-- Heading -->
				<h6 class="navbar-heading text-muted">NEED LOGIN</h6>
				<!-- Navigation -->
				<ul class="navbar-nav mb-md-3">
					<li class="nav-item"><a class="nav-link" href="https://demos.creative-tim.com/argon-dashboard/docs/foundation/colors.html">
							<i class="ni ni-watch-time text-indigo"></i> <span>Recent toilet</span>
						</a></li>
					<li class="nav-item"><a class="nav-link" href="https://www.op.gg/champion/maokai/statistics/top">
							<i class="ni ni-favourite-28 text-pink"></i> <span>Preferred toilet</span>
						</a></li>

					<li class="nav-item"><a class="nav-link" href="javascript:FeedbackShow();">
							<i class="ni ni-send text-blue"></i> <span>Send Feedback</span>
						</a></li>

					<li class="nav-item"><br> <br>
						<div id="openweathermap-widget-18"></div> <script>
                            /* window.myWidgetParam ? window.myWidgetParam : window.myWidgetParam = []; 
                            window.myWidgetParam.push({id: 18,cityid: '1835848',appid: 'c08b376c4c1ca3b5e593c4991d91eb3c',
                            units: 'metric',containerid: 'openweathermap-widget-18',  });  
                            (function() {var script = document.createElement('script');script.async = true;script.charset = "utf-8";
                            script.src = "//openweathermap.org/themes/openweathermap/assets/vendor/owm/js/weather-widget-generator.js";
                            var s = document.getElementsByTagName('script')[0];s.parentNode.insertBefore(script, s);  })(); */
                        </script></li>

				</ul>
				<ul class="navbar-nav">
					<li class="nav-item active active-pro"><a class="nav-link" href="<c:url value="/maps/mapsMain2"/>">
							<i class="ni ni-bus-front-12"></i> Google Maps (Beta)
						</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- 네비게이션[E] -->
	<div class="main-content">
		<!-- Navbar -->
		<nav class="navbar navbar-top navbar-expand-md navbar-dark" id="navbar-main">
			<div class="container-fluid">
				<!-- Brand -->
				<a class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block" href="<c:url value="/review/reviewMain"/>">Reviews</a>
				<!-- Form -->
				<form class="navbar-search navbar-search-dark form-inline mr-3 d-none d-md-flex ml-lg-auto">
					<div class="form-group mb-0">
						<div class="input-group input-group-alternative">
							<div class="input-group-prepend">
								<span class="input-group-text"><i class="fas fa-search"></i></span>
							</div>
							<input class="form-control" placeholder="Search Review" type="text">
						</div>
					</div>
				</form>
				<!-- User -->
				<ul class="navbar-nav align-items-center d-none d-md-flex">
					<li class="nav-item dropdown"><a class="nav-link pr-0" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<div class="media align-items-center">
								<!-- 회원 네비게이터 영역 -->
								<c:if test="${sessionScope.sessionId == null}">
									<span class="avatar avatar-sm rounded-circle"> <img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-4-800x800.jpg"/>">
									</span>
									<div class="media-body ml-2 d-none d-lg-block">
										<span class="mb-0 text-sm  font-weight-bold">로그인을 해 주세요.</span>
									</div>
								</c:if>

								<c:if test="${sessionScope.sessionId != null}">
									<span class="avatar avatar-sm rounded-circle"> <img alt="Image placeholder" src="<c:url value="${sessionScope.sessionProfile}"/>">
									</span>
									<div class="media-body ml-2 d-none d-lg-block">
										<span class="mb-0 text-sm  font-weight-bold">${sessionScope.sessionEmail}</span>
									</div>
								</c:if>
							</div>
						</a>
						<div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right">
							<div class=" dropdown-header noti-title">
								<h6 class="text-overflow m-0">Welcome!</h6>
							</div>

							<c:if test="${sessionScope.sessionId == null}">
								<div class="dropdown-divider"></div>
								<a href="<c:url value="/member/login"/>" class="dropdown-item">
									<i class="ni ni-user-run"></i> <span>Login</span>
								</a>
							</c:if>

							<c:if test="${sessionScope.sessionId != null}">
								<a href="<c:url value="/member/profile"/>" class="dropdown-item">
									<i class="ni ni-single-02"></i> <span>My profile</span>
								</a>
								<div class="dropdown-divider"></div>
								<a href="<c:url value="/member/logout"/>" class="dropdown-item">
									<i class="ni ni-user-run"></i> <span>Logout</span>
								</a>
							</c:if>
						</div></li>
				</ul>
			</div>
		</nav>
		<!-- End Navbar -->
		<!-- Header -->
		<div class="header bg-gradient-primary pb-8 pt-5 pt-md-8">
			<div class="container-fluid">
				<div class="header-body"></div>
			</div>
		</div>
		<div class="container-fluid mt--7">
			<!-- Dark table -->
			<div class="row">
				<div class="col">
					<div class="card bg-default shadow">
						<div class="card-header bg-transparent border-0">
							<c:if test="${search==''}">
								<h3 class="text-white mb-0">All reviews</h3>
							</c:if>
							<c:if test="${search!=''}">
								<h3 class="text-white mb-0">검색어 : ${search}</h3>
							</c:if>

						</div>
						<div class="table-responsive">
							<table id="dark-table" class="table align-items-center table-dark table-flush">
								<thead class="thead-dark">
									<tr>
										<th scope="col">Toilet Title</th>
										<th scope="col">contents</th>
										<th scope="col">User</th>
										<th scope="col">Star</th>
										<th scope="col">Clean</th>
										<th scope="col">Date</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th scope="row">
											<div class="media align-items-center">
												<div class="media-body">
													<c:if test="${list[0]==null}">
														<span class="mb-0 text-sm"></span>
													</c:if>
													<c:if test="${list[0]!=null}">
														<span class="mb-0 text-sm">${list[0].toilet_title }</span>
													</c:if>
												</div>
											</div>
										</th>
										<c:if test="${list[0]==null}">
											<td>당신의 리뷰를 들려주세요</td>
										</c:if>
										<c:if test="${list[0]!=null}">
											<td>${list[0].review}</td>
										</c:if>
										<c:if test="${list[0]==null}">
											<td><span class="avatar avatar-sm"><img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-1-800x800.jpg"/>" class="rounded-circle"></span>Crispy Donut</td>
										</c:if>
										<c:if test="${list[0]!=null}">
											<td><span class="avatar avatar-sm"> <img src="${list[0].profile}"></span>${list[0].sessionNickname}</td>
										</c:if>
										<c:if test="${list[0]==null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="5">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[0]!=null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="${list[0].star }">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[0]==null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="5">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[0]!=null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="${list[0].clean }">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[0]==null}">
											<td>
												<div class="avatar-group">2020/04/29</div>
											</td>
										</c:if>
										<c:if test="${list[0]!=null}">
											<td>
												<div class="avatar-group">${list[0].inputdate }</div>
											</td>
										</c:if>
									</tr>
									<tr>
										<th scope="row">
											<div class="media align-items-center">
												<div class="media-body">
													<c:if test="${list[1]==null}">
														<span class="mb-0 text-sm"></span>
													</c:if>
													<c:if test="${list[1]!=null}">
														<span class="mb-0 text-sm">${list[1].toilet_title }</span>
													</c:if>
												</div>
											</div>
										</th>
										<c:if test="${list[1]==null}">
											<td>당신의 리뷰를 들려주세요</td>
										</c:if>
										<c:if test="${list[1]!=null}">
											<td>${list[1].review}</td>
										</c:if>
										<c:if test="${list[1]==null}">
											<td><span class="avatar avatar-sm"><img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-1-800x800.jpg"/>" class="rounded-circle"></span>Crispy Donut</td>
										</c:if>
										<c:if test="${list[1]!=null}">
											<td><span class="avatar avatar-sm"> <img src="${list[1].profile}"></span>${list[1].sessionNickname}</td>
										</c:if>
										<c:if test="${list[1]==null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="5">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[1]!=null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="${list[1].star }">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[1]==null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="5">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[1]!=null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="${list[1].clean }">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[1]==null}">
											<td>
												<div class="avatar-group">2020/04/29</div>
											</td>
										</c:if>
										<c:if test="${list[1]!=null}">
											<td>
												<div class="avatar-group">${list[1].inputdate }</div>
											</td>
										</c:if>
									</tr>
									<tr>
										<th scope="row">
											<div class="media align-items-center">
												<div class="media-body">
													<c:if test="${list[2]==null}">
														<span class="mb-0 text-sm"></span>
													</c:if>
													<c:if test="${list[2]!=null}">
														<span class="mb-0 text-sm">${list[2].toilet_title }</span>
													</c:if>
												</div>
											</div>
										</th>
										<c:if test="${list[2]==null}">
											<td>당신의 리뷰를 들려주세요</td>
										</c:if>
										<c:if test="${list[2]!=null}">
											<td>${list[2].review}</td>
										</c:if>
										<c:if test="${list[2]==null}">
											<td><span class="avatar avatar-sm"><img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-1-800x800.jpg"/>" class="rounded-circle"></span>Crispy Donut</td>
										</c:if>
										<c:if test="${list[2]!=null}">
											<td><span class="avatar avatar-sm"> <img src="${list[2].profile}"></span>${list[2].sessionNickname}</td>
										</c:if>
										<c:if test="${list[2]==null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="5">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[2]!=null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="${list[2].star }">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[2]==null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="5">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[2]!=null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="${list[2].clean }">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[2]==null}">
											<td>
												<div class="avatar-group">2020/04/29</div>
											</td>
										</c:if>
										<c:if test="${list[2]!=null}">
											<td>
												<div class="avatar-group">${list[2].inputdate }</div>
											</td>
										</c:if>
									</tr>
									<tr>
										<th scope="row">
											<div class="media align-items-center">
												<div class="media-body">
													<c:if test="${list[3]==null}">
														<span class="mb-0 text-sm"></span>
													</c:if>
													<c:if test="${list[3]!=null}">
														<span class="mb-0 text-sm">${list[3].toilet_title }</span>
													</c:if>
												</div>
											</div>
										</th>
										<c:if test="${list[3]==null}">
											<td>당신의 리뷰를 들려주세요</td>
										</c:if>
										<c:if test="${list[3]!=null}">
											<td>${list[3].review}</td>
										</c:if>
										<c:if test="${list[3]==null}">
											<td><span class="avatar avatar-sm"><img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-1-800x800.jpg"/>" class="rounded-circle"></span>Crispy Donut</td>
										</c:if>
										<c:if test="${list[3]!=null}">
											<td><span class="avatar avatar-sm"> <img src="${list[3].profile}"></span>${list[3].sessionNickname}</td>
										</c:if>
										<c:if test="${list[3]==null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="5">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[3]!=null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="${list[3].star }">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[3]==null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="5">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[3]!=null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="${list[3].clean }">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[3]==null}">
											<td>
												<div class="avatar-group">2020/04/29</div>
											</td>
										</c:if>
										<c:if test="${list[3]!=null}">
											<td>
												<div class="avatar-group">${list[3].inputdate }</div>
											</td>
										</c:if>
									</tr>
									<tr>
										<th scope="row">
											<div class="media align-items-center">
												<div class="media-body">
													<c:if test="${list[4]==null}">
														<span class="mb-0 text-sm"></span>
													</c:if>
													<c:if test="${list[4]!=null}">
														<span class="mb-0 text-sm">${list[4].toilet_title }</span>
													</c:if>
												</div>
											</div>
										</th>
										<c:if test="${list[4]==null}">
											<td>당신의 리뷰를 들려주세요</td>
										</c:if>
										<c:if test="${list[4]!=null}">
											<td>${list[4].review}</td>
										</c:if>
										<c:if test="${list[4]==null}">
											<td><span class="avatar avatar-sm"><img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-1-800x800.jpg"/>" class="rounded-circle"></span>Crispy Donut</td>
										</c:if>
										<c:if test="${list[4]!=null}">
											<td><span class="avatar avatar-sm"> <img src="${list[4].profile}"></span>${list[4].sessionNickname}</td>
										</c:if>
										<c:if test="${list[4]==null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="5">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[4]!=null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="${list[4].star }">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[4]==null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="5">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[4]!=null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="${list[4].clean }">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[4]==null}">
											<td>
												<div class="avatar-group">2020/04/29</div>
											</td>
										</c:if>
										<c:if test="${list[4]!=null}">
											<td>
												<div class="avatar-group">${list[4].inputdate }</div>
											</td>
										</c:if>
									</tr>
									<tr>
										<th scope="row">
											<div class="media align-items-center">
												<div class="media-body">
													<c:if test="${list[5]==null}">
														<span class="mb-0 text-sm"></span>
													</c:if>
													<c:if test="${list[5]!=null}">
														<span class="mb-0 text-sm">${list[5].toilet_title }</span>
													</c:if>
												</div>
											</div>
										</th>
										<c:if test="${list[5]==null}">
											<td>당신의 리뷰를 들려주세요</td>
										</c:if>
										<c:if test="${list[5]!=null}">
											<td>${list[5].review}</td>
										</c:if>
										<c:if test="${list[5]==null}">
											<td><span class="avatar avatar-sm"><img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-1-800x800.jpg"/>" class="rounded-circle"></span>Crispy Donut</td>
										</c:if>
										<c:if test="${list[5]!=null}">
											<td><span class="avatar avatar-sm"> <img src="${list[5].profile}"></span>${list[5].sessionNickname}</td>
										</c:if>
										<c:if test="${list[5]==null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="5">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[5]!=null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="${list[5].star }">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[5]==null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="5">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[5]!=null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="${list[5].clean }">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[5]==null}">
											<td>
												<div class="avatar-group">2020/04/29</div>
											</td>
										</c:if>
										<c:if test="${list[5]!=null}">
											<td>
												<div class="avatar-group">${list[5].inputdate }</div>
											</td>
										</c:if>
									</tr>
									<tr>
										<th scope="row">
											<div class="media align-items-center">
												<div class="media-body">
													<c:if test="${list[6]==null}">
														<span class="mb-0 text-sm"></span>
													</c:if>
													<c:if test="${list[6]!=null}">
														<span class="mb-0 text-sm">${list[6].toilet_title }</span>
													</c:if>
												</div>
											</div>
										</th>
										<c:if test="${list[6]==null}">
											<td>당신의 리뷰를 들려주세요</td>
										</c:if>
										<c:if test="${list[6]!=null}">
											<td>${list[6].review}</td>
										</c:if>
										<c:if test="${list[6]==null}">
											<td><span class="avatar avatar-sm"><img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-1-800x800.jpg"/>" class="rounded-circle"></span>Crispy Donut</td>
										</c:if>
										<c:if test="${list[6]!=null}">
											<td><span class="avatar avatar-sm"> <img src="${list[6].profile}"></span>${list[6].sessionNickname}</td>
										</c:if>
										<c:if test="${list[6]==null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="5">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[6]!=null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="${list[6].star }">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[6]==null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="5">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[6]!=null}">
											<td>
												<div class="avatar-group">
													<c:forEach begin="1" end="${list[6].clean }">
														<span class="avatar avatar-sm"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle"></span>
													</c:forEach>
												</div>
											</td>
										</c:if>
										<c:if test="${list[6]==null}">
											<td>
												<div class="avatar-group">2020/04/29</div>
											</td>
										</c:if>
										<c:if test="${list[6]!=null}">
											<td>
												<div class="avatar-group">${list[6].inputdate }</div>
											</td>
										</c:if>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="card-footer py-4 card bg-default shadow">
							<nav aria-label="...">
								<ul class="pagination justify-content-end mb-0">
									<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">
											<i class="fas fa-angle-left"></i> <span class="sr-only">Previous</span>
										</a></li>
									<li class="page-item active"><a class="page-link" href="#">1</a></li>
									<li class="page-item"><a class="page-link" href="#">
											2 <span class="sr-only">(current)</span>
										</a></li>
									<li class="page-item"><a class="page-link" href="#">3</a></li>
									<li class="page-item"><a class="page-link" href="#">
											<i class="fas fa-angle-right"></i> <span class="sr-only">Next</span>
										</a></li>
								</ul>
							</nav>
						</div>
					</div>
				</div>
			</div>
			<!-- Table -->
			<%-- 	<div class="row mt-5">
				<div class="col">
					<div class="card shadow">
						<div class="card-header border-0">
							<h3 class="mb-0">All reviews</h3>
						</div>
						<div class="table-responsive">
							<table class="table align-items-center table-flush">
								<thead class="thead-light">
									<tr>
										<th scope="col">Toilet Title</th>
										<th scope="col">contents</th>
										<th scope="col">User</th>
										<th scope="col">Star</th>
										<th scope="col">Clean</th>
										<th scope="col">date</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th scope="row">
											<div class="media align-items-center">
												<div class="media-body">
													<span class="mb-0 text-sm">화장실이름</span>
												</div>
											</div>
										</th>
										<td>내용내용내용내용내용내용내용내용내용내용내용내용내용내용</td>
										<td><span class="avatar avatar-sm rounded-circle"> <img src="${sessionScope.Profile}">
										</span>닉네임</td>
										<td>
											<div class="avatar-group">
												<img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="stars ml-0"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="stars ml-0"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="stars ml-0"> <img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="stars ml-0">
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Romina Hadid">
													<img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Alexander Smith">
													<img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Jessica Doe">
													<img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Jessica Doe">
													<img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle">
												</a>
											</div>
										</td>
										<td>
											<div class="avatar-group">
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Ryan Tompson">
													<img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Romina Hadid">
													<img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Alexander Smith">
													<img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Jessica Doe">
													<img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Jessica Doe">
													<img alt="Image placeholder" src="<c:url value='/resources/img/starOn.png'/>" class="rounded-circle">
												</a>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<div class="media align-items-center">
												<a href="#" class="avatar rounded-circle mr-3">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/angular.jpg"/>">
												</a>
												<div class="media-body">
													<span class="mb-0 text-sm">Angular Now UI Kit PRO</span>
												</div>
											</div>
										</th>
										<td>$1,800 USD</td>
										<td><span class="badge badge-dot"> <i class="bg-success"></i> completed
										</span></td>
										<td>
											<div class="avatar-group">
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Ryan Tompson">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-1-800x800.jpg"/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Romina Hadid">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-2-800x800.jpg"/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Alexander Smith">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-3-800x800.jpg"/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Jessica Doe">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-4-800x800.jpg"/>" class="rounded-circle">
												</a>
											</div>
										</td>
										<td>
											<div class="d-flex align-items-center">
												<span class="mr-2">100%</span>
												<div>
													<div class="progress">
														<div class="progress-bar bg-success" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%;"></div>
													</div>
												</div>
											</div>
										</td>
										<td class="text-right">
											<div class="dropdown">
												<a class="btn btn-sm btn-icon-only text-light" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
													<i class="fas fa-ellipsis-v"></i>
												</a>
												<div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
													<a class="dropdown-item" href="#">Action</a>
													<a class="dropdown-item" href="#">Another action</a>
													<a class="dropdown-item" href="#">Something else here</a>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<div class="media align-items-center">
												<a href="#" class="avatar rounded-circle mr-3">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/sketch.jpg"/>">
												</a>
												<div class="media-body">
													<span class="mb-0 text-sm">Black Dashboard</span>
												</div>
											</div>
										</th>
										<td>$3,150 USD</td>
										<td><span class="badge badge-dot mr-4"> <i class="bg-danger"></i> delayed
										</span></td>
										<td>
											<div class="avatar-group">
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Ryan Tompson">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-1-800x800.jpg"/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Romina Hadid">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-2-800x800.jpg"/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Alexander Smith">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-3-800x800.jpg"/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Jessica Doe">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-4-800x800.jpg"/>" class="rounded-circle">
												</a>
											</div>
										</td>
										<td>
											<div class="d-flex align-items-center">
												<span class="mr-2">72%</span>
												<div>
													<div class="progress">
														<div class="progress-bar bg-danger" role="progressbar" aria-valuenow="72" aria-valuemin="0" aria-valuemax="100" style="width: 72%;"></div>
													</div>
												</div>
											</div>
										</td>
										<td class="text-right">
											<div class="dropdown">
												<a class="btn btn-sm btn-icon-only text-light" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
													<i class="fas fa-ellipsis-v"></i>
												</a>
												<div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
													<a class="dropdown-item" href="#">Action</a>
													<a class="dropdown-item" href="#">Another action</a>
													<a class="dropdown-item" href="#">Something else here</a>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<div class="media align-items-center">
												<a href="#" class="avatar rounded-circle mr-3">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/react.jpg"/>">
												</a>
												<div class="media-body">
													<span class="mb-0 text-sm">React Material Dashboard</span>
												</div>
											</div>
										</th>
										<td>$4,400 USD</td>
										<td><span class="badge badge-dot"> <i class="bg-info"></i> on schedule
										</span></td>
										<td>
											<div class="avatar-group">
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Ryan Tompson">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-1-800x800.jpg"/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Romina Hadid">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-2-800x800.jpg"/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Alexander Smith">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-3-800x800.jpg"/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Jessica Doe">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-4-800x800.jpg"/>" class="rounded-circle">
												</a>
											</div>
										</td>
										<td>
											<div class="d-flex align-items-center">
												<span class="mr-2">90%</span>
												<div>
													<div class="progress">
														<div class="progress-bar bg-info" role="progressbar" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100" style="width: 90%;"></div>
													</div>
												</div>
											</div>
										</td>
										<td class="text-right">
											<div class="dropdown">
												<a class="btn btn-sm btn-icon-only text-light" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
													<i class="fas fa-ellipsis-v"></i>
												</a>
												<div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
													<a class="dropdown-item" href="#">Action</a>
													<a class="dropdown-item" href="#">Another action</a>
													<a class="dropdown-item" href="#">Something else here</a>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<div class="media align-items-center">
												<a href="#" class="avatar rounded-circle mr-3">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/vue.jpg"/>">
												</a>
												<div class="media-body">
													<span class="mb-0 text-sm">Vue Paper UI Kit PRO</span>
												</div>
											</div>
										</th>
										<td>$2,200 USD</td>
										<td><span class="badge badge-dot mr-4"> <i class="bg-success"></i> completed
										</span></td>
										<td>
											<div class="avatar-group">
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Ryan Tompson">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-1-800x800.jpg"/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Romina Hadid">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-2-800x800.jpg"/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Alexander Smith">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-3-800x800.jpg"/>" class="rounded-circle">
												</a>
												<a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Jessica Doe">
													<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-4-800x800.jpg"/>" class="rounded-circle">
												</a>
											</div>
										</td>
										<td>
											<div class="d-flex align-items-center">
												<span class="mr-2">100%</span>
												<div>
													<div class="progress">
														<div class="progress-bar bg-success" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%;"></div>
													</div>
												</div>
											</div>
										</td>
										<td class="text-right">
											<div class="dropdown">
												<a class="btn btn-sm btn-icon-only text-light" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
													<i class="fas fa-ellipsis-v"></i>
												</a>
												<div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
													<a class="dropdown-item" href="#">Action</a>
													<a class="dropdown-item" href="#">Another action</a>
													<a class="dropdown-item" href="#">Something else here</a>
												</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="card-footer py-4">
							<nav aria-label="...">
								<ul class="pagination justify-content-end mb-0">
									<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">
											<i class="fas fa-angle-left"></i> <span class="sr-only">Previous</span>
										</a></li>
									<li class="page-item active"><a class="page-link" href="#">1</a></li>
									<li class="page-item"><a class="page-link" href="#">
											2 <span class="sr-only">(current)</span>
										</a></li>
									<li class="page-item"><a class="page-link" href="#">3</a></li>
									<li class="page-item"><a class="page-link" href="#">
											<i class="fas fa-angle-right"></i> <span class="sr-only">Next</span>
										</a></li>
								</ul>
							</nav>
						</div>
					</div>
				</div>
			</div> --%>

			<!-- Footer -->
			<footer class="footer">
				<div class="row align-items-center justify-content-xl-between">
					<div class="col-xl-6">
						<div class="copyright text-center text-xl-left text-muted">
							&copy; 2018
							<a href="https://www.creative-tim.com" class="font-weight-bold ml-1" target="_blank">Creative Tim</a>
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