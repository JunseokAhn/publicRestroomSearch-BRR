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
<link href="<c:url value="/resources/css/boardStyle.css"/>" rel="stylesheet" />
<!-- CSS Files -->
<link href="<c:url value="/resources/assets/css/argon-dashboard.css?v=1.1.2"/>" rel="stylesheet" />
<script type="text/javascript">
    var map, pos, marker, toiletMarker, marker_s, marker_e, marker_p1, marker_p2, title, id, label, endX, endY, polyline_, myWindow, targetWindow, destinyWindow, realTime;
    var tDistance, tTime;
    var shortestDistance, highestRating, highestClean, highestSmooth;
    var toiletType, unisexToiletYn, hour, distance, distime;
    var menToiletBowlNumber, menHandicapToiletBowlNumber;
    var ladiesToiletBowlNumber, ladiesHandicapToiletBowlNumber;
    var totalMarkerArr = [ ];
    var drawInfoArr = [ ];
    var nearbyToilet = [ ];
    var polyFlag = 0;
    var locationFlag = 0;
    var starFlag = 1;
    var cleanFlag = 1;
    //var shortFlag = 1;
    
    $(function () {
        //$("#review-container").hide();
        //$("#review").hide();
         $("#star5").on("click",
        function (){
            starFlag=0;
        	$("#star5").attr("src", "<c:url value='/resources/img/starOn.png'/>");
            $("#star4").attr("src", "<c:url value='/resources/img/starOn.png'/>");
            $("#star3").attr("src", "<c:url value='/resources/img/starOn.png'/>");
            $("#star2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
            $("#star1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        })
        $("#star4").on("click",
        function(){
            starFlag=0;
            $("#star4").attr("src", "<c:url value='/resources/img/starOn.png'/>");
            $("#star3").attr("src", "<c:url value='/resources/img/starOn.png'/>");
            $("#star2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
            $("#star1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        })
        $("#star3").on("click",
        function(){
            starFlag=0;
            $("#star3").attr("src", "<c:url value='/resources/img/starOn.png'/>");
            $("#star2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
            $("#star1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        })
        $("#star2").on("click",
        function(){
            starFlag=0;
            $("#star2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
            $("#star1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        })
        $("#star1").on("click",
        function(){
            starFlag=0;
            $("#star1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        })
        
        if(starFlag){
     	    $("#star5").hover(
      	    function(){
       	        $("#star5").attr("src", "<c:url value='/resources/img/starOn.png'/>");
                $("#star4").attr("src", "<c:url value='/resources/img/starOn.png'/>");
                $("#star3").attr("src", "<c:url value='/resources/img/starOn.png'/>");
                $("#star2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
                $("#star1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
                }, 
            function(){
           		$("#star5").attr("src", "<c:url value='/resources/img/starOff.png'/>");
           		$("#star4").attr("src", "<c:url value='/resources/img/starOff.png'/>");
                $("#star3").attr("src", "<c:url value='/resources/img/starOff.png'/>");
                $("#star2").attr("src", "<c:url value='/resources/img/starOff.png'/>");
                $("#star1").attr("src", "<c:url value='/resources/img/starOff.png'/>");
            }) 
        
            $("#star4").hover(
            function(){
                $("#star4").attr("src", "<c:url value='/resources/img/starOn.png'/>");
                $("#star3").attr("src", "<c:url value='/resources/img/starOn.png'/>");
                $("#star2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
                $("#star1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
            }, 
            function(){
                $("#star4").attr("src", "<c:url value='/resources/img/starOff.png'/>");
                $("#star3").attr("src", "<c:url value='/resources/img/starOff.png'/>");
                $("#star2").attr("src", "<c:url value='/resources/img/starOff.png'/>");
                $("#star1").attr("src", "<c:url value='/resources/img/starOff.png'/>");
            }) 
            
            $("#star3").hover(
            function(){
                $("#star3").attr("src", "<c:url value='/resources/img/starOn.png'/>");
                $("#star2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
                $("#star1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
            }, 
            function(){
                $("#star3").attr("src", "<c:url value='/resources/img/starOff.png'/>");
                $("#star2").attr("src", "<c:url value='/resources/img/starOff.png'/>");
                $("#star1").attr("src", "<c:url value='/resources/img/starOff.png'/>");
            }) 
            $("#star2").hover(
            function(){
                $("#star2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
                $("#star1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
            }, 
            function(){
                $("#star2").attr("src", "<c:url value='/resources/img/starOff.png'/>");
                $("#star1").attr("src", "<c:url value='/resources/img/starOff.png'/>");
            }) 
            $("#star1").hover(
            function(){
                $("#star1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
            }, 
            function(){
                $("#star1").attr("src", "<c:url value='/resources/img/starOff.png'/>");
            }) 
        } 
       
    })
    
    //리뷰등록 검사
    function reviewCheck(){
        //청결도, 별점입력했는지
        alert("reviewCheck")
        //몇글자이상 등록해야됨
    }
    //화장실 추천기능
    function searchShortest () {
        directions(shortestDistance)
    }
    function searchRating () {
        
    }
    function searchClan () {
        
    }
    function searchSmooth () {
        
    }

    //길찾기
    function directions (endX, endY) {
        //  경로탐색 API 사용요청
        $
                .ajax({
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
                        tDistance = ( ( resultData[0].properties.totalDistance ) / 1000 )
                                .toFixed(1) + "km";
                        tTime = ( ( resultData[0].properties.totalTime ) / 60 )
                                .toFixed(0) + "분";
                        distime = tTime + " " + tDistance;
                        
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
                        //if(shortFlag == 0){
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
                        //}
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
            //label = "<span style='background-color: #46414E;color:white'>" + title + "</span>";
            //label = title;
            //Marker 객체 생성.
            toiletMarker = new Tmapv2.Marker({
                id : i,
                position : new Tmapv2.LatLng(nearbyToilet[i].lat, nearbyToilet[i].lng), //Marker의 중심좌표 설정.
                map : map, //Marker가 표시될 Map 설정.
                icon : "<c:url value = '/resources/img/toilet28.png'/>",
                title : title, //Marker 타이틀.
            //label : label //Marker의 라벨.
            });
            
            //최단거리 화장실 등록
            if(i == 0){
                shortestDistance = toiletMarker;
            }
            //Marker에 클릭이벤트 등록.
            toiletMarker
                    .addListener("click", function (toiletMarker, i, title) {
                        return function () {
                            index = i;
                            target = toiletMarker.getPosition();
                            endX = target._lng;
                            endY = target._lat;
                            
                            //누르자마자 경로탐색 > 나중에 경로안내누르면 실시간안내되도록 바꾸기
                            distime = directions(endX, endY);
                            if(nearbyToilet[i].unisexToiletYn == "Y")
                                nearbyToilet[i].unisexToiletYn = "남녀공용 ";
                            else
                                nearbyToilet[i].unisexToiletYn = "남녀별도 ";
                            
                            var toiletType = nearbyToilet[i].unisexToiletYn + nearbyToilet[i].toiletType;
                            var toiletBowlNumber = nearbyToilet[i].menToiletBowlNumber + nearbyToilet[i].ladiesToiletBowlNumber;
                            var handicap = nearbyToilet[i].menHandicapToiletBowlNumber + nearbyToilet[i].ladiesHandicapToiletBowlNumber;
                            if(handicap > 0)
                                handicap = "Y";
                            else
                                handicap = "N";
                            
                            //console.log("toiletMarker : " + toiletMarker)
                            console.log(marker)
                            //여기까지 마커(내위치) 들어오는것 확인
                            var content = "<div style='min-width:max-content;  z-index:999;'>"
                            content += "<h5 class='card-title text-uppercase text-muted mb-0'>" + toiletType + "</h5>"
                            content += "<br'><span class='card-title text-uppercase text-muted mb-0'>대변기 : " + toiletBowlNumber + "</span>"
                            content += "<br><span class='card-title text-uppercase text-muted mb-0'>장애인 배려실 : " + handicap + "</span>"

                            content += "<br><input class='replyButton3 mt-1' type='button' id='direction[" + i + "]' value='실시간 길찾기' onclick='navigators(" + endX + ',' + endY + ',' + '"' + title + '"' + ',' + '"' + toiletType + '"' + ',' + '"' + toiletBowlNumber + '"' + ',' + '"' + handicap + '"' + ")'>";
                            content += "<div style='display:inline-block; margin-left:5px; text-decoration: underline; '>" + distime + "</div>";
                            content += "</div>"

                            console.log("target : " + i)
                            setTimeout(function () {
                                targetWindow.setMap(null)
                            }, 0);
                            setTimeout(function () {
                                targetWindow = new Tmapv2.InfoWindow({
                                    position : new Tmapv2.LatLng(target._lat, target._lng),
                                    content : content,
                                    type : 1,
                                    map : map
                                });
                            }, 0);
                            
                            //div1 내용 변경
                            var div1 = document.getElementById('div1');
                            var content2
                            content2 = "<div class='row'>"
                            content2 += "<div class='col'>"
                            content2 += "<h5 class='card-title text-uppercase text-muted mb-0'>" + title + "</h5>"
                            content2 += "<span class='h2 font-weight-bold mb-0'>" + toiletType + "</span>"
                            content2 += "</div>"
                            content2 += "</div>"
                            content2 += "<p class='mt-3 mb-0 text-muted text-sm'>"
                            content2 += "<span class='text-success'><i class='fa fa-arrow-up'></i> 변화량</span> <span class='text-nowrap mr-2'>별점평균</span>"
                            content2 += "<span class='text-success'><i class='fa fa-arrow-up'></i> 변화량</span> <span class='text-nowrap'>청결도평균</span>"
                            content2 += "</p>"
                            content2 += "<p class='mt-1 mb-0 text-muted text-sm'>"
                            content2 += "<span class='text-success'><i class='fa fa-arrow-up'></i> 변화량</span> <span class='text-nowrap'>이용자수</span>"
                            content2 += "<input class='replyButton3 ml-1' type='button' value='리뷰 목록' onclick='location.href=\"/brr/review/reviewMain?toiletTitle=" + title + "\"'>"

                            var id =
<%=(String) session.getAttribute("sessionId")%>
    ;
                            //리뷰쓰기
                            content2 += "<input class='replyButton3 ml-1' type='button' value='리뷰 쓰기' onclick='reviewWrite(" + "\"" + title + "\"," + "\"" + id + "\")'>"
                            content2 += "</p>"

                            div1.innerHTML = content2;
                        }
                    }(toiletMarker, i, title));
        }//마커생성 for[E]
        /*  (function looper (i) {
         	setTimeout(function() {
         	    tDistance1 = tDistance;
         	    console.log(i)
                 directions(nearbyToilet[i].lng, nearbyToilet[i].lat)

                 if(tDistance1 > tDistance){
                     shortestDistance = toiletMarker;
                 }
         		if ( nearbyToilet.length < ++i )
         			looper (i);
         	}, 0)
         })(0);
          
         shortFlag = 0;*/
    }//setPositions[E]
    
    function reviewWrite (title, id) {
        var review = document.getElementById("review");
        $("#review-container").show();
        $("#review").fadeIn();
        /*   var content = "<div style='background-color: black; position: fixed; width: 10000px; height: 10000px; opacity: 60%; z-index: 998;'>야</div>"
          content += "<div style='background-color: white; position: fixed; width: 35rem; height: 40rem; z-index: 999;'>"
          content += "<input type='text'>"
          content += "</div>"
          review.innerHTML = content */

        //location.href=\"/brr/reivew/reviewWrite?toiletTitle=" + title + "&id=" + id + "\"
    }
    function myLocation () {
        // HTML5의 geolocation으로 사용할 수 있는지 확인합니다      
        if(navigator.geolocation){
            navigator.geolocation
                    .getCurrentPosition(function (position) {
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
                            success : function (e) {
                                if(locationFlag == 0){
                                    locationFlag = 1;
                                    setPositions(e, marker);
                                }
                            },
                            error : function (e) {
                                console.log(e)
                            }
                        })

                        //팝업 생성
                        var content = "<div style='min-width:max-content;'>"
                        content += "<div style=' position: relative; border-bottom: 1px solid #dcdcdc; line-height: 18px; padding: 0 35px 2px 0;'>"
                        content += "<div style='font-size: 12px; line-height: 15px;'>"
                        content += "<i class='ni ni-user-run'></i>"
                        content += "<span style='display: inline-block; width: 14px; height: 14px; vertical-align: middle; margin-right: 5px;'></span>Your location"
                        content += "</div>"
                        content += "</div>"
                        content += "</div>"

                        console.log(marker)
                        setTimeout(function () {
                            marker.setMap(null)
                        }, 0);
                        setTimeout(function () {
                            marker = new Tmapv2.Marker({
                                position : new Tmapv2.LatLng(lat, lng),
                                icon : "<c:url value = '/resources/img/redmarker32.png'/>",
                                map : map
                            });
                        }, 0);
                        
                        setTimeout(function () {
                            myWindow.setMap(null)
                        }, 0);
                        setTimeout(function () {
                            myWindow = new Tmapv2.InfoWindow({
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
    
    function terminators () {
        clearInterval(realTime);
        polyline_.setMap(null)
        destinyWindow.setMap(null);
    }

    //실시간길찾기
    function navigators (endX, endY, title, toiletType, toiletBowlNumber, handicap) {
        var id =
<%=(String) session.getAttribute("sessionId")%>
    ;
        //DB에 정보저장, title값 필요
        if(id != null){
            $.ajax({
                url : "<c:url value='/dayaver/searchedToilet'/>",
                data : {
                    toiletnm : title,
                    id : id,
                    lng : endX,
                    lat : endY
                },
                type : "GET",
                success : function () {
                    console.log("화장실검색정보 저장성공 id : " + id);
                },
                error : function (e) {
                    console.log("화장실검색정보 저장실패");
                    alert(JSON.stringify(e));
                }
            });
        }
        clearInterval(realTime);
        var content = "<div style='min-width:max-content;'>"
        content += "<h5 class='card-title text-uppercase text-muted mb-0'>" + toiletType + "</h5>"
        content += "<br'><span class='card-title text-uppercase text-muted mb-0'>대변기 : " + toiletBowlNumber + "</span>"
        content += "<br><span class='card-title text-uppercase text-muted mb-0'>장애인 배려실 : " + handicap + "</span>"
        content += "<br><input class='replyButton3 mt-1' type='button' id='direction[" + i + "]' value='길찾기 중단' onclick='terminators()'>";
        content += "<div style='display:inline-block; margin-left:5px; text-decoration: underline; '>" + distime + "</div>";
        content += "</div>"

        targetWindow.setMap(null);
        
        setTimeout(function () {
            destinyWindow.setMap(null);
        }, 0);
        setTimeout(function () {
            destinyWindow = new Tmapv2.InfoWindow({
                position : new Tmapv2.LatLng(endY, endX),
                content : content,
                type : 1,
                map : map
            });
        }, 0);
        /*  setTimeout(function () {
             targetWindow.setMap(null)
         }, 0);
         setTimeout(function () {
             targetWindow = new Tmapv2.InfoWindow({
                 position : new Tmapv2.LatLng(endX, endY),
                 content : content,
                 type : 1,
                 map : map
             });
         }, 0); */

        //실시간 길찾기
        realTime = setInterval(function () {
            
            myLocation();
            distime = directions(endX, endY);
            console.log("네비게이터 실행중")
        }, 5000);
        
    }

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
    
    function resize (obj) {
        obj.style.height = "1px";
        obj.style.height = ( 12 + obj.scrollHeight ) + "px";
    }
</script>
</head>
<body class="" onload="initTmap()">

	<!--  var content = "<div style='background-color: black; position: fixed; width: 10000px; height: 10000px; opacity: 60%; z-index: 998;'>야</div>"
          content += "<div style='background-color: white; position: fixed; width: 35rem; height: 40rem; z-index: 999;'>"
          content += "<input type='text'>"
          content += "</div>"
          review.innerHTML = content 

        //location.href=\"/brr/reivew/reviewWrite?toiletTitle=" + title + "&id=" + id + "\" -->
	<div id="review-container"></div>
	<div id="review" class="col-xl-4">
		<form action="review/reviewWrite" onsubmit="return reviewCheck()">
			<div class="card shadow">
				<div class="card-header bg-transparent">
					<div class="row align-items-center">
						<div class="col">
							<h2 class="mb-0" style="display: inline-block">화장실 이름</h2>
							<input id="x-button" class="btn btn-sm btn-primary" value="X" onclick='$("#review").hide(), $("#review-container").fadeOut()'>
							<a href="#!" id="register" class="btn btn-sm btn-primary">Register</a>
							<h6 id="review-ment" class="text-uppercase text-muted ls-1 mb-1">당신의 리뷰가 다른 사람들에게 도움이 될 거에요!</h6>
						</div>
					</div>
				</div>
				
				<div class="card-body2">
					<div class="col-xl-12 col-lg-6">
						<div class="card card-stats mb-4 mb-xl-0">
							<textarea class="card-body3 replyButton2" id="reviews" onkeydown="resize(this)" onkeyup="resize(this)" style="resize: none;"></textarea>
							<div class="row">
								<div class="col mt-2">
									<span id="" class="h2 font-weight mb-0">별점<img id="star1" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"><img id="star2" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"><img id="star3" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"><img id="star4" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"><img id="star5" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>">
									</span> <span id="clean" class="h2 font-weight mb-0">청결도<img id="clean1" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"><img id="clean2" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"><img id="clean3" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"><img id="clean4" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"><img id="clean5" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"></span>
								</div>
							</div>
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
								<i class="ni ni-single-02 text-yellow"></i> User profile
							</a></li>
						<li class="nav-item"><a class="nav-link" href="<c:url value="/member/logout"/>">
								<i class="ni ni-key-25 text-info"></i> Logout
							</a></li>
						<!-- 네이버 로그인 시 -->
						<c:if test="${sessionScope.sessionNickname != null}">
							<li class="nav-item"><a class="nav-link " href="<c:url value="/member/deleteNaver"/>">
									<i class="ni ni-bullet-list-67 text-red"></i> Naver탈퇴
								</a></li>
						</c:if>
						<!-- 구글 로그인 시 -->
						<c:if test="${sessionScope.sessionNickname == null}">
							<li class="nav-item"><a class="nav-link " href="<c:url value="/member/deleteGoogle"/>">
									<i class="ni ni-bullet-list-67 text-red"></i> Google탈퇴
								</a></li>
						</c:if>
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
					<li class="nav-item"><a class="nav-link" href="https://demos.creative-tim.com/argon-dashboard/docs/components/alerts.html">
							<i class="ni ni-send text-blue"></i> <span>Send Feedback</span>
						</a></li>
				</ul>
				<ul class="navbar-nav">
					<li class="nav-item active active-pro"><a class="nav-link" href="<c:url value="/maps/mapsMain2"/>">
							<i class="ni ni-bus-front-12"></i> Google Maps (Beta)
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
				<a class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block" href="<c:url value="/maps/mapsMain"/>">Maps</a>
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
		<div class="header bg-gradient-primary pb-7 pt-5 pt-md-8">
			<div class="container-fluid">
				<div class="header-body">
					<input class='replyButton1 ml-1' type='button' value='최단거리' onclick='searchShortest()'> <input class='replyButton1 ml-0' type='button' value='최고 평가' onclick='searchRating()'> <input class='replyButton1 ml-0' type='button' value='최고 청결도' onclick='searchClan()'> <input class='replyButton1 ml-0' type='button' value='최대 원활도' onclick='searchSmooth()'>
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
					</div>
				</div>
			</div>

			<!-- Header -->
			<div class="header pb-7 pt-5">
				<div class="container-fluid">
					<div class="header-body">
						<!-- Card stats -->
						<div class="row">
							<div class="col-xl-3 col-lg-6">
								<div class="card card-stats mb-4 mb-xl-0">
									<div class="card-body3 replyButton2" id="div1">
										<div class="row">
											<div class="col">
												<h5 class="card-title text-uppercase text-muted mb-0">화장실을 선택하세요...</h5>
												<span class="h2 font-weight-bold mb-0">DEFAULT</span>
											</div>
										</div>
										<p class="mt-3 mb-0 text-muted text-sm">
											<span class="text-success"><i class="fa fa-arrow-up"></i> 변화량</span> <span class="text-nowrap mr-2">별점평균</span> <span class="text-success"><i class="fa fa-arrow-up"></i> 변화량</span> <span class="text-nowrap">청결도평균</span>
										</p>
										<p class="mt-2 mb-0 text-muted text-sm">
											<span class="text-warning"><i class="fa fa-arrow-down"></i> 변화량</span> <span class="text-nowrap">이용자수</span>
										</p>
									</div>
								</div>
							</div>
							<div class="col-xl-3 col-lg-6">
								<div class="card card-stats mb-4 mb-xl-0">
									<div class="card-body3 replyButton2" id="div2">
										<div class="row">
											<div class="col-8 pr-0" style="float: left;">
												<!-- <h5 class="card-title text-uppercase text-muted mb-0">Title</h5> -->
												<span class="card-title text-sm text-muted mb-0">Default Review</span>
												<!-- <span class="h2 font-weight-bold mb-0">Contents</span> -->
											</div>
											<div class="col-4" style="text-align: center; float: right;">
												<p class="mt-0 mb-3 text-muted text-sm">
													<span class="text-success">4.0</span><span class="text-nowrap mr-2 ml-2">별점</span> <br> <span class="text-danger">3.5</span><span class="text-nowrap mr-2 ml-2">청결도</span>
												</p>
												<div class="icon icon-shape bg-warning text-white rounded-circle shadow" style="display: inline-block;">
													<!-- <i class="fas fa-chart-pie"></i> -->
												</div>
												<h5 class="card-title text-uppercase text-muted mb-0 mt-0">Nickname</h5>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-xl-3 col-lg-6">
								<div class="card card-stats mb-4 mb-xl-0">
									<div class="card-body3 replyButton2" id="div3">
										<div class="row">
											<div class="col-8 pr-0">
												<!-- <h5 class="card-title text-uppercase text-muted mb-0">Title</h5> -->
												<span class="card-title  text-sm text-muted mb-0">Default Review</span>
												<!-- <span class="h2 font-weight-bold mb-0">Contents</span> -->
											</div>
											<div class="col-4" style="text-align: center;">
												<p class="mt-0 mb-3 text-muted text-sm">
													<span class="text-success">4.0</span><span class="text-nowrap mr-2 ml-2">별점</span> <br> <span class="text-danger">3.5</span><span class="text-nowrap mr-2 ml-2">청결도</span>
												</p>
												<div class="icon icon-shape bg-warning text-white rounded-circle shadow" style="display: inline-block;">
													<!-- <i class="fas fa-chart-pie"></i> -->
												</div>
												<h5 class="card-title text-uppercase text-muted mb-0 mt-0">Nickname</h5>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-xl-3 col-lg-6">
								<div class="card card-stats mb-4 mb-xl-0">
									<div class="card-body3 replyButton2" id="div4">
										<div class="row">
											<div class="col-8 pr-0">
												<!-- <h5 class="card-title text-uppercase text-muted mb-0">Title</h5> -->
												<span class="card-title text-sm text-muted mb-0">Default Review</span>
												<!-- <span class="h2 font-weight-bold mb-0">Contents</span> -->
											</div>
											<div class="col-4" style="text-align: center;">
												<p class="mt-0 mb-3 text-muted text-sm">
													<span class="text-success">4.0</span><span class="text-nowrap mr-2 ml-2">별점</span> <br> <span class="text-danger">3.5</span><span class="text-nowrap mr-2 ml-2">청결도</span>
												</p>
												<div class="icon icon-shape bg-warning text-white rounded-circle shadow" style="display: inline-block;">
													<!-- <i class="fas fa-chart-pie"></i> -->
												</div>
												<h5 class="card-title text-uppercase text-muted mb-0 mt-0">Nickname</h5>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- <div class="col-xl-3 col-lg-6">
								<div class="card card-stats mb-4 mb-xl-0">
									<div class="card-body replyButton2">
										<div class="row">
											<div class="col">
												<h5 class="card-title text-uppercase text-muted mb-0">Title</h5>
												<span class="h2 font-weight-bold mb-0">Contents</span>
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
									<div class="card-body replyButton2">
										<div class="row">
											<div class="col">
												<h5 class="card-title text-uppercase text-muted mb-0">Title</h5>
												<span class="h2 font-weight-bold mb-0">Contents</span>
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
							</div> -->
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
	</div>
	<!--   Core   -->
	<script src="<c:url value="/resources/assets/js/plugins/jquery/dist/jquery.min.js"/>"></script>
	<script src="<c:url value="/resources/assets/js/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"/>"></script>

</body>

</html>