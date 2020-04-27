<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name = "google-signin-client_id"content = "1008960346250-33jebt3kge8r04ac3dh0fqoamfidshjs.apps.googleusercontent.com">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="<c:url value="/resources/js/jquery-3.4.1.js/"/>"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script>
function onSignIn(googleUser) {
	
	  var profile = googleUser.getBasicProfile();
	  console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
	  console.log('Name: ' + profile.getName());
	  console.log('Image URL: ' + profile.getImageUrl());
	  console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.

	  var id_token = googleUser.getAuthResponse().id_token;
		var xhr = new XMLHttpRequest();
		xhr.open('POST', 'http://localhost:8888/brr/callbackTestGoo');
		xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		xhr.onload = function() {
			console.log(id_token);
		};
		xhr.send('idtoken=' + id_token);
		
		setTimeout(function(){ BackHome(); }, 3000);
	}
function BackHome(){
	window.location.replace("/brr/maps/mapsMain");	
}
</script>
<title>brr 로그인 페이지</title>
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

<!-- Naver Login URL -->
<%
    String clientId = "z_lyTyQUbIC8kv8VfFwH";
    String redirectURI = URLEncoder.encode("http://localhost:8888/brr/callback", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
 %>

<body class="bg-default">
	<div class="main-content">
		<!-- Navbar -->
		<nav class="navbar navbar-top navbar-horizontal navbar-expand-md navbar-dark">
			<div class="container px-4">
				<a class="navbar-brand" href="<c:url value="/maps/mapsMain"/>"> <img src="<c:url value="/resources/img/Logo.png"/>" />
				</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-collapse-main" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbar-collapse-main">
					<!-- Collapse header -->
					<div class="navbar-collapse-header d-md-none">
						<div class="row">
							<div class="col-6 collapse-brand">
								<a href="<c:url value="/maps/mapsMain"/>"> <img src="<c:url value="/resources/img/Log.png"/>">
								</a>
							</div>
							<div class="col-6 collapse-close">
								<button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbar-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle sidenav">
									<span></span> <span></span>
								</button>
							</div>
						</div>
					</div>
<!-- 					Navbar items -->
<!-- 					<ul class="navbar-nav ml-auto"> -->
<%-- 						<li class="nav-item"><a class="nav-link nav-link-icon" href="<c:url value="/examples/index"/>"> <i class="ni ni-planet"></i> <span class="nav-link-inner--text">Dashboard</span> --%>
<!-- 						</a></li> -->
<%-- 						<li class="nav-item"><a class="nav-link nav-link-icon" href="<c:url value="/examples/register"/>"> <i class="ni ni-circle-08"></i> <span class="nav-link-inner--text">Register</span> --%>
<!-- 						</a></li> -->
<%-- 						<li class="nav-item"><a class="nav-link nav-link-icon" href="<c:url value="/examples/login"/>"> <i class="ni ni-key-25"></i> <span class="nav-link-inner--text">Login</span> --%>
<!-- 						</a></li> -->
<%-- 						<li class="nav-item"><a class="nav-link nav-link-icon" href="<c:url value="/examples/profile"/>"> <i class="ni ni-single-02"></i> <span class="nav-link-inner--text">Profile</span> --%>
<!-- 						</a></li> -->
<!-- 					</ul> -->
				</div>
			</div>
		</nav>
		<!-- Header -->
		<div class="header bg-gradient-primary py-7 py-lg-8">
			<div class="container">
				<div class="header-body text-center mb-7">
					<div class="row justify-content-center">
						<div class="col-lg-5 col-md-6">
							<h1 class="text-white">환영합니다! 화장실이 급할땐? brr!!</h1>
							<p class="text-lead text-light">원하시는 로그인 플랫폼을 선택해서 로그인 해주세요^^</p>
						</div>
					</div>
				</div>
			</div>
			<div class="separator separator-bottom separator-skew zindex-100">
				<svg x="0" y="0" viewBox="0 0 2560 100" preserveAspectRatio="none" version="1.1" xmlns="http://www.w3.org/2000/svg">
          <polygon class="fill-default" points="2560 0 2560 100 0 100"></polygon>
        </svg>
			</div>
		</div>
		<!-- Page content -->
		<div class="container mt--8 pb-5">
			<div class="row justify-content-center">
				<div class="col-lg-5 col-md-7">
					<div class="card bg-secondary shadow border-0">
						<div class="card-header bg-transparent pb-5">
							<div class="text-muted text-center mt-2 mb-3">
								<h3>로그인을 선택 해 주세요.</h3>
							</div>
							<div align="center">
								<table>
									<tr>
										<td>
											<a href="<%=apiURL%>"><img width="120" height="40" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
										</td>
										<td>
											<span class="g-signin2" data-onsuccess="onSignIn"></span>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<div class="card-body px-lg-5 py-lg-5">
							<div class="text-center text-muted mb-4">
							<img width="40%" height="20%" src="<c:url value="/resources/img/Logo.png"/>" />
<!-- 								<small>이 부근에 로고를 넣으시면 됩니다.</small> -->
									
							</div>
							<form role="form">
<!-- 								<div class="form-group mb-3"> -->
<!-- 									<div class="input-group input-group-alternative"> -->
<!-- 										<div class="input-group-prepend"> -->
<!-- 											<span class="input-group-text"><i class="ni ni-email-83"></i></span> -->
<!-- 										</div> -->
<!-- 										<input class="form-control" placeholder="Email" type="email"> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="form-group"> -->
<!-- 									<div class="input-group input-group-alternative"> -->
<!-- 										<div class="input-group-prepend"> -->
<!-- 											<span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span> -->
<!-- 										</div> -->
<!-- 										<input class="form-control" placeholder="Password" type="password"> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="custom-control custom-control-alternative custom-checkbox"> -->
<!-- 									<input class="custom-control-input" id=" customCheckLogin" type="checkbox"> <label class="custom-control-label" for=" customCheckLogin"> <span class="text-muted">Remember me</span> -->
<!-- 									</label> -->
<!-- 								</div> -->
<!-- 								<div class="text-center"> -->
<!-- 									<button type="button" class="btn btn-primary my-4">Sign in</button> -->
<!-- 								</div> -->
							</form>
						</div>
					</div>
<!-- 					<div class="row mt-3"> -->
<!-- 						<div class="col-6"> -->
<!-- 							<a href="#" class="text-light"><small>Forgot password?</small></a> -->
<!-- 						</div> -->
<!-- 						<div class="col-6 text-right"> -->
<!-- 							<a href="#" class="text-light"><small>Create new account</small></a> -->
<!-- 						</div> -->
<!-- 					</div> -->
				</div>
			</div>
		</div>
		<!-- Footer -->
         <footer class="py-5">
	<div class="container">
		<div class="row align-items-center justify-content-xl-between">
			<div class="col-xl-6">
				<div class="copyright text-center text-xl-left text-muted">
					&copy; 2020
                     <a href="" class="font-weight-bold ml-1" target="_blank">Crispy Donut</a>
				</div>
			</div>
			<div class="col-xl-6">
				<ul class="nav nav-footer justify-content-center justify-content-xl-end">
                     <li class="nav-item"><a href="" class="nav-link" target="_blank">About Us</a></li>
                     <li class="nav-item"><a href="https://github.com/JunseokAhn/brr" class="nav-link" target="_blank">Git hub</a></li>
                     <li class="nav-item"><a href="http://tempcat.coo.kr" class="nav-link" target="_blank">Blog</a></li>
                     <li class="nav-item"><a href="http://tradecampus.com/" class="nav-link" target="_blank">SCIT MASTER</a></li>
                  </ul>
			</div>
		</div>
	</div>
</footer>
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