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
			<a class="navbar-brand pt-0" href="<c:url value="/examples/maps"/>">
				<img src="<c:url value="/resources/assets/img/brand/blue.png"/>" class="navbar-brand-img" alt="...">
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
							<a href="<c:url value="/examples/index"/>">
								<img src="<c:url value="/resources/assets/img/brand/blue.png"/>">
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
					<li class="nav-item"><a class="nav-link  active " href="<c:url value="/examples/maps"/>">
							<i class="ni ni-pin-3 text-orange"></i> Maps
						</a></li>
					<li class="nav-item"><a class="nav-link " href="<c:url value="/examples/index"/>">
							<i class="ni ni-tv-2 text-primary"></i> Board
						</a></li>
					<%-- <li class="nav-item  active "><a class="nav-link " href="<c:url value="/examples/index"/>">
							<i class="ni ni-tv-2 text-primary"></i> Dashboard
						</a></li> //nav-item  active는 무조건 검정색으로 표시됩니다. --%>
					<li class="nav-item"><a class="nav-link " href="<c:url value="/examples/icons"/>">
							<i class="ni ni-planet text-blue"></i> Icons
						</a></li>

					<li class="nav-item"><a class="nav-link " href="<c:url value="/examples/tables"/>">
							<i class="ni ni-bullet-list-67 text-red"></i> Tables
						</a></li>
					<c:if test="${sessionScope.userID==null }">
						<li class="nav-item"><a class="nav-link" href="<c:url value="/examples/login"/>">
								<i class="ni ni-key-25 text-info"></i> Login
							</a></li>
						<li class="nav-item"><a class="nav-link" href="<c:url value="/examples/register"/>">
								<i class="ni ni-circle-08 text-pink"></i> Sign up
							</a></li>
					</c:if>
					<c:if test="${sessionScope.userID!=null }">
						<li class="nav-item"><a class="nav-link " href="<c:url value="/examples/profile"/>">
								<i class="ni ni-single-02 text-yellow"></i> User profile
							</a></li>
						<li class="nav-item"><a class="nav-link" href="<c:url value="/examples/login"/>">
								<i class="ni ni-key-25 text-info"></i> Logout
							</a></li>
					</c:if>
				</ul>
				<!-- Divider -->
				<hr class="my-3">
				<!-- Heading -->
				<h6 class="navbar-heading text-muted">Documentation</h6>
				<!-- Navigation -->
				<ul class="navbar-nav mb-md-3">
					<li class="nav-item"><a class="nav-link" href="https://demos.creative-tim.com/argon-dashboard/docs/getting-started/overview.html">
							<i class="ni ni-spaceship"></i> Getting started
						</a></li>
					<li class="nav-item"><a class="nav-link" href="https://demos.creative-tim.com/argon-dashboard/docs/foundation/colors.html">
							<i class="ni ni-palette"></i> Foundation
						</a></li>
					<li class="nav-item"><a class="nav-link" href="https://demos.creative-tim.com/argon-dashboard/docs/components/alerts.html">
							<i class="ni ni-ui-04"></i> Components
						</a></li>
				</ul>
				<ul class="navbar-nav">
					<li class="nav-item active active-pro"><a class="nav-link" href="<c:url value="/examples/upgrade"/>">
							<i class="ni ni-send text-dark"></i> Upgrade to PRO
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
				<a class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block" href="<c:url value="/examples/index"/>">Maps</a>
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
								<span class="avatar avatar-sm rounded-circle"> <img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-4-800x800.jpg"/>">
								</span>
								<div class="media-body ml-2 d-none d-lg-block">
									<span class="mb-0 text-sm  font-weight-bold">Jessica Jones</span>
								</div>
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
			</div>
		</nav>
		<!-- End Navbar -->
		<!-- Header -->
		<div class="header bg-gradient-primary pb-8 pt-5 pt-md-8">
			<div class="container-fluid">
				<div class="header-body">
					<!-- Card stats -->
					<div class="row">
						<div class="col-xl-3 col-lg-6">
							<div class="card card-stats mb-4 mb-xl-0">
								<div class="card-body">
									<div class="row">
										<div class="col">
											<h5 class="card-title text-uppercase text-muted mb-0">Traffic</h5>
											<span class="h2 font-weight-bold mb-0">350,897</span>
										</div>
										<div class="col-auto">
											<div class="icon icon-shape bg-danger text-white rounded-circle shadow">
												<i class="fas fa-chart-bar"></i>
											</div>
										</div>
									</div>
									<p class="mt-3 mb-0 text-muted text-sm">
										<span class="text-success mr-2"><i class="fa fa-arrow-up"></i> 3.48%</span> <span class="text-nowrap">Since last month</span>
									</p>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-lg-6">
							<div class="card card-stats mb-4 mb-xl-0">
								<div class="card-body">
									<div class="row">
										<div class="col">
											<h5 class="card-title text-uppercase text-muted mb-0">New users</h5>
											<span class="h2 font-weight-bold mb-0">2,356</span>
										</div>
										<div class="col-auto">
											<div class="icon icon-shape bg-warning text-white rounded-circle shadow">
												<i class="fas fa-chart-pie"></i>
											</div>
										</div>
									</div>
									<p class="mt-3 mb-0 text-muted text-sm">
										<span class="text-danger mr-2"><i class="fas fa-arrow-down"></i> 3.48%</span> <span class="text-nowrap">Since last week</span>
									</p>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-lg-6">
							<div class="card card-stats mb-4 mb-xl-0">
								<div class="card-body">
									<div class="row">
										<div class="col">
											<h5 class="card-title text-uppercase text-muted mb-0">Sales</h5>
											<span class="h2 font-weight-bold mb-0">924</span>
										</div>
										<div class="col-auto">
											<div class="icon icon-shape bg-yellow text-white rounded-circle shadow">
												<i class="fas fa-users"></i>
											</div>
										</div>
									</div>
									<p class="mt-3 mb-0 text-muted text-sm">
										<span class="text-warning mr-2"><i class="fas fa-arrow-down"></i> 1.10%</span> <span class="text-nowrap">Since yesterday</span>
									</p>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-lg-6">
							<div class="card card-stats mb-4 mb-xl-0">
								<div class="card-body">
									<div class="row">
										<div class="col">
											<h5 class="card-title text-uppercase text-muted mb-0">Performance</h5>
											<span class="h2 font-weight-bold mb-0">49,65%</span>
										</div>
										<div class="col-auto">
											<div class="icon icon-shape bg-info text-white rounded-circle shadow">
												<i class="fas fa-percent"></i>
											</div>
										</div>
									</div>
									<p class="mt-3 mb-0 text-muted text-sm">
										<span class="text-success mr-2"><i class="fas fa-arrow-up"></i> 12%</span> <span class="text-nowrap">Since last month</span>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="container-fluid mt--7">
			<div class="row">
				<div class="col">
					<div class="card shadow border-0">
						<div id="map" class="map-canvas" style="height: 600px;"></div>
						<input type="hidden" id="start"> <input type="hidden" id="end">
					</div>
				</div>
			</div>

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
	<script>
		// Note: This example requires that you consent to location sharing when
		// prompted by your browser. If you see the error "The Geolocation service
		// failed.", it means you probably did not give permission for the browser to
		// locate you.
		var map, pos, marker, i;

		window.onload = function() {
			infowindow = new google.maps.InfoWindow();
		}

		function initMap() {
			map = new google.maps.Map(document.getElementById('map'), {
				center : {
					lat : 37.511683,
					lng : 127.061255
				},
				zoom : 16,
				mapTypeId : google.maps.MapTypeId.ROADMAP
			});
			infoWindow = new google.maps.InfoWindow();

			// 내위치설정
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(function(position) {
					pos = {
						lat : position.coords.latitude,
						lng : position.coords.longitude
					};

					infoWindow.setPosition(pos);
					infoWindow.setContent('Location found.');
					infoWindow.open(map);
					map.setCenter(pos);
					console.log("this location : " + JSON.stringify(pos));
					document.getElementById('start').value = pos.lat + ","
							+ pos.lng
				}, function() {
					handleLocationError(true, infoWindow, map.getCenter());
				});
			} else {
				// Browser doesn't support Geolocation
				handleLocationError(false, infoWindow, map.getCenter());
			}

			//마커설정
			// Create an array of alphabetical characters used to label the markers.
			var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

			// Add some markers to the map.
			// Note: The code uses the JavaScript Array.prototype.map() method to
			// create an array of markers based on a given "locations" array.
			// The map() method here has nothing to do with the Google Maps API.

			/* marker = locations.map(function(location, i) {
			   return new google.maps.Marker({
			     position: {lat : location.lat, lng : location.lng},
			     label: labels[i % labels.length],
			     title: "index"+i,
			     //title: location.contents,
			     content: location.contents
			   });
			   
			 });*/

			for (var i = 0; i < locations.length; i++) {
				marker = new google.maps.Marker({
					id : i,
					position : new google.maps.LatLng(locations[i].lat,
							locations[i].lng),
					label : labels[i % labels.length],
					map : map
				});

				google.maps.event.addListener(marker, 'click', (function(
						marker, i) {
					return function() {
						console.log(i);
						infowindow.setContent(locations[i].contents);
						infowindow.open(map, marker);
					}
				})(marker, i));
				if (marker) {
					marker.addListener('click', function() {
						map.setZoom(15);
						map.setCenter(this.getPosition());
						target = this.getPosition()
						target = String(target)
						target = target.replace('(', '');
						target = target.replace(')', '');
						target = target.replace(' ', '');
						console.log("target location : " + target);
						document.getElementById('end').value = target;
						console.log("start : "
								+ document.getElementById('start').value);
						console.log("end : "
								+ document.getElementById('end').value);
						onChangeHandler();

					});
				}
			}

			// Add a marker clusterer to manage the markers.

			/*var markerCluster = new MarkerClusterer(map, marker,
			{imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});*/

			//길찾기설정
			var directionsService = new google.maps.DirectionsService();
			var directionsRenderer = new google.maps.DirectionsRenderer();
			directionsRenderer.setMap(map);

			var onChangeHandler = function() {
				calculateAndDisplayRoute(directionsService, directionsRenderer);
			};

			//document.getElementById('start').addEventListener('change', onChangeHandler);
			// document.getElementById('end').addEventListener('change', onChangeHandler);

		}

		function handleLocationError(browserHasGeolocation, infoWindow, pos) {
			infoWindow.setPosition(pos);
			infoWindow
					.setContent(browserHasGeolocation ? 'Error: The Geolocation service failed.'
							: 'Error: Your browser doesn\'t support geolocation.');
			infoWindow.open(map);
		}

		function calculateAndDisplayRoute(directionsService, directionsRenderer) {
			directionsService.route({
				origin : {
					query : document.getElementById('start').value
				},
				destination : {
					query : document.getElementById('end').value
				},
				travelMode : 'TRANSIT'
			}, function(response, status) {
				if (status === 'OK') {
					directionsRenderer.setDirections(response);
				} else {
					window.alert('Directions request failed due to ' + status);
				}
			});
		}

		//마커 위치설정
		var locations = [ {
			lat : -31.563910,
			lng : 147.154312,
			contents : "이게되나?1"
		}, {
			lat : -33.718234,
			lng : 150.363181,
			contents : "이게되나?2"
		}, {
			lat : -33.727111,
			lng : 150.371124,
			contents : "이게되나?3"
		}, {
			lat : -33.848588,
			lng : 151.209834,
			contents : "이게되나?4"
		}, {
			lat : -33.851702,
			lng : 151.216968,
			contents : "이게되나?5"
		}, {
			lat : -34.671264,
			lng : 150.863657,
			contents : "이게되나?6"
		}, {
			lat : -35.304724,
			lng : 148.662905,
			contents : "이게되나?7"
		}, {
			lat : -36.817685,
			lng : 175.699196,
			contents : "이게되나?8"
		}, {
			lat : -36.828611,
			lng : 175.790222,
			contents : "이게되나?9"
		}, {
			lat : -37.750000,
			lng : 145.116667,
			contents : "이게되나?10"
		}, {
			lat : -37.759859,
			lng : 145.128708,
			contents : "이게되나?11"
		}, {
			lat : -37.765015,
			lng : 145.133858,
			contents : "이게되나?12"
		}, {
			lat : -37.770104,
			lng : 145.143299,
			contents : "이게되나?13"
		}, {
			lat : -37.773700,
			lng : 145.145187,
			contents : "이게되나?14"
		}, {
			lat : -37.774785,
			lng : 145.137978,
			contents : "이게되나?15"
		}, {
			lat : -37.819616,
			lng : 144.968119,
			contents : "이게되나?16"
		}, {
			lat : -38.330766,
			lng : 144.695692,
			contents : "이게되나?17"
		}, {
			lat : -39.927193,
			lng : 175.053218,
			contents : "이게되나?18"
		}, {
			lat : -41.330162,
			lng : 174.865694,
			contents : "이게되나?19"
		}, {
			lat : -42.734358,
			lng : 147.439506,
			contents : "이게되나?20"
		}, {
			lat : -42.734358,
			lng : 147.501315,
			contents : "이게되나?21"
		}, {
			lat : -42.735258,
			lng : 147.438000,
			contents : "이게되나?22"
		}, {
			lat : -43.999792,
			lng : 170.463352,
			contents : "이게되나?23"
		}, {
			lat : 37.559739,
			lng : 126.843046,
			contents : "이게되나?24"
		}, {
			lat : 37.562162,
			lng : 126.844371,
			contents : "이게되나?25"
		}, {
			lat : 37.561116,
			lng : 126.842429,
			contents : "이게되나?26"
		} ]

		/* https://maps.googleapis.com/maps/api/directions/json?origin=41.43206,-81.38992&destination=41.43206,-81.8992&key=AIzaSyDkQ00U2AUBQSS1CJF5YveL-1YWsTjaRGA*/

		/*https://maps.googleapis.com/maps/api/directions/json?origin=37.5728359,126.9746922&destination=37.5129907,127.1005382&key=AIzaSyDkQ00U2AUBQSS1CJF5YveL-1YWsTjaRGA*/
		/*https://maps.googleapis.com/maps/api/directions/
		 json?origin=37.5728359,126.9746922&destination=37.5129907,127.1005382&mode=transit&departure_time=now&key=AIzaSyDkQ00U2AUBQSS1CJF5YveL-1YWsTjaRGA&callback=initMap*/
	</script>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDkQ00U2AUBQSS1CJF5YveL-1YWsTjaRGA&callback=initMap">
		
	</script>
</body>

</html>