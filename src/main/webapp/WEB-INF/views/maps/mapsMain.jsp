<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx4afb1a7c147445528d8e83f3f1d4fea0"></script>
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
<link href="<c:url value="/resources/assets/css/argon-dashboard.css?v=1.1.2"/>" rel="stylesheet" />
<script type="text/javascript">

    var map, pos, marker, toiletMarker, marker_s, marker_e, marker_p1, marker_p2, label, endX, endY, polyline_, InfoWindow;
    var toiletType, unisexToiletYn, hour, distance, distime;
    var menToiletBowlNumber, menHandicapToiletBowlNumber;
    var ladiesToiletBowlNumber, ladiesHandicapToiletBowlNumber;
    var totalMarkerArr = [ ];
    var drawInfoArr = [ ];
    var nearbyToilet = [ ];
    var polyFlag = 0;
    var locationFlag = 0;
    

    //길찾기
    function directions (endX, endY) {
        //  경로탐색 API 사용요청
        $.ajax({
                    method : "POST",
                    url : "https://apis.openapi.sk.com/tmap/routes/pedestrian?version=1&format=json&callback=result",//
                    async : false,
                    data : {
                        "appKey" : "l7xx4afb1a7c147445528d8e83f3f1d4fea0",
                        "startX" : lng,
                        "startY" : lat,
                        "endX" : endX,
                        "endY" : endY,
                        //"passList" : "126.987319,37.565778_126.983072,37.573028",
                        "reqCoordType" : "WGS84GEO",
                        "resCoordType" : "EPSG3857",
                        "startName" : "출발지",
                        "endName" : "도착지"
                    },
                    success : function (response) {
                        var resultData = response.features;
                        
                        //결과 출력
                        var tDistance =  ( ( resultData[0].properties.totalDistance ) / 1000 ).toFixed(1) + "km";
                        var tTime =  ( ( resultData[0].properties.totalTime ) / 60 ).toFixed(0) + "분";
                        distime = tTime+" "+tDistance;
                        
                       // $("#result").text(tDistance + tTime);
                        
                        drawInfoArr = [ ];
                        for( var i in resultData){ //for문 [S]
                            var geometry = resultData[i].geometry;
                            var properties = resultData[i].properties;
                            // var polyline_;
                            
                            if(geometry.type == "LineString"){
                                for( var j in geometry.coordinates){
                                    // 경로들의 결과값(구간)들을 포인트 객체로 변환 
                                    var latlng = new Tmapv2.Point(geometry.coordinates[j][0], geometry.coordinates[j][1]);
                                    // 포인트 객체를 받아 좌표값으로 변환
                                    var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(latlng);
                                    // 포인트객체의 정보로 좌표값 변환 객체로 저장
                                    var convertChange = new Tmapv2.LatLng(convertPoint._lat, convertPoint._lng);
                                    // 배열에 담기
                                    drawInfoArr.push(convertChange);
                                }
                                
                            }
                            
                            else{
                                var markerImg = "";
                                var pType = "";
                                var size;
                                
                                if(properties.pointType == "S"){ //출발지 마커
                                    markerImg = "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_s.png";
                                    pType = "S";
                                    size = new Tmapv2.Size(24, 38);
                                }
                                else if(properties.pointType == "E"){ //도착지 마커
                                    markerImg = "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_e.png";
                                    pType = "E";
                                    size = new Tmapv2.Size(24, 38);
                                }
                                else{ //각 포인트 마커
                                    markerImg = "http://topopen.tmap.co.kr/imgs/point.png";
                                    pType = "P";
                                    size = new Tmapv2.Size(8, 8);
                                }
                                
                            }
                        }//for문 [E]
                        
                        if(polyFlag){
                            setTimeout(function () {
                                polyline_.setMap(null)
                            }, 0);
                        }
                        
                        setTimeout(function () {
                            polyline_ = new Tmapv2.Polyline({
                                path : drawInfoArr,
                                strokeColor : "#DD0000",
                                strokeWeight : 6,
                                map : map
                            });
                        }, 0);
                        
                        polyFlag = 1;
                    },
                    error : function (request, status, error) {
                        console
                                .log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                    }
                });//ajax[E]

       return distime;      
    }//directions[E]
    
    
    function setPositions (e, marker) {
        nearbyToilet = e;
        console.log(nearbyToilet.length)
        console.log(nearbyToilet);
        for(i = 0; i < nearbyToilet.length; i++){//for문을 통하여 배열 안에 있는 값을 마커 생성
            var lonlat = nearbyToilet[i].lat + ',' + nearbyToilet[i].lng;
            var title = nearbyToilet[i].toiletNm;
            label = "<span style='background-color: #46414E;color:white'>" + title + "</span>";
            //Marker 객체 생성.
            toiletMarker = new Tmapv2.Marker({
                id : i,
                position : new Tmapv2.LatLng(nearbyToilet[i].lat, nearbyToilet[i].lng), //Marker의 중심좌표 설정.
                map : map, //Marker가 표시될 Map 설정.
                title : title, //Marker 타이틀.
                label : label //Marker의 라벨.
            });
            
            //Marker에 클릭이벤트 등록.
            toiletMarker.addListener("click", function (toiletMarker, marker, i) {
           		return function () {
                           index = i;
                           target = toiletMarker.getPosition();
                           endX = target._lng;
                           endY = target._lat;
                            
                           //누르자마자 경로탐색 > 나중에 경로안내누르면 실시간안내되도록 바꾸기
                           distime = directions(endX,endY);
                           if(nearbyToilet[i].unisexToiletYn=="Y")
                               nearbyToilet[i].unisexToiletYn = "남녀공용";
                           else
                               nearbyToilet[i].unisexToiletYn = "남녀별도";
                            
                           var toiletBowlNumber = nearbyToilet[i].menToiletBowlNumber + nearbyToilet[i].ladiesToiletBowlNumber;
                           var handicap =  nearbyToilet[i].menHandicapToiletBowlNumber + nearbyToilet[i].ladiesHandicapToiletBowlNumber;
                           if(handicap>0)
                               handicap = "Y";
                           else
                               handicap = "N";
                           
                           //console.log("toiletMarker : " + toiletMarker)
                           //console.log("marker : " + marker)
                           //여기까지 마커(내위치) 들어오는것 확인
                           
                           var content = "<h5 class='card-title text-uppercase text-muted mb-0'>"+nearbyToilet[i].unisexToiletYn+"</h5>" 
                           content += "<br'><span class='card-title text-uppercase text-muted mb-0'>대변기 : "+toiletBowlNumber+"</span>"
                           content += "<br><span class='card-title text-uppercase text-muted mb-0'>배려실 : "+handicap+"</span>"
                           content += "<br>"+distime;	
                           //content += "<input type='button' id='direction[" + i + "]' value='경로안내' onclick='navigators(" + endX + ',' + endY + ")'>";
                           //마커를 클로저방식으로 넘겨서, 그 마커를 네비게이터스가 실행될때 제거할수있도록해야할것같다.
                           /* content += "<input type='button' id='direction[" + i + "]' value='경로안내' onclick='navigators(" + endX + ',' + endY + ',' + marker + ")'>";  */
							
                            content += "<input type='button' id='direction[" + i + "]' value='경로안내' onclick='(";
							content += "function(endX,endY, marker){";
							content +=     "return function(){";
	                        			//실시간 길찾기
	                        //content +=			"console.log('길찾기실행중')"			
	                        content +=          "setInterval(function(){";
	                        content += 	            "myLocation(marker);";
	                       	content +=              "directions(endX, endY);";
	                       	content +=          "},5000);";
	                       	content +=     "}";
	                        content += "}";
							content += ")(" + endX + "," + endY + "," + marker + ")'>";  
                          
                           
                           console.log("target : " + i)
                           setTimeout(function () {
                               InfoWindow.setMap(null)
                           }, 0);
                           setTimeout(function () {
                               InfoWindow = new Tmapv2.InfoWindow({
                                   position : new Tmapv2.LatLng(target._lat, target._lng),
                                   content : content,
                                   type : 1,
                                   map : map
                               });
                            }, 0);
                        }
                    }(toiletMarker, marker, i));
        }
    }//setPositions[E]
    
  	function myLocation(marker){
  	  	// HTML5의 geolocation으로 사용할 수 있는지 확인합니다      
  	    if(navigator.geolocation){
  	   		navigator.geolocation.getCurrentPosition(function (position) {
  	        	lat = position.coords.latitude;
  	            lng = position.coords.longitude;
  	            pos = {
  	              	lat : lat,
  	                lng : lng
  	            };
  	            $.ajax({
  	            	url : "<c:url value='/maps/getLocation'/>",
  	       			data : {
						lat : pos.lat.toFixed(6),
  	               	    lng : pos.lng.toFixed(6)
  	                },
  	                type : "post",
  	                success : function(e){
  	                	if(locationFlag==0){
  	                    	locationFlag=1;
  	                   		setPositions(e, marker);
  	                   	}
  	                },
  	                error : function (e) {
  	                	console.log(e)
  	              	}
  	    		})

  	            //팝업 생성
  	            var content = "<div style=' position: relative; border-bottom: 1px solid #dcdcdc; line-height: 18px; padding: 0 35px 2px 0;'>" + "<div style='font-size: 12px; line-height: 15px;'>" + "<span style='display: inline-block; width: 14px; height: 14px; background-image: url(/resources/images/common/icon_blet.png); vertical-align: middle; margin-right: 5px;'></span>Your position" + "</div>" + "</div>";
  	               
  	         	console.log(marker)
	            setTimeout(function(){
		    	  	marker.setMap(null)
		        }, 0);     
  		        setTimeout(function(){
  		          	marker = new Tmapv2.Marker({
  		          		position : new Tmapv2.LatLng(lat, lng),
	           		    map : map
  		           });
  		        }, 0);
  		     	     
  	            setTimeout(function () {
  	            	InfoWindow.setMap(null)
  	            }, 0);
  	            setTimeout(function () {
  	            	InfoWindow = new Tmapv2.InfoWindow({
  	                	position : new Tmapv2.LatLng(lat, lng),
	                    content : content,
  	                    type : 1,
  	                    map : map
  	                });
  	            }, 0);
  	                        
  	            map.setCenter(new Tmapv2.LatLng(lat, lng));
  	            map.setZoom(15);
  	           });
  		}
  	}//mylocation[E]
    
/*   	//실시간길찾기
  	function navigators(endX, endY, marker){
  		     
  		//실시간 길찾기
  	    setInterval(function(){
  	    	myLocation(marker);
  	       	directions(endX, endY);
  	       	console.log("네비게이터 실행중")
  	   	},5000);
  	        
  	} */
  	    
  		 
    function initTmap () {
        // Tmap.map을 이용하여, 지도가 들어갈 div, 넓이, 높이를 설정합니다.
        map = new Tmapv2.Map("map_div", {
            center : new Tmapv2.LatLng(37.566481622437934, 126.98502302169841), // 지도 초기 좌표
            width : "100%", // map의 width 설정
            height : "400px" // map의 height 설정	
            
        });
       
        myLocation();
        
        function addComma (num) {
            var regexp = /\B(?=(\d{3})+(?!\d))/g;
            return num.toString().replace(regexp, ',');
        }
    }//initMap[E]
   
</script>
</head>

<body class="" onload="initTmap()">
	<nav class="navbar navbar-vertical fixed-left navbar-expand-md navbar-light bg-white" id="sidenav-main">
		<div class="container-fluid">
			<!-- Toggler -->
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<!-- Brand -->
			<a class="navbar-brand pt-0" href="<c:url value="/examples/maps"/>"> <img src="<c:url value="/resources/assets/img/brand/blue.png"/>" class="navbar-brand-img" alt="...">
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
						<a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-single-02"></i> <span>My profile</span>
						</a> <a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-settings-gear-65"></i> <span>Settings</span>
						</a> <a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-calendar-grid-58"></i> <span>Activity</span>
						</a> <a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-support-16"></i> <span>Support</span>
						</a>
						<div class="dropdown-divider"></div>
						<a href="#!" class="dropdown-item"> <i class="ni ni-user-run"></i> <span>Logout</span>
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
					<li class="nav-item"><a class="nav-link  active " href="<c:url value="/examples/maps"/>"> <i class="ni ni-pin-3 text-orange"></i> Maps
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
					<c:if test="${sessionScope.userID==null }">
						<li class="nav-item"><a class="nav-link" href="<c:url value="/examples/login"/>"> <i class="ni ni-key-25 text-info"></i> Login
						</a></li>
						<li class="nav-item"><a class="nav-link" href="<c:url value="/examples/register"/>"> <i class="ni ni-circle-08 text-pink"></i> Sign up
						</a></li>
					</c:if>
					<c:if test="${sessionScope.userID!=null }">
						<li class="nav-item"><a class="nav-link " href="<c:url value="/examples/profile"/>"> <i class="ni ni-single-02 text-yellow"></i> User profile
						</a></li>
						<li class="nav-item"><a class="nav-link" href="<c:url value="/examples/login"/>"> <i class="ni ni-key-25 text-info"></i> Logout
						</a></li>
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
							<a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-single-02"></i> <span>My profile</span>
							</a> <a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-settings-gear-65"></i> <span>Settings</span>
							</a> <a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-calendar-grid-58"></i> <span>Activity</span>
							</a> <a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-support-16"></i> <span>Support</span>
							</a>
							<div class="dropdown-divider"></div>
							<a href="#!" class="dropdown-item"> <i class="ni ni-user-run"></i> <span>Logout</span>
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
						<div id="map_wrap" class="map_wrap3">
							<div id="map_div" class="map-canvas" style="height: 600px;"></div>
						</div>
						<div class="map_act_btn_wrap clear_box"></div>
						<!-- <input type="hidden" id="start"> <input type="hidden" id="end"> -->
					</div>
				</div>
			</div>

			<!-- Footer -->
			<footer class="footer">
				<div class="row align-items-center justify-content-xl-between">
					<div class="col-xl-6">
						<div class="copyright text-center text-xl-left text-muted">
							&copy; 2018 <a href="https://www.creative-tim.com" class="font-weight-bold ml-1" target="_blank">Creative Tim</a>
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

</body>

</html>