<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx4afb1a7c147445528d8e83f3f1d4fea0"></script>

<script src="<c:url value="/resources/js/jquery-3.4.1.js/"/>"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" integrity="sha256-R4pqcOYV8lt7snxMQO/HSbVCFRPMdrhAFMH+vr9giYI=" crossorigin="anonymous"></script>
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

<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../resources/css/hover.css">

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
		var reviewList = [ ];
		var polyFlag = 0;
		var locationFlag = 0;
		var starFlag = 0;
		var changeRate, averageRate, starAver, cleanAver, starDiffer, cleanDiffer; 
    //var shortFlag = 1;
    //대변 체크 결과
    var diaryGraphInfo = 
        function(stress, moisture, ingredient,status)	
        {
        	this.stress = stress;
        	this.moisture = moisture;
        	this.ingredient = ingredient;
        	this.status = status
        	return this;
        }

    var diaryPictureArray=
    [
    "../resources/img/normal.png",
    "../resources/img/dangerous.png",
    "../resources/img/dangerous.png",
    "../resources/img/normal.png",
    
    "../resources/img/good.png",
    "../resources/img/dangerous.png",
    "../resources/img/dangerous.png",
    "../resources/img/normal.png",
    
    "../resources/img/normal.png",
    "../resources/img/dangerous.png",
    "../resources/img/dangerous.png",
    "../resources/img/normal.png",
    
    "../resources/img/normal.png",
    "../resources/img/dangerous.png",
    "../resources/img/sobad.png",
    "../resources/img/normal.png"
    ];

    var diaryGraphInfoArray=
        [
            new diaryGraphInfo(3, 1, 2, 3),
            new diaryGraphInfo(5, 1, 3, 2),
            new diaryGraphInfo(4, 2, 2, 2),
            new diaryGraphInfo(4, 1.5, 0.5, 3),
            
            new diaryGraphInfo(0, 5, 5, 4 ),
            new diaryGraphInfo(2, 1, 1, 2),
            new diaryGraphInfo(3, 2, 2, 2),
            new diaryGraphInfo(2, 2, 3, 3),

            new diaryGraphInfo(3, 0.9, 2, 3),            
            new diaryGraphInfo(3, 1.9, 2, 2),
            new diaryGraphInfo(3, 1, 1, 2),
            new diaryGraphInfo(0.9, 1, 2, 3),

            new diaryGraphInfo(2, 4, 4, 3),
            new diaryGraphInfo(4, 1, 2, 2),
            new diaryGraphInfo(5, 0.5, 0.5, 1),
            new diaryGraphInfo(1, 1, 2, 3)            
        ];    			

    var diaryresult="";
    var result_show_flag=true;
    var diaryDescriptionArray=
    	[
    	"<p>영양소는 적당하지만,<Strong>변비</Strong> 증세가 있네요.<br>수분섭취와 스트레스를 줄여보세요.</p> ",
    	"<p> 장건강의 이상으로 색깔이 변이될 수 있어요.<br><strong>악취</strong>가 나는 경우에는 진단을 받아 볼 필요가 있습니다.</p> ",
    	"<p>치질처럼 항문 부근의<strong> 출혈</strong>이 있을수도 있습니다.<br>가까운 병원에서 진단을 받아보세요.</p> ",
    	"<p><strong>영양부족</strong>으로 인한 색깔의 변이 혹은 변비의 전조증상입니다<br>충분한 영양과 수분을 섭취해주세요.</p> ",

    	"<p> 색깔도 모양도 완벽해요.<br>당신의 대변 건강은 <strong>최고</strong>입니다.</p>",
    	"<p>모양은 완벽!<strong>담즙</strong>의 흡수도에 따라 색이 흐려보일 수 있습니다.<br>색이 지속된다면 병원의 진찰을 받아보세요..</p>",
    	"<p>모양은 완벽! 그러나 출혈 증상이 있습니다.<br><strong>항문</strong>질환을 의심해봐야 합니다.</p>",
    	"<p>불규칙한 영양분의 흡수나, 먹은 음식에 따라 색깔이 노란빛을 띌 수 있습니다.</p>",

    	"<p><strong>변비</strong> 증상이 있습니다.<br>채소나 과일의 섭취를 늘려주세요 !</p>",
    	"<p>변비 증상과 장 속의 흡수문제는 <strong>큰 질환</strong>으로 이어질 수 있습니다.<br>가까운 병원에 진찰을 받아보세요.</p>",
    	"<p>수분이 부족하여, 딱딱한 덩어리로 인한 <strong>출혈</strong> 등이 있을 수 있습니다<br>수시로 물과 섬유질을 섭취해 주세요</p>",
    	"<p>규칙적인 영양분 섭취로 변비와 색을 개선해보세요.</p>",

    	"<p>과식하셨나요? 휴식을 취하는 것이 필요해요.</p>",
    	"<p>과한 알코올,지방 섭취의 원인일 수도 있습니다.<br>지속적인 증상이 나타난다면 병원에 진찰을 받아보세요.</p>",
    	"<p>설사와 혈변은 염증성 질환일 수 도 있습니다.<br>가까운 병원에 빠르게 진찰을 받아보세요.</p>",
    	"<p>수분이나 당분,지방을 지나치게 많이 먹어 장이 자극받은 상태입니다.<br>휴식이 필요해요.</p>"
    	];

    function download()
    {
       $.ajax
        ({
            url:"<c:url value="/checkRecv"/>",
            dataType:"text",
            success:
                function(flag)
                {
                	if(flag=="do_not_need")
                    {
                        alert("최신 데이터 입니다. 다운로드가 필요없습니다.");
                    }
                	else if(flag=="need")
                    {
                		alert("데이터가 부족합니다, 다운로드가 필요합니다.");
                		location.href="<c:url value='/toilet/toiletRecv'/>";
                    }
                	else return;
                }
            ,
       		error:
           		function()
           		{
           			console.log("다운로드 함수 실행 실패");
           		}
        });
    }
    
    function hover(){
        //별 초기화
        $("#star5").attr("src", "<c:url value='/resources/img/starOff.png'/>");
		$("#star4").attr("src", "<c:url value='/resources/img/starOff.png'/>");
		$("#star3").attr("src", "<c:url value='/resources/img/starOff.png'/>");
		$("#star2").attr("src", "<c:url value='/resources/img/starOff.png'/>");
		$("#star1").attr("src", "<c:url value='/resources/img/starOff.png'/>");
		$("#clean5").attr("src", "<c:url value='/resources/img/starOff.png'/>");
		$("#clean4").attr("src", "<c:url value='/resources/img/starOff.png'/>");
		$("#clean3").attr("src", "<c:url value='/resources/img/starOff.png'/>");
		$("#clean2").attr("src", "<c:url value='/resources/img/starOff.png'/>");
		$("#clean1").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        //별점 호버이벤트
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
        
        //청결도 호버이벤트
        $("#clean5").hover(
        	function(){
        		$("#clean5").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean4").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean3").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        	}, 
        	function(){
        		$("#clean5").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean4").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean3").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean2").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean1").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        	}) 
        
        $("#clean4").hover(
        	function(){
        		$("#clean4").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean3").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        	}, 
        	function(){
        		$("#clean4").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean3").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean2").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean1").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        	}) 
        
        $("#clean3").hover(
        	function(){
        		$("#clean3").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        	}, 
        	function(){
        		$("#clean3").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean2").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean1").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        	}) 
        $("#clean2").hover(
        	function(){
        		$("#clean2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        	}, 
        	function(){
        		$("#clean2").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean1").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        	}) 
        $("#clean1").hover(
        	function(){
        		$("#clean1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        	}, 
        	function(){
        		$("#clean1").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        	}) 
    }
    
    $(function () {
        
        setTimeout(function(){
            window.myWidgetParam ? window.myWidgetParam : window.myWidgetParam = []; 
    		window.myWidgetParam.push({id: 18,cityid: '1835848',appid: 'c08b376c4c1ca3b5e593c4991d91eb3c',
    		units: 'metric',containerid: 'openweathermap-widget-18',  });  
    		(function() {var script = document.createElement('script');script.async = true;script.charset = "utf-8";
    			script.src = "//openweathermap.org/themes/openweathermap/assets/vendor/owm/js/weather-widget-generator.js";
    				var s = document.getElementsByTagName('script')[0];s.parentNode.insertBefore(script, s);  })();
        },1000)
    	
    	console.log("여기 안에서는? : "+ ${sessionScope.DownFlag});
    	if(${sessionScope.DownFlag})
        {
    		download();   		
        }
    	
    	
    	
    	// type모양별 체크시 각 함수를 다르게 지정해서 건강진단을 함    
    	$("#type1").on
    	(
    		"click",
    		clickFunc
    		);	
    	$("#type2").on
    	(
    		"click",
    		clickFunc
    		);	
    	$("#type3").on
    	(
    		"click",
    		clickFunc
    		);	
    	$("#type4").on
    	(
    		"click",
    		clickFunc
    		);	
    	
        //별점
        $("#star5").on("click",
        	function (){
        		$("#star5").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#star4").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#star3").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#star2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#star1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#star").val(5);
        		$("#star1").unbind('mouseenter mouseleave');
        		$("#star2").unbind('mouseenter mouseleave');
        		$("#star3").unbind('mouseenter mouseleave');
        		$("#star4").unbind('mouseenter mouseleave');
        		$("#star5").unbind('mouseenter mouseleave');
        	})
        $("#star4").on("click",
        	function(){
        		$("#star5").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#star4").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#star3").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#star2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#star1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#star").val(4);
        		$("#star1").unbind('mouseenter mouseleave');
        		$("#star2").unbind('mouseenter mouseleave');
        		$("#star3").unbind('mouseenter mouseleave');
        		$("#star4").unbind('mouseenter mouseleave');
        		$("#star5").unbind('mouseenter mouseleave');
        	})
        $("#star3").on("click",
        	function(){
        		$("#star5").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#star4").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#star3").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#star2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#star1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#star").val(3);
        		$("#star1").unbind('mouseenter mouseleave');
        		$("#star2").unbind('mouseenter mouseleave');
        		$("#star3").unbind('mouseenter mouseleave');
        		$("#star4").unbind('mouseenter mouseleave');
        		$("#star5").unbind('mouseenter mouseleave');
        	})
        $("#star2").on("click",
        	function(){
        		starFlag=0;
        		$("#star5").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#star4").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#star3").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#star2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#star1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#star").val(2);
        		$("#star1").unbind('mouseenter mouseleave');
        		$("#star2").unbind('mouseenter mouseleave');
        		$("#star3").unbind('mouseenter mouseleave');
        		$("#star4").unbind('mouseenter mouseleave');
        		$("#star5").unbind('mouseenter mouseleave');
        	})
        $("#star1").on("click",
        	function(){
        		starFlag=0;
        		$("#star5").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#star4").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#star3").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#star2").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#star1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#star").val(1);
        		$("#star1").unbind('mouseenter mouseleave');
        		$("#star2").unbind('mouseenter mouseleave');
        		$("#star3").unbind('mouseenter mouseleave');
        		$("#star4").unbind('mouseenter mouseleave');
        		$("#star5").unbind('mouseenter mouseleave');
        	})
        //청결도
        $("#clean5").on("click",
        	function (){
        		$("#clean5").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean4").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean3").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean").val(5);
        		$("#clean1").unbind('mouseenter mouseleave');
        		$("#clean2").unbind('mouseenter mouseleave');
        		$("#clean3").unbind('mouseenter mouseleave');
        		$("#clean4").unbind('mouseenter mouseleave');
        		$("#clean5").unbind('mouseenter mouseleave');
        	})
        $("#clean4").on("click",
        	function(){
        		$("#clean5").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean4").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean3").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean").val(4);
        		$("#clean1").unbind('mouseenter mouseleave');
        		$("#clean2").unbind('mouseenter mouseleave');
        		$("#clean3").unbind('mouseenter mouseleave');
        		$("#clean4").unbind('mouseenter mouseleave');
        		$("#clean5").unbind('mouseenter mouseleave');
        	})
        $("#clean3").on("click",
        	function(){
        		$("#clean5").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean4").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean3").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean").val(3);
        		$("#clean1").unbind('mouseenter mouseleave');
        		$("#clean2").unbind('mouseenter mouseleave');
        		$("#clean3").unbind('mouseenter mouseleave');
        		$("#clean4").unbind('mouseenter mouseleave');
        		$("#clean5").unbind('mouseenter mouseleave');
        	})
        $("#clean2").on("click",
        	function(){
        		$("#clean5").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean4").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean3").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean2").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean").val(2);
        		$("#clean1").unbind('mouseenter mouseleave');
        		$("#clean2").unbind('mouseenter mouseleave');
        		$("#clean3").unbind('mouseenter mouseleave');
        		$("#clean4").unbind('mouseenter mouseleave');
        		$("#clean5").unbind('mouseenter mouseleave');
        	})
        $("#clean1").on("click",
        	function(){
        		$("#clean5").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean4").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean3").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean2").attr("src", "<c:url value='/resources/img/starOff.png'/>");
        		$("#clean1").attr("src", "<c:url value='/resources/img/starOn.png'/>");
        		$("#clean").val(1);
        		$("#clean1").unbind('mouseenter mouseleave');
        		$("#clean2").unbind('mouseenter mouseleave');
        		$("#clean3").unbind('mouseenter mouseleave');
        		$("#clean4").unbind('mouseenter mouseleave');
        		$("#clean5").unbind('mouseenter mouseleave');
        	})
        	
       hover();
    })//window.onload[E]

function reviewRefresh(lng, lat){
	$.ajax({
		url: "<c:url value='/review/reviewList'/>",
		data: {
			lng: lng,
			lat: lat
		},
		type: "post",
		success: function(e){
			reviewList = e
			
			var reviews0 = document.getElementById("reviews-0");
			var reviews1 = document.getElementById("reviews-1");
			var reviews2 = document.getElementById("reviews-2");
			var starreview0 = document.getElementById("star-review-0");
			var starreview1 = document.getElementById("star-review-1");
			var starreview2 = document.getElementById("star-review-2");
			var cleanreview0 = document.getElementById("clean-review-0");
			var cleanreview1 = document.getElementById("clean-review-1");
			var cleanreview2 = document.getElementById("clean-review-2");
			var nickreview0 = document.getElementById("nick-review-0");
			var nickreview1 = document.getElementById("nick-review-1");
			var nickreview2 = document.getElementById("nick-review-2");
			var profilereview0 = document.getElementById("profile-review-0");
			var profilereview1 = document.getElementById("profile-review-1");
			var profilereview2 = document.getElementById("profile-review-2");
			
			switch(reviewList.length){
				case 0:
				reviews0.innerHTML = "당신의 리뷰를 들려주세요";
				reviews1.innerHTML = "당신의 리뷰를 들려주세요";
				reviews2.innerHTML = "당신의 리뷰를 들려주세요";
				starreview0.innerHTML = "";
				starreview1.innerHTML = "";
				starreview2.innerHTML = "";
				cleanreview0.innerHTML = "";
				cleanreview1.innerHTML = "";
				cleanreview2.innerHTML = "";
				nickreview0.innerHTML = "NICKNAME";
				nickreview1.innerHTML = "NICKNAME";
				nickreview2.innerHTML = "NICKNAME"; 
				profilereview0.innerHTML = "<div class='icon icon-shape bg-warning text-white rounded-circle shadow' style='display: inline-block;'></div>"
				profilereview1.innerHTML = "<div class='icon icon-shape bg-warning text-white rounded-circle shadow' style='display: inline-block;'></div>"
				profilereview2.innerHTML = "<div class='icon icon-shape bg-warning text-white rounded-circle shadow' style='display: inline-block;'></div>"
				break;
				case 1:
				reviews0.innerHTML = reviewList[0].review;
				reviews1.innerHTML = "당신의 리뷰를 들려주세요";
				reviews2.innerHTML = "당신의 리뷰를 들려주세요";
				if(reviewList[0].star>2)
					$("#star-review-0").attr("class", "text-success");
				else
					$("#star-review-0").attr("class", "text-warning");
				starreview0.innerHTML = reviewList[0].star;
				starreview1.innerHTML = "";
				starreview2.innerHTML = "";
				if(reviewList[0].clean>2)
					$("#clean-review-0").attr("class", "text-success");
				else
					$("#clean-review-0").attr("class", "text-warning");
				cleanreview0.innerHTML = reviewList[0].clean;
				cleanreview1.innerHTML = "";
				cleanreview2.innerHTML = "";
				nickreview0.innerHTML = reviewList[0].sessionNickname;
				nickreview1.innerHTML = "NICKNAME";
				nickreview2.innerHTML = "NICKNAME"; 
				profilereview0.innerHTML = "<span class='avatar avatar-sm rounded-circle'> <img alt='Image placeholder' src='<c:url value='" + reviewList[0].profile + "'/>'></span>"
				profilereview1.innerHTML = "<div class='icon icon-shape bg-warning text-white rounded-circle shadow' style='display: inline-block;'></div>"
				profilereview2.innerHTML = "<div class='icon icon-shape bg-warning text-white rounded-circle shadow' style='display: inline-block;'></div>"
				break;
				case 2:
				reviews0.innerHTML = reviewList[0].review;
				reviews1.innerHTML = reviewList[1].review;
				reviews2.innerHTML = "당신의 리뷰를 들려주세요";
				if(reviewList[0].star>2)
					$("#star-review-0").attr("class", "text-success");
				else
					$("#star-review-0").attr("class", "text-warning");
				if(reviewList[1].star>2)
					$("#star-review-1").attr("class", "text-success");
				else
					$("#star-review-1").attr("class", "text-warning");
				starreview0.innerHTML = reviewList[0].star;
				starreview1.innerHTML = reviewList[1].star;
				starreview2.innerHTML = "";
				if(reviewList[0].clean>2)
					$("#clean-review-0").attr("class", "text-success");
				else
					$("#clean-review-0").attr("class", "text-warning");
				if(reviewList[1].clean>2)
					$("#clean-review-1").attr("class", "text-success");
				else
					$("#clean-review-1").attr("class", "text-warning");
				cleanreview0.innerHTML = reviewList[0].clean;
				cleanreview1.innerHTML = reviewList[1].clean
				cleanreview2.innerHTML = "";
				nickreview0.innerHTML = reviewList[0].sessionNickname;
				nickreview1.innerHTML = reviewList[1].sessionNickname;
				nickreview2.innerHTML = "NICKNAME"; 
				profilereview0.innerHTML = "<span class='avatar avatar-sm rounded-circle'> <img alt='Image placeholder' src='<c:url value='" + reviewList[0].profile + "'/>'></span>"
				profilereview1.innerHTML = "<span class='avatar avatar-sm rounded-circle'> <img alt='Image placeholder' src='<c:url value='" + reviewList[1].profile + "'/>'></span>"
				profilereview2.innerHTML = "<div class='icon icon-shape bg-warning text-white rounded-circle shadow' style='display: inline-block;'></div>"                                                                          
				break;
				case 3:
				reviews0.innerHTML = reviewList[0].review;
				reviews1.innerHTML = reviewList[1].review;
				reviews2.innerHTML = reviewList[2].review;
				if(reviewList[0].star>2)
					$("#star-review-0").attr("class", "text-success");
				else
					$("#star-review-0").attr("class", "text-warning");
				if(reviewList[1].star>2)
					$("#star-review-1").attr("class", "text-success");
				else
					$("#star-review-1").attr("class", "text-warning");
				if(reviewList[2].star>2)
					$("#star-review-2").attr("class", "text-success");
				else
					$("#star-review-2").attr("class", "text-warning");
				starreview0.innerHTML = reviewList[0].star;
				starreview1.innerHTML = reviewList[1].star;
				starreview2.innerHTML = reviewList[2].star;
				if(reviewList[0].clean>2)
					$("#clean-review-0").attr("class", "text-success");
				else
					$("#clean-review-0").attr("class", "text-warning");
				if(reviewList[1].clean>2)
					$("#clean-review-1").attr("class", "text-success");
				else
					$("#clean-review-1").attr("class", "text-warning");
				if(reviewList[2].clean>2)
					$("#clean-review-2").attr("class", "text-success");
				else
					$("#clean-review-2").attr("class", "text-warning");
				cleanreview0.innerHTML = reviewList[0].clean;
				cleanreview1.innerHTML = reviewList[1].clean;
				cleanreview2.innerHTML = reviewList[2].clean;
				nickreview0.innerHTML = reviewList[0].sessionNickname;
				nickreview1.innerHTML = reviewList[1].sessionNickname;
				nickreview2.innerHTML = reviewList[2].sessionNickname;
				profilereview0.innerHTML = "<span class='avatar avatar-sm rounded-circle'> <img alt='Image placeholder' src='<c:url value='" + reviewList[0].profile + "'/>'></span>"
				profilereview1.innerHTML = "<span class='avatar avatar-sm rounded-circle'> <img alt='Image placeholder' src='<c:url value='" + reviewList[1].profile + "'/>'></span>"
				profilereview2.innerHTML = "<span class='avatar avatar-sm rounded-circle'> <img alt='Image placeholder' src='<c:url value='" + reviewList[2].profile + "'/>'></span>"                                          
				break;
                } //switch[E]
            	//이런 변화된내용을 즉시 적용하려면? 이 스위치를 비동기로??
            }//success[E]
        })//ajax[E]

    }//reviewRefresh[E]
    
    //리뷰등록 검사
    function reviewCheck(){
        //청결도, 별점입력했는지
        var toiletNm = document.getElementById("toiletNm").value
        var toiletType = document.getElementById("toiletType").value
        var lng = document.getElementById("lng").value
        var lat = document.getElementById("lat").value
        var sessionId = document.getElementById("sessionId").value
        var sessionNickname = document.getElementById("sessionNickname").value
        var Profile = document.getElementById("Profile").value
        var review = document.getElementById("review-area").value
        var star = document.getElementById("star").value
        var clean = document.getElementById("clean").value
        var id = <%=(String) session.getAttribute("sessionId")%>;
        if(id==null){
        	var result= confirm("로그인이 필요합니다. 로그인하시겠습니까?")
        	if(result){
        		location.href="<c:url value='/member/login'/>"
        		return;
        	}
        	else
        		return;
        }
        
        //몇글자이상 등록해야됨
        if(review.length<10){
        	alert("리뷰는 10자이상 적어주세요");
        	return;
        }
        if(review.length>100){
        	alert("리뷰는 100자 이내료 적어주세요");
        	return;
        }
        if(star.length<1){
        	alert("별점을 등록해주세요");
        	return;
        }
        if(clean.length<1){
        	alert("청결도를 등록해주세요");
        	return;
        }
        //리뷰등록
        $.ajax({
        	url : "<c:url value='/review/reviewWrite'/>",
        	data : {
        		toiletNm: toiletNm,
        		lng: lng,
        		lat: lat,
        		sessionId: sessionId,
        		sessionNickname: sessionNickname,
        		Profile: Profile,
        		review: review,
        		star: star,
        		clean: clean
        	},
        	type : "post",
        	success: function(e){
        	    $.ajax({
                    url: "<c:url value='/review/reviewAver'/>",
                    data:{
                        lat: lat, 
                        lng: lng
                    },
                    type:"post",
                    success: function(e){
                         $.ajax({
							url : "<c:url value='/dayaver/average'/>",
							type : "POST",
							data : {
								lng : lng, 
								lat : lat
							},
							success : function (res) {
								var changeRate = res.differ;
								var averageRate = res.average;
								changeDiv1(e.starAver, e.cleanAver, e.starDiffer, e.cleanDiffer, toiletNm, toiletType, lat, lng, changeRate, averageRate);
								reviewRefresh(lng, lat);
							},
							error : function (e) {
								console.log(JSON.stringify(e));
							}
						}); 
                    },
                    error: function(e){
                        console.log(e);
                    }
                });
        		
        		$("#review").hide();
        		$("#review-container").fadeOut();  
        		$("#review-area").val("");
        		hover();
        	},
        	error: function(e){
        	    $.ajax({
                    url: "<c:url value='/review/reviewAver'/>",
                    data:{
                        lat: lat, 
                        lng: lng
                    },
                    type:"post",
                    success: function(e){
                         $.ajax({
							url : "<c:url value='/dayaver/average'/>",
							type : "POST",
							data : {
								lng : lng, 
								lat : lat
							},
							success : function (res) {
								var changeRate = res.differ;
								var averageRate = res.average;
								changeDiv1(e.starAver, e.cleanAver, e.starDiffer, e.cleanDiffer, toiletNm, toiletType, lat, lng, changeRate, averageRate);
								reviewRefresh(lng, lat);
							},
							error : function (e) {
								console.log(JSON.stringify(e));
							}
						}); 
                    },
                    error: function(e){
                        console.log(e);
                    }
                });
        		$("#review").hide();
        		$("#review-container").fadeOut();  
        		$("#review-area").val("");
        		console.log("리뷰쓰기 실패");
        		console.log(e);
        		hover();
        	}
        })//리뷰등록[E]
        
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
                        alert('근처 화장실의 리뷰가 없습니다. 첫번째 평가자가 되어주세요!');
                    	console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                    }
                });//ajax[E]

	return distime;
    }//directions[E]
    
    function changeDiv1(starAver, cleanAver, starDiffer, cleanDiffer, title, toiletType, lat, lng, changeRate, averageRate){
        //div1 내용 변경
        var div1 = document.getElementById('div1');
        //예외처리
        if(starAver==undefined)
            starAver = 0;
        if(cleanAver==undefined)
            cleanAver = 0;
        if(starDiffer==undefined)
            starDiffer = 0;
        if(cleanDiffer==undefined)
            cleanDiffer = 0;
        if(averageRate==0){
            changeRate=0;
        }
        var content2
        content2 = "<div class='row'>"
        content2 += "<div class='col'>"
        content2 += "<h5 class='card-title text-uppercase text-muted mb-0'>" + title + "</h5>"
        content2 += "<span class='h2 font-weight-bold mb-0'>" + toiletType + "</span>"
        content2 += "</div>"
        content2 += "</div>"
        content2 += "<p class='mt-3 mb-0 text-muted text-sm'>"
        if(starDiffer<0){
            starDiffer = starDiffer*-1;
            content2 += "<span class='text-nowrap mr-2'>별점: " + starAver + "</span><span class='text-warning'> " + starDiffer + " <i class='fa fa-arrow-down'></i></span>";
        }
        else
        	content2 += "<span class='text-nowrap mr-2'>별점: " + starAver + "</span><span class='text-success'>" + starDiffer + " <i class='fa fa-arrow-up'></i></span>";
        if(cleanDiffer<0){
            cleanDiffer = cleanDiffer*-1;
            content2 += "<span class='text-nowrap ml-4 mr-2'>청결도: " + cleanAver + "</span><span class='text-warning'>" + cleanDiffer + " <i class='fa fa-arrow-down'></i></span>";
        }
        else
            content2 += "<span class='text-nowrap ml-4 mr-2'>청결도: " + cleanAver + "</span><span class='text-success'>" + cleanDiffer + " <i class='fa fa-arrow-up'></i></span>";
        content2 += "</p>";
        content2 += "<p class='mt-1 mb-0 text-muted text-sm'>";
        if(changeRate<0){
        	changeRate = changeRate*-1;
            content2 += " <span class='text-nowrap mr-2'> 사용자: " + averageRate +"</span><span class='text-warning'>" + changeRate + " <i class='fa fa-arrow-down'></i></span>";
        }
        else	
        	content2 += " <span class='text-nowrap mr-2'> 사용자: " + averageRate +"</span><span class='text-success'>" + changeRate + " <i class='fa fa-arrow-up'></i></span>";
        content2 += "<input class='replyButton3 ml-1 pointer' type='button' value='리뷰 목록' onclick='location.href=\"/brr/review/reviewMain?toiletNm=" + title + "\"'>";

        var id = $("#sessionId").val();
        <%-- <%=(String) session.getAttribute("sessionId")%>
        ; --%>
        //리뷰쓰기
        content2 += "<input class='replyButton3 ml-1 pointer' type='button' value='리뷰 쓰기' onclick='reviewWrite(" + "\"" + title + "\"," + "\"" + id + "\"," + "\"" + lng + "\"," + "\"" + lat + "\"," + "\"" + toiletType + "\")'>";
        content2 += "</p>";

        div1.innerHTML = content2;
       
        
       
    }
    
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
                icon : "<c:url value = '/resources/img/toilet36_color_gray.png'/>",
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
                            
                            console.log(marker)
                            //여기까지 마커(내위치) 들어오는것 확인
                            var content = "<div style='min-width:max-content;  z-index:999;'>"
                            content += "<h5 class='card-title text-uppercase text-muted mb-0'>" + toiletType + "</h5>"
                            content += "<br'><span class='card-title text-uppercase text-muted mb-0'>대변기 : " + toiletBowlNumber + "</span>"
                            content += "<br><span class='card-title text-uppercase text-muted mb-0'>장애인 배려실 : " + handicap + "</span>"

                            content += "<br><input class='replyButton3 mt-1 pointer' type='button' id='direction[" + i + "]' value='실시간 길찾기' onclick='navigators(" + endX + ',' + endY + ',' + '"' + title + '"' + ',' + '"' + toiletType + '"' + ',' + '"' + toiletBowlNumber + '"' + ',' + '"' + handicap + '"' + ")'>";
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
                            
                            //별점과 청결도의 평균, 최근2일변화량체크
                             $.ajax({
                                url: "<c:url value='/review/reviewAver'/>",
                                data:{
                                    lat: target._lat, 
                                    lng: target._lng
                                },
                                type:"post",
                                success: function(e){
                                     $.ajax({
        								url : "<c:url value='/dayaver/average'/>",
        								type : "POST",
        								data : {
        									lng : target._lng, 
        									lat : target._lat
        								},
        								success : function (res) {
											var changeRate = res.differ;
											var averageRate = res.average;
											changeDiv1(e.starAver, e.cleanAver, e.starDiffer, e.cleanDiffer, title, toiletType, target._lat, target._lng, changeRate, averageRate);
											reviewRefresh(target._lng, target._lat);
										},
										error : function (e) {
											console.log(JSON.stringify(e));
										}
									}); 
                                },
                                error: function(e){
                                    console.log(e);
                                }
                            });
                            
                            
                        }
                    }(toiletMarker, i, title));
        }//마커생성 for[E]
        
    }//setPositions[E]
    
    function reviewWrite (title, id, lng, lat, toiletType) {
    	document.getElementById("review-toilet").innerHTML=title;
    	$("#review-area").val("");
    	$("#toiletNm").val(title);
    	$("#toiletType").val(toiletType);
    	$("#lng").val(lng);
    	$("#lat").val(lat);
    	$("#review-container").fadeIn();
    	$("#review").fadeIn();
    	hover();
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
    function recommending(toiletVO){
        //누르자마자 경로탐색 > 나중에 경로안내누르면 실시간안내되도록 바꾸기
        distime = directions(toiletVO.lng, toiletVO.lat);
        if(toiletVO.unisexToiletYn == "Y")
        	toiletVO.unisexToiletYn = "남녀공용 ";
        else
        	toiletVO.unisexToiletYn = "남녀별도 ";
        var title = toiletVO.toiletNm;
        var toiletType = toiletVO.unisexToiletYn + toiletVO.toiletType;
        var toiletBowlNumber = toiletVO.menToiletBowlNumber + toiletVO.ladiesToiletBowlNumber;
        var handicap = toiletVO.menHandicapToiletBowlNumber + toiletVO.ladiesHandicapToiletBowlNumber;
        if(handicap > 0)
        	handicap = "Y";
        else
        	handicap = "N";
        
        var content = "<div style='min-width:max-content;  z-index:999;'>"
        content += "<h5 class='card-title text-uppercase text-muted mb-0'>" + toiletType + "</h5>"
        content += "<br'><span class='card-title text-uppercase text-muted mb-0'>대변기 : " + toiletBowlNumber + "</span>"
        content += "<br><span class='card-title text-uppercase text-muted mb-0'>장애인 배려실 : " + handicap + "</span>"

        content += "<br><input class='replyButton3 mt-1 pointer' type='button' id='direction[" + i + "]' value='실시간 길찾기' onclick='navigators(" + toiletVO.lng + ',' + toiletVO.lat + ',' + '"' + title + '"' + ',' + '"' + toiletType + '"' + ',' + '"' + toiletBowlNumber + '"' + ',' + '"' + handicap + '"' + ")'>";
        content += "<div style='display:inline-block; margin-left:5px; text-decoration: underline; '>" + distime + "</div>";
        content += "</div>"

        console.log("target : 추천된 화장실")
        setTimeout(function () {
        	targetWindow.setMap(null)
        }, 0);
        setTimeout(function () {
        	targetWindow = new Tmapv2.InfoWindow({
        		position : new Tmapv2.LatLng(toiletVO.lat, toiletVO.lng),
        		content : content,
        		type : 1,
        		map : map
        	});
        }, 0);
        
      //별점과 청결도의 평균, 최근2일변화량체크
        $.ajax({
           url: "<c:url value='/review/reviewAver'/>",
           data:{
               lat: toiletVO.lat, 
               lng: toiletVO.lng
           },
           type:"post",
           success: function(e){
                $.ajax({
					url : "<c:url value='/dayaver/average'/>",
					type : "POST",
					data : {
						lng : toiletVO.lng, 
						lat : toiletVO.lat
					},
					success : function (res) {
						var changeRate = res.differ;
						var averageRate = res.average;
						changeDiv1(e.starAver, e.cleanAver, e.starDiffer, e.cleanDiffer, title, toiletType, toiletVO.lat, toiletVO.lng, changeRate, averageRate);
						reviewRefresh(toiletVO.lng, toiletVO.lat);
					},
					error : function (e) {
						console.log(JSON.stringify(e));
					}
				}); 
           },
           error: function(e){
               console.log(e);
           }
       });
    }//recommending[E]
    
    //화장실 추천기능
    function searchShortest () {
    	directions(shortestDistance);
    }
    function searchRating () {
    	$.ajax({
    		url: "<c:url value='/maps/searchRating'/>",
    		data: {
    			lat : pos.lat.toFixed(6),
    			lng : pos.lng.toFixed(6)
    		},
    		type: "post",
    		success: function(e){
                //e = toiletVO입니다.
                recommending(e);
            },
            error: function(e){
                console.log(e);
            }
        })
    }
    function searchClean () {
    	$.ajax({
    		url: "<c:url value='/maps/searchClean'/>",
    		data: {
    			lat : pos.lat.toFixed(6),
    			lng : pos.lng.toFixed(6)
    		},
    		type: "post",
    		success: function(e){
                //e = toiletVO입니다.
                recommending(e);
            },
            error: function(e){
            	console.log(e);
            }
        })
    }
    function searchSmooth () {
        $.ajax({
            url:"<c:url value='/maps/searchSmooth'/>",
            data:{
                lat : pos.lat.toFixed(6),
    			lng : pos.lng.toFixed(6)
            },
            type:"post",
            success:function(e){
            	recommending(e);
            },
            error:function(e){
                console.log(e);    
            }
        })
    }
    function terminators () {
    	clearInterval(realTime);
    	polyline_.setMap(null);
    	destinyWindow.setMap(null);
    }

    //실시간길찾기
    function navigators (endX, endY, title, toiletType, toiletBowlNumber, handicap) {
    	var id =$("#sessionId").val();
    	console.log("endX" + endX);
    	console.log("endY" + endY);
    	console.log("title" + title);
    	<%-- <%=(String) session.getAttribute("sessionId")%> --%>
    	;
    	$.ajax({
            url: "<c:url value='/review/reviewAver'/>",
            data:{
                lat: endY, 
                lng: endX
            },
            type:"post",
            success: function(e){
                 $.ajax({
					url : "<c:url value='/dayaver/average'/>",
					type : "POST",
					data : {
						lng : endX, 
						lat : endY
					},
					success : function (res) {
						var changeRate = res.differ;
						var averageRate = res.average;
						changeDiv1(e.starAver, e.cleanAver, e.starDiffer, e.cleanDiffer, title, toiletType, endY, endX, changeRate, averageRate);
					},
					error : function (e) {
						console.log(JSON.stringify(e));
					}
				}); 
            },
            error: function(e){
                console.log(e);
            }
        });
        //DB에 정보저장, title값 필요
        if(id != null){
        	$.ajax({
        		url : "<c:url value='/dayaver/searchedToilet'/>",
        		data : {
        			toiletNm : title,
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
        			console.log(e)
        		}
        	});
        }
        
        clearInterval(realTime);
        var content = "<div style='min-width:max-content;'>";
        content += "<h5 class='card-title text-uppercase text-muted mb-0'>" + toiletType + "</h5>";
        content += "<br'><span class='card-title text-uppercase text-muted mb-0'>대변기 : " + toiletBowlNumber + "</span>";
        content += "<br><span class='card-title text-uppercase text-muted mb-0'>장애인 배려실 : " + handicap + "</span>";
        content += "<br><input class='replyButton3 mt-1 pointer' type='button' id='direction[" + i + "]' value='길찾기 중단' onclick='terminators()'>";
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
        	console.log("네비게이터 실행중");
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

    function FeedbackShow()
    {
    	$.ajax
    	(
    	{
    		url:"<c:url value="/checkAvailSend"/>",
    		type:"get",				
    		dataType:"text",
    		success:
    		function(flag)
    		{
    			if(flag=="success")
    			{
    				$("#feedback-contents").val("");
    				$("input[name='feed-x-button']").removeAttr("disabled","disabled");
    				$("input[name='feedback-send']").removeAttr("disabled","disabled");
    				$("#feedback-contents").removeAttr("disabled","disabled");
    				$("#feedback-container").show();
    				$("#feedback").fadeIn();
    			}
    			else if(flag=="error")
    			{
    				alert("로그인을 해야 사용할 수 있는 기능입니다.\n로그인 페이지로 이동합니다.");
    				location.href="<c:url value='/member/login'/>";
    			}						
    		}
    		,
    		error:
    		function(e)
    		{
    			console.log(e);
    		}
    	}
    	);	    	
    }

    function SendFeedback()
    {
    	var contents = $("#feedback-contents").val();
    	
    	if(contents.length==0||contents.length<=10)
    	{
    		alert("내용을 충분히 입력해주세요(최소 10자 이상)");
    		return;
    	}

    	$("input[name='feed-x-button']").attr("disabled","disabled");
    	$("input[name='feedback-send']").attr("disabled","disabled");
    	$("#feedback-contents").attr("disabled","disabled");

    	$.ajax
    	(
    	{
    		url:"<c:url value="/sendFeedBack"/>",
    		type:"post",
    		data:{contentFromUser:contents},		
    		dataType:"text",
    		success:
    		function(flag)
    		{
    			if(flag=="success")
    			{
    				alert("피드백을 보내주셔서 감사합니다.\n더 나은 서비스를 제공하기 위해서 더욱 힘쓰겠습니다.");
    				$("#feedback").hide();
    				$("#feedback-container").fadeOut();
    				return;
    			}										
    		}
    		,
    		error:
    		function(e)
    		{
    		    console.log(e);
    			return;
    		}
    	}
    	);     	
    }
	
	// 최근 이용했던 화장실
	function Recent() {
		var id = $("#sessionId").val();
		$.ajax({
		url : "<c:url value='/dayaver/recent'/>",
		type : "GET" ,
		data : {
				id : id
			},
		success : function(list) {
			var id = $("#sessionId").val();
			console.log(list);
			console.log(id);
			console.log(list.list1.length);
			if(id != null && id != "" && list.list1.length == 0) {
				alert("저장된 데이터가 없습니다. 한 번 이상 길찾기를 해주세요.");
				return false;
				
			} else if(id != null && id != ""){
				var content = "<table>";
				$("#Recent-contents").val("");
				$("input[name='Recent-x-button']").html();
				$("#Recent-contents").html();
				$("#Recent-container").show();
				$("#Recent").slideDown();
				
				content += '<h3 class="text-uppercase text-muted ls-1 mb-1">' + "최근이용 화장실" + "</h3>";

				for(var i = 0; i < list.list1.length; i++) {
				content += '<tr>';
				content +='<th scope="col" style="text-align:left; font-size:16px;">';
				content += (i+1) + " ." ;
				content += list.list1[i].toiletNm + "<br>";
				content += list.list1[i].inputdate + "<br>" + "<hr>";
				content += '</th>';
				content += "</tr>";
				}
				
				content += "</table>";
				console.log(content);
				$("#Recent-contents").html(content);
			}else {
				alert("로그인이 필요한 서비스 입니다. 로그인을 해 주세요.");
				location.href = "../member/login";
					}
			
		},
		error : function(e) {
		    console.log(e);
		}
	});
}
	//선호하는 화장실
	function Prefer() {
		var id = $("#sessionId").val();
		$.ajax({
		url : "<c:url value='/dayaver/recent'/>",
		type : "GET" ,
		data : {
				id : id
			},
		success : function(list) {
			console.log(list);
			if(list.list2.length == 0 && id != null && id != "" ) 
			{
				alert("저장된 데이터가 없습니다. 한 번 이상 길찾기를 해주세요.");
				return false;
				
			}else if(id != null && id != ""){
				var content = "<table>";
				$("#Prefer-contents").val("");
				$("input[name='Prefer-x-button']").html();
				$("#Prefer-contents").html();
				$("#Prefer-container").show();
				$("#Prefer").slideDown();
				
				content += '<h3 class="text-uppercase text-muted ls-1 mb-1">' + "선호하는 화장실" + "</h3>";
				for(var i = 0; i < list.list2.length; i++) {
					content += '<tr>';
					content +='<th scope="col" style="text-align:left; font-size:16px;">';
					content += (i+1) + " ." ;
					content += list.list2[i].toiletNm + "<br>";
					content += list.list3[i]  + "번 이용 했습니다." + "<br>" + "<hr>";
					content += '</th>';
					content += "</tr>";
					}
				
				content += "</table>";
				console.log(content);
				
				$("#Prefer-contents").html(content);
			}else {
				alert("로그인 후 사용가능 한 기능입니다 로그인 후 사용해주세요");
				location.href = "../member/login";
			}
		},
		error : function(e) {
		    console.log(e);
		}
	});
}
	
    function resize (obj) {
    	obj.style.height = "1px";
    	obj.style.height = ( 12 + obj.scrollHeight ) + "px";
    }
    
    var temp_info;
	//type1의 진단결과
	function clickFunc()
	{
		diaryresult += $(this).attr("id");		
		console.log(diaryresult);
		
		if($(this).attr("id")=="type1"||$(this).attr("id")=="type2"||$(this).attr("id")=="type3"||$(this).attr("id")=="type4")
		{
			$('#health-ment').text('STEP2.대변의 색깔을 선택해주세요');
			$('#type1').attr('src','../resources/img/brown.png');
			$('#type2').attr('src','../resources/img/gray.png');
			$('#type3').attr('src','../resources/img/red.png');
			$('#type4').attr('src','../resources/img/yellow.png');
			$("#type1").attr('id','brown'); 
			$("#type2").attr('id','gray'); 
			$("#type3").attr('id','red'); 
			$("#type4").attr('id','yellow'); 
		}
		else
		{			
			var temp_str;
			var temp_src;
			
			$("#health_test_table").attr("hidden","hidden");
			$("#health-ment").attr("hidden","hidden");
			
			if(diaryresult=="type1brown")
			{
				temp_info=diaryGraphInfoArray[0];
				temp_str=diaryDescriptionArray[0];
				temp_src=diaryPictureArray[0];								
		     }

			else if(diaryresult=="type1gray")
			{
				temp_info=diaryGraphInfoArray[1];
				temp_str=diaryDescriptionArray[1];
				temp_src=diaryPictureArray[1];				
			}
			else if(diaryresult=="type1red")
			{
				temp_info=diaryGraphInfoArray[2];
				temp_str=diaryDescriptionArray[2];
				temp_src=diaryPictureArray[2];				
			}	    	    
			else if(diaryresult=="type1yellow")
			{
				temp_info=diaryGraphInfoArray[3];
				temp_str=diaryDescriptionArray[3];
				temp_src=diaryPictureArray[3];				
			}	    	    
			else if(diaryresult=="type2brown")
			{
				temp_info=diaryGraphInfoArray[4];
				temp_str=diaryDescriptionArray[4];
				temp_src=diaryPictureArray[4];				
			}
			else if(diaryresult=="type2gray")
			{
				temp_info=diaryGraphInfoArray[5];
				temp_str=diaryDescriptionArray[5];
				temp_src=diaryPictureArray[5];				
			}
			else if(diaryresult=="type2red")
			{
				temp_info=diaryGraphInfoArray[6];
				temp_str=diaryDescriptionArray[6];
				temp_src=diaryPictureArray[6];				
			}	    	    
			else if(diaryresult=="type2yellow")
			{
				temp_info=diaryGraphInfoArray[7];
				temp_str=diaryDescriptionArray[7];
				temp_src=diaryPictureArray[7];				
			}	    	    
			else if(diaryresult=="type3brown")
			{
				temp_info=diaryGraphInfoArray[8];
				temp_str=diaryDescriptionArray[8];
				temp_src=diaryPictureArray[8];				
			}
			else if(diaryresult=="type3gray")
			{
				temp_info=diaryGraphInfoArray[9];
				temp_str=diaryDescriptionArray[9];
				temp_src=diaryPictureArray[9];				
			}
			else if(diaryresult=="type3red")
			{
				temp_info=diaryGraphInfoArray[10];
				temp_str=diaryDescriptionArray[10];
				temp_src=diaryPictureArray[10];				
			}	    	    
			else if(diaryresult=="type3yellow")
			{
				temp_info=diaryGraphInfoArray[11];
				temp_str=diaryDescriptionArray[11];
				temp_src=diaryPictureArray[11];				
			}	    	    
			else if(diaryresult=="type4brown")
			{
				temp_info=diaryGraphInfoArray[12];
				temp_str=diaryDescriptionArray[12];
				temp_src=diaryPictureArray[12];				
			}
			else if(diaryresult=="type4gray")
			{
				temp_info=diaryGraphInfoArray[13];
				temp_str=diaryDescriptionArray[13];
				temp_src=diaryPictureArray[13];				
			}
			else if(diaryresult=="type4red")
			{
				temp_info=diaryGraphInfoArray[14];
				temp_str=diaryDescriptionArray[14];
				temp_src=diaryPictureArray[14];				
			}	    	    
			else if(diaryresult=="type4yellow")
			{
				temp_info=diaryGraphInfoArray[15];
				temp_str=diaryDescriptionArray[15];
				temp_src=diaryPictureArray[15];
			}	    	    
		     	    	    
		     if(result_show_flag)
			{
				console.log("계속 돈다");
		    	 var ctx = document.getElementById('myChart').getContext('2d');
					var myChart = new Chart(ctx, {
					    type: 'line',
					    data: {
					        labels: ['스트레스', '수분', '영양소'],
					        datasets: [{
					            label: '',
					            data: [temp_info.stress,temp_info.moisture ,temp_info.ingredient],
					            backgroundColor: [
					                'rgba(255, 99, 132, 0.2)',
					                'rgba(54, 162, 235, 0.2)',
					                'rgba(0, 255, 0, 0.2)'			                
					            ],
					            borderColor: [
					                'rgba(255, 99, 132, 1)',
					                'rgba(54, 162, 235, 1)',
					                'rgba(0, 255, 0, 1)'			               
					            ],
					            borderWidth: 1		           
					        }]
					    },
					    options: {
					    	 legend:
						    {
					    		 showLines: false,
					             display:false
					      	},  
					        scales: 
						    { 
					            yAxes: [{
					                ticks: {
					                    beginAtZero: true,
					                    display : false
					                    
					                },
					                gridLines:
						            {
					                     lineWidth:0
					                     
					                 }
					            }]
					        }
					    }
					}); 
					result_show_flag=false;
			}
			
			$("#result_picture").attr("src",temp_src);
			$("#result_description").html(temp_str);			
			$("input[name='save-data']").removeAttr("hidden","hidden");
			$("#result_table").removeAttr("hidden","hidden");
			$("#myChart").removeAttr("hidden","hidden");
		}		
	} //요기가 함수 끝

	
    function DiaryShow()
    {     	      
 	  	diaryresult="";
		result_show_flag=true;
		$("#hopital_table").attr("hidden","hidden");
    	$("input[name='save-data']").attr("hidden","hidden");
    	$("#myChart").attr("hidden","hidden");
    	$("#result_table").attr("hidden","hidden");
    	
    	$("#health_test_table").removeAttr("hidden","hidden");
    	$("#health-ment").html("STEP1.대변의 모양을 선택해주세요");

		$("#health-ment").removeAttr("hidden","hidden");
		
		$("#health-ment").removeAttr("hidden","hidden");
		$('#brown').attr('src','../resources/img/type1_1.png');
		$('#gray').attr('src','../resources/img/type2_1.png');
		$('#red').attr('src','../resources/img/type3_1.png');
		$('#yellow').attr('src','../resources/img/type4_1.png');

		$('#brown').attr('id','type1');
		$('#gray').attr('id','type2');
		$('#red').attr('id','type3');
		$('#yellow').attr('id','type4');		
		
		$("#diary-container").show();
		$("#diary").fadeIn(); 
	}


	function SaveTest()
	{
    	$.ajax
		(
			{
				url:"<c:url value="/checkAvailSend"/>",
				type:"get",				
				dataType:"text",
				success:
					function(flag)
					{
						if(flag=="success")
						{
							InsertResult();
						}
						else if(flag=="error")
						{
							alert("로그인을 해야 사용할 수 있는 기능입니다.\n로그인 페이지로 이동합니다.");
							location.href="<c:url value='/member/login'/>";
						}						
					}
				,
				error:
					function(e)
					{
				    console.log(e);
					}
			}
		);	    	
	}


function ShowHospitalList()
{
	$.ajax
	(
		{
			url:"<c:url value="/toilet/receive_near_hospital"/>",
			type:"post",				
			data:{
				lat : pos.lat.toFixed(6),
    			lng : pos.lng.toFixed(6)
    		},
			success:
				function(list)
				{
					$("#result_table").attr("hidden","hidden");
					$("#myChart").attr("hidden","hidden");	
					$("input[name='save-data']").attr("hidden","hidden");	
					var contents = "";
					var list_temp = list;
					
					if(list_temp.length==0)
					{
						contents+='<tr>';
						contents+='<th scope="col" style="text-align: left; font-size:14px;">근처에 병원이 존재하지 않습니다.</th>';
						contents+='</tr>';	
						return;
					}
					
					if(list_temp.length>5)
					{
						for(var i =0;i<5;i++)
						{
							contents+='<tr>';
							contents+='<th scope="col" style="text-align: left; font-size:14px;">'+(i+1) +'. 병원 이름 : ' + list_temp[i].dutyName + ' 전화번호 : ' + list_temp[i].dutyTel1+'<br>';
							contents+='평일 개시시간 : '+ list_temp[i].dutyTimeS + ' 평일 종료시간 : ' + list_temp[i].dutyTimeC +'<br>';
							contents+= '주소: '+ list_temp[i].dutyAddr;
							contents+='</th>';							
							contents+='</tr>';							
						}
					}
					else
					{
						for(var i =0;i<list_temp.length;i++)
						{
							contents+='<tr>';
							contents+='<th scope="col" style="text-align: left; font-size:14px;">'+(i+1) +'. 병원 이름 : ' + list_temp[i].dutyName + ' 전화번호 : ' + list_temp[i].dutyTel1+'<br>';
							contents+='평일 개시시간 : '+ list_temp[i].dutyTimeS + ' 평일 종료시간 : ' + list_temp[i].dutyTimeC +'<br>';
							contents+= '주소: '+ list_temp[i].dutyAddr;
							contents+='</th>';							
							contents+='</tr>';							
						}
					}					
					
					$("#hopital_table").html(contents);
					$("#hopital_table").removeAttr("hidden","hidden");			
					
				}
			,
			error:
				function(e)
				{				
					
				}
		}
	);	    	
}
	    
function InsertResult()
{
	$.ajax
	(
		{
			url:"<c:url value="/diary/insert"/>",
			type:"post",				
			dataType:"text",
			data:{stress:temp_info.stress, moisture:temp_info.moisture, ingredient:temp_info.ingredient, status:temp_info.status},
			success:
				function(flag)
				{
					if(flag=="ignore")
					{
						alert("하루 3번 초과의 테스트값을 저장 할 수는 없습니다. 진지하게 테스트에 임해주세요.");
						$("#diary").hide();
						$("#diary-container").fadeOut();
					}					
					else if(flag=="warning")
					{
						alert("데이터를 저장했지만 건강이 위험한 상태입니다.\n 반경 1km 병원의 위치를 알려드리겠습니다.");
						ShowHospitalList();												
					}
					else if(flag=="success")
					{
						alert("저장에 성공했습니다. 프로필의 달력에서 기록을 확인 할 수 있습니다.");
						$("#diary").hide();
						$("#diary-container").fadeOut();
						
					}
					else if(flag=="error")
					{
						alert("저장이 실패하였습니다. 다시 시도해주세요.");
					}						
				}
			,
			error:
				function(e)
				{
			    console.log(e);
				}
		}
	);	    	
}


</script>
</head>
<body class="" onload="initTmap()">

	<input type="hidden" id="Profile" name="profile_image" value="${sessionScope.Profile}">
	<input type="hidden" id="sessionNickname" name="nickname" value="${sessionScope.sessionNickname}">
	<input type="hidden" id="sessionId" name="sessionId" value="${sessionScope.sessionId}">

	<div id="review-container"></div>
	<div id="review" class="col-xl-4">
		<div class="card shadow">
			<div class="card-header bg-transparent">
				<div class="row align-items-center">
					<div class="col">
						<h2 id="review-toilet" class="mb-0" style="display: inline-block"></h2>
						<input type="hidden" id="toiletNm"> <input type="hidden" id="toiletType"> <input id="x-button" class="btn btn-sm btn-primary" type="button" value="X" onclick='$("#review").hide(), $("#review-container").fadeOut()'> <input id="register" class="btn btn-sm btn-primary" type="button" value="Register" onclick='reviewCheck()'>
						<h6 id="review-ment" class="text-uppercase text-muted ls-1 mb-1">당신의 리뷰가 다른 사람들에게 도움이 될 거에요!</h6>
					</div>
				</div>
			</div>
			<div class="card-body2">
				<div class="col-xl-12 col-lg-6">
					<div class="card card-stats mb-4 mb-xl-0">
						<textarea class="card-body4 replyButton2" id="review-area" name="review" onkeydown="resize(this)" onkeyup="resize(this)" style="resize: none;"></textarea>
						<div class="row">
							<div class="col mt-2">
								<span class="h2 font-weight mb-0">별점<img id="star1" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"><img id="star2" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"><img id="star3" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"><img id="star4" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"><img id="star5" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>">
								</span> <span id="clean-margin" class="h2 font-weight mb-0">청결도<img id="clean1" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"><img id="clean2" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"><img id="clean3" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"><img id="clean4" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"><img id="clean5" class="stars ml-1" src="<c:url value="/resources/img/starOff.png"/>"></span>
							</div>
							<input type="hidden" id="star" name="star"> <input type="hidden" id="clean" name="clean"> <input type="hidden" id="lng" name="lng"> <input type="hidden" id="lat" name="lat">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 네비게이션 start -->
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

	<!-- 최근 이용 화장실 nav-->
	<div id="Recent-container" style="display: none;"></div>
	<div id="Recent" class="col-xl-4" style="display: none;">
		<form action="">
			<div class="card shadow">
				<div class="card-header bg-transparent">
					<div class="row align-items-center">
						<div class="col">
							<h2 class="mb-0" style="display: inline-block">Recent toliet</h2>
							<input id="x-button" name="Recent-x-button" class="btn btn-sm btn-primary" value="X" onclick='$("#Recent").hide(), $("#Recent-container").fadeOut()'>
							<h6 id="Recent-ment" class="text-uppercase text-muted ls-1 mb-1">최근 이용 화장실 목록 입니다.</h6>
						</div>
					</div>
				</div>
				<div class="card-body2">
					<div class="col-xl-12 col-lg-6">
						<div class="card card-stats mb-4 mb-xl-0" id="Recent-contents"></div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<!-- 선호 화장실 nav-->
	<div id="Prefer-container"></div>
	<div id="Prefer" class="col-xl-4">
		<form action="">
			<div class="card shadow">
				<div class="card-header bg-transparent">
					<div class="row align-items-center">
						<div class="col">
							<h2 class="mb-0" style="display: inline-block">Preferred toliet</h2>
							<input id="x-button" name="Recent-x-button" class="btn btn-sm btn-primary" value="X" onclick='$("#Prefer").hide(), $("#Prefer-container").fadeOut()'>
							<h6 id="Prefer-ment" class="text-uppercase text-muted ls-1 mb-1">가장 많이 이용 한 화장실 목록 입니다.</h6>
						</div>
					</div>
				</div>
				<div class="card-body2">
					<div class="col-xl-12 col-lg-6">
						<div class="card card-stats mb-4 mb-xl-0" id="Prefer-contents"></div>
					</div>
				</div>
			</div>
		</form>
	</div>





	<div id="diary-container" style="display: none;"></div>
	<div id="diary" class="col-xl-4" style="display: none;">
		<form action="">
			<div class="card shadow">
				<div class="card-header bg-transparent">
					<div class="row align-items-center">
						<div class="col">
							<h2 class="mb-0" style="display: inline-block">Health Test</h2>
							<input id="x-button" name="feed-x-button" class="btn btn-sm btn-primary" value="X" onclick='$("#diary").hide(), $("#diary-container").fadeOut()'> 
							<input id="register" hidden="hidden" name="save-data" class="btn btn-sm btn-primary" type="button" value="Save Data" onclick="SaveTest()"> <br>
							<h4 id="health-ment" class="mb-0" style="display: inline-block">STEP1.대변의 모양을 선택해주세요</h4>
						</div>
					</div>
					<div class="card-body2">
						<!-- 결과 그래프 출력 -->
						<canvas id="myChart" hidden="hidden" width="5" height="2"></canvas>
						<table id="result_table" hidden="hidden">
							<tr>
								<td><img id="result_picture" src="" style="width: 50%" /></td>
								<td>
									<p id="result_description"></p>
								</td>
							</tr>
						</table>

						<table id="hopital_table" class="table align-items-center table-flush" hidden="hidden" >
						</table>

						<!-- 테스트 목록 출력 -->
						<table id="health_test_table">
							<tr>
								<td style="width: 230px; height: 150px;"><img id="type1" class="hvr-grow-shadow" name="1" src="../resources/img/type1_1.png" style="width: 90%;" /></td>
								<td style="width: 230px; height: 150px;"><img id="type2" class="hvr-grow-shadow" name="2" src="../resources/img/type2_1.png" style="width: 90%;" /></td>
							</tr>
							<tr>
								<td style="width: 230px; height: 150px;"><img id="type3" class="hvr-grow-shadow" name="3" src="../resources/img/type3_1.png" style="width: 90%" /></td>
								<td style="width: 230px; height: 150px;"><img id="type4" class="hvr-grow-shadow" name="4" src="../resources/img/type4_1.png" style="width: 90%" /></td>
							</tr>
						</table>
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
							<span class="avatar avatar-sm rounded-circle"> <c:if test="${sessionScope.sessionId != null}">
									<img alt="Image placeholder" src="${sessionScope.Profile}">
								</c:if> <c:if test="${sessionScope.sessionId == null}">
									<img alt="Image placeholder" src="<c:url value="/resources/assets/img/theme/team-4-800x800.jpg"/>">
								</c:if>
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
				<form id="responsive-search" class="mt-4 mb-3 d-md-none" action="<c:url value="/review/reviewMain"/>" method="get">
					<div class="input-group input-group-rounded input-group-merge">
						<input type="search" class="form-control form-control-rounded form-control-prepended" name="toiletNm" placeholder="Search Review" aria-label="Search">
						<div class="input-group-prepend">
							<div class="input-group-text" onclick="document.forms['responsive-search'].submit();">
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
					
							ni ni-chat-round

					 --%>
					<li class="nav-item"><a class="nav-link" href="<c:url value="/review/reviewMain"/>">
							<i class="ni ni-chat-round"></i> Reviews
						</a></li>

					<!-- 건강 테스트 -->
					<li class="nav-item"><a class="nav-link " href="javascript:DiaryShow();">
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
					</c:if>
				</ul>
				<!-- 				
						<!-- Divider -->
				<hr class="my-3">
				<!-- Heading -->
				<h6 class="navbar-heading text-muted">NEED LOGIN</h6>
				<!-- Navigation -->
				<ul class="navbar-nav mb-md-3">
					<li class="nav-item"><a class="nav-link" href="javascript:Recent();">
							<i class="ni ni-watch-time text-indigo"></i> <span>Recent toilet</span>
						</a></li>
					<li class="nav-item"><a class="nav-link" href="javascript:Prefer();">
							<i class="ni ni-favourite-28 text-pink"></i> <span>Preferred toilet</span>
						</a></li>

					<li class="nav-item"><a class="nav-link" href="javascript:FeedbackShow();">
							<i class="ni ni-send text-blue"></i> <span>Send Feedback</span>
						</a></li>

					<li class="nav-item mt-3">
						<div id="openweathermap-widget-18"></div>
					</li>
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
				<a class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block" href="<c:url value="/maps/mapsMain"/>">Maps</a>
				<!-- Form -->
				<form id="normal-search" class="navbar-search navbar-search-dark form-inline mr-3 d-none d-md-flex ml-lg-auto" action="<c:url value="/review/reviewMain"/>" method="get">
					<div class="form-group mb-0">
						<div class="input-group input-group-alternative">
							<div class="input-group-prepend">
								<span class="input-group-text pointer" onclick="document.forms['normal-search'].submit();""><i class="fas fa-search"></i></span>
							</div>
							<input class="form-control" placeholder="Search Review" name="toiletNm" type="text">
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

									<c:if test="${sessionScope.sessionNaver != null}">
										<span class="avatar avatar-sm rounded-circle"> <img alt="Image placeholder" src="<c:url value="${sessionScope.Profile}"/>">
										</span>
										<div class="media-body ml-2 d-none d-lg-block">
											<span class="mb-0 text-sm  font-weight-bold">${sessionScope.sessionNickname}</span>
										</div>
									</c:if>

									<c:if test="${sessionScope.sessionNaver == null}">
										<span class="avatar avatar-sm rounded-circle"> <img alt="Image placeholder" src="<c:url value="${sessionScope.Profile}"/>">
										</span>
										<div class="media-body ml-2 d-none d-lg-block">
											<span class="mb-0 text-sm  font-weight-bold">${sessionScope.sessionNickname}</span>
										</div>
									</c:if>

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
					<input class='replyButton1 ml-1 pointer' type='button' value='최단거리' onclick='searchShortest()'> <input class='replyButton1 ml-0 pointer' type='button' value='최고 평가' onclick='searchRating()'> <input class='replyButton1 ml-0 pointer' type='button' value='최고 청결도' onclick='searchClean()'> <input class='replyButton1 ml-0 pointer' type='button' value='최대 원활도' onclick='searchSmooth()'>
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
											<span class='text-nowrap mr-0'>별점: </span><span class='text-success'>주간평균</span><span class='text-nowrap mr-0 ml-2'> 청결도:</span><span class='text-success'>주간평균</span>
										</p>
										<p class="mt-2 mb-0 text-muted text-sm">
											<span class='text-nowrap mr-0'>이용자수: </span><span class='text-success'>주간집계</span>
										</p>
									</div>
								</div>
							</div>
							<div class="col-xl-3 col-lg-6">
								<div class="card card-stats mb-4 mb-xl-0">
									<div class="card-body3 replyButton2" id="div2">
										<div class="row">
											<div class="col-8 pr-0" style="float: left;">
												<span class="card-title text-sm text-muted mb-0" id="reviews-0">당신의 리뷰를 들려주세요</span>
											</div>
											<div class="col-4" style="text-align: center; float: right;">
												<p class="mt-0 mb-3 text-muted text-sm">
													<span class="text-success" id="star-review-0"></span><span class="text-nowrap mr-2 ml-2">별점</span> <br> <span class="text-danger" id="clean-review-0"></span><span class="text-nowrap mr-2 ml-2">청결도</span>
												</p>
												<div id="profile-review-0">
													<div class="icon icon-shape bg-warning text-white rounded-circle shadow" style="display: inline-block;"></div>
												</div>
												<h5 class="card-title text-uppercase text-muted mb-0 mt-0 text-sm" id="nick-review-0">Nickname</h5>
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
												<span class="card-title  text-sm text-muted mb-0" id="reviews-1">당신의 리뷰를 들려주세요</span>
											</div>
											<div class="col-4" style="text-align: center;">
												<p class="mt-0 mb-3 text-muted text-sm">
													<span class="text-success" id="star-review-1"></span><span class="text-nowrap mr-2 ml-2">별점</span> <br> <span class="text-danger" id="clean-review-1"></span><span class="text-nowrap mr-2 ml-2">청결도</span>
												</p>
												<div id="profile-review-1">
													<div class="icon icon-shape bg-warning text-white rounded-circle shadow" style="display: inline-block;"></div>
												</div>
												<h5 class="card-title text-uppercase text-muted mb-0 mt-0 text-sm" id="nick-review-1">Nickname</h5>
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
												<span class="card-title text-sm text-muted mb-0" id="reviews-2">당신의 리뷰를 들려주세요</span>
											</div>
											<div class="col-4" style="text-align: center;">
												<p class="mt-0 mb-3 text-muted text-sm">
													<span class="text-success" id="star-review-2"></span><span class="text-nowrap mr-2 ml-2">별점</span> <br> <span class="text-danger" id="clean-review-2"></span><span class="text-nowrap mr-2 ml-2">청결도</span>
												</p>
												<div id="profile-review-2">
													<div class="icon icon-shape bg-warning text-white rounded-circle shadow" style="display: inline-block;"></div>
												</div>
												<h5 class="card-title text-uppercase text-muted mb-0 mt-0 text-sm" id="nick-review-2">Nickname</h5>
											</div>
										</div>
									</div>
								</div>
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
	</div>
	<!--   Core   -->
	<script src="<c:url value="/resources/assets/js/plugins/jquery/dist/jquery.min.js"/>"></script>
	<script src="<c:url value="/resources/assets/js/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"/>"></script>

</body>

</html>