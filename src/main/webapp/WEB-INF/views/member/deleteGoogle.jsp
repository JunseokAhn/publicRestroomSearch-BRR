<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<meta name = "google-signin-client_id"content = "1008960346250-33jebt3kge8r04ac3dh0fqoamfidshjs.apps.googleusercontent.com">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원 탈퇴 페이지</title>
<link href="<c:url value="/resources/assets/img/brand/favicon.png"/>" rel="icon" type="image/png">
<!-- Fonts -->
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
<!-- Icons -->
<link href="<c:url value="/resources/assets/js/plugins/nucleo/css/nucleo.css"/>" rel="stylesheet" />
<link href="<c:url value="/resources/assets/js/plugins/@fortawesome/fontawesome-free/css/all.min.css"/>" rel="stylesheet" />
<!-- CSS Files -->
<link href="<c:url value="/resources/assets/css/argon-dashboard.css?v=1.1.2"/>" rel="stylesheet" />
<script>
// function onLoad() { 
// 	gapi.load('auth2', function() { 
// 		gapi.auth2.init(); 
// 	});
// }

// function signOut() {
// 	var auth2 = gapi.auth2.getAuthInstance();
//     auth2.signOut().then(function () {
//     console.log('회원 탈퇴 완료');
//     });
//     	auth2.disconnect();
// }

var url = "https://accounts.google.com/logout";

function logout()
{
    var url3 = window.open(url,"popup","width = 200, height = 200");
    alert("회원탈퇴가 정상적으로 이루어졌습니다.");
     url3.open();
     setTimeout(function(){
         url3.close();
//          lo();
         },300)
}

// function lo()
// {
// var url2 = "http://localhost:8888/brr/maps/mapsMain";
// location.replace(url2);
// }


</script>
</head>
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
							<h1 class="text-white">감사합니다! 화장실이 급할땐? brr!!</h1>
							<p class="text-lead text-light">정상적으로 로그아웃 되었습니다^^</p>
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
								<h3>이용해주셔서 감사합니다!</h3>
							</div>
								<div align="center">
									<table>
									<tr>
										<td><h1>${sessionScope.sessionEmail}</h1></td>
									</tr>
									<tr>
										<td><form action="delGoogle" method = "post" onsubmit="logout()">
										<input type = "submit" value="회원탈퇴" class="btn btn-primary">
										</form></td>
									</tr>
									</table>
								</div>
						</div>
						<div class="card-body px-lg-5 py-lg-5">
							<div class="text-center text-muted mb-4">
<!-- 								<small>이 부근에 로고를 넣으시면 됩니다.</small> -->
								<img width="40%" height="20%" src="<c:url value="/resources/img/Logo.png"/>" />
							</div>
							<form role="form">

							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Footer -->
         <footer class="footer">
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


</html>