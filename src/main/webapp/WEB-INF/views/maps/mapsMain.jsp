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
<link href="<c:url value="/resources/css/boardStyle.css"/>" rel="stylesheet" />
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
    var reviewList = [ ];
    var polyFlag = 0;
    var locationFlag = 0;
    var starFlag = 0;
	var changeRate;
	var averageRate; 
    //var shortFlag = 1;
    
    $(function () {
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
    })//window.onload[E]
    
    function reviewRefresh(title){
        $.ajax({
            url: "<c:url value='/review/reviewList'/>",
            data: {
                toiletNm: title
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
                sessionId: sessionId,
                sessionNickname: sessionNickname,
                Profile: Profile,
                review: review,
                star: star,
                clean: clean
            },
            type : "post",
            success: function(e){
                $("#review").hide();
                $("#review-container").fadeOut();  
                $("#review-area").val("");
            },
            error: function(e){
                $("#review").hide();
                $("#review-container").fadeOut();  
                $("#review-area").val("");
                console.log("리뷰쓰기 실패");
                console.log(e);
            }
        })//리뷰등록[E]
        reviewRefresh(toiletNm);
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
                            
                            //console.log("toiletMarker : " + toiletMarker)
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
                            content2 += "<input class='replyButton3 ml-1 pointer' type='button' value='리뷰 목록' onclick='location.href=\"/brr/review/reviewMain?toiletTitle=" + title + "\"'>"

                            var id = $("#sessionId").val();
<%-- <%=(String) session.getAttribute("sessionId")%>
    ; --%>
                            //리뷰쓰기
                            content2 += "<input class='replyButton3 ml-1 pointer' type='button' value='리뷰 쓰기' onclick='reviewWrite(" + "\"" + title + "\"," + "\"" + id + "\")'>"
                            content2 += "</p>"

                            div1.innerHTML = content2;
                            reviewRefresh(title);
							
                    		$.ajax({
                    			url : "<c:url value='/dayaver/average'/>",
                    			type : "POST",
                    			data : {
                    				lng : endX, lat : endY
                    			},
                    			success : function (res) {
                    				//consloe.log(res);
                    				var changeRate = res.differ;
                    				var averageRate = res.average;
                    				
                    			},
                    			error : function (e) {
                    				alert(JSON.stringify(e));
                    			}
                    			
                    		});
                            
                        }
                    }(toiletMarker, i, title));
        }//마커생성 for[E]
    
    }//setPositions[E]
    
    function reviewWrite (title, id) {
        document.getElementById("review-toilet").innerHTML=title;
        $("#toiletNm").val(title)
        $("#review-container").fadeIn();
        $("#review").fadeIn();
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
    
    //화장실 추천기능
    function searchShortest () {
        directions(shortestDistance)
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
                starToilet=e;
                
            },
            error: function(e){
                
            }
        })
    }
    function searchClan () {
        directions(shortestDistance)
    }
    function searchSmooth () {
        directions(shortestDistance)
    }
    function terminators () {
        clearInterval(realTime);
        polyline_.setMap(null)
        destinyWindow.setMap(null);
    }

    //실시간길찾기
    function navigators (endX, endY, title, toiletType, toiletBowlNumber, handicap) {
        var id =$("#sessionId").val();
<%-- <%=(String) session.getAttribute("sessionId")%> --%>
    ;    	
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
                    alert(JSON.stringify(e));
                }
            });
        }
        
        clearInterval(realTime);
        var content = "<div style='min-width:max-content;'>"
        content += "<h5 class='card-title text-uppercase text-muted mb-0'>" + toiletType + "</h5>"
        content += "<br'><span class='card-title text-uppercase text-muted mb-0'>대변기 : " + toiletBowlNumber + "</span>"
        content += "<br><span class='card-title text-uppercase text-muted mb-0'>장애인 배려실 : " + handicap + "</span>"
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
						alert(Json.Stringify(e));
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
						alert(Json.Stringify(e));
						return;
					}
			}
		);     	
     }

    
    function resize (obj) {
        obj.style.height = "1px";
        obj.style.height = ( 12 + obj.scrollHeight ) + "px";
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
						<input type="hidden" id="toiletNm"> <input id="x-button" class="btn btn-sm btn-primary" type="button" value="X" onclick='$("#review").hide(), $("#review-container").fadeOut()'> <input id="register" class="btn btn-sm btn-primary" type="button" value="Register" onclick='reviewCheck()'>
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
							<input type="hidden" id="star" name="star"> <input type="hidden" id="clean" name="clean">
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

	<div id="dairy-container"></div>
	<div id="dairy" class="col-xl-4">
		<form action="">
			<div class="card shadow">
				<div class="card-header bg-transparent">
					<div class="row align-items-center">
						<div class="col">
							<h2 class="mb-0" style="display: inline-block">Feedback Send</h2>
							<input id="x-button" name="feed-x-button" class="btn btn-sm btn-primary" value="X" onclick='$("#dairy").hide(), $("#dairy-container").fadeOut()'>
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
							<span class="avatar avatar-sm rounded-circle"> <img alt="Image placeholder" src="${sessionScope.Profile}">
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

					<li class="nav-item"><br>
					<br>
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

									<c:if test="${sessionScope.sessionGooglename != null}">
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
					<input class='replyButton1 ml-1 pointer' type='button' value='최단거리' onclick='searchShortest()'> <input class='replyButton1 ml-0 pointer' type='button' value='최고 평가' onclick='searchRating()'> <input class='replyButton1 ml-0 pointer' type='button' value='최고 청결도' onclick='searchClan()'> <input class='replyButton1 ml-0 pointer' type='button' value='최대 원활도' onclick='searchSmooth()'>
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
												<span class="card-title text-sm text-muted mb-0" id="reviews-0">당신의 리뷰를 들려주세요</span>
											</div>
											<div class="col-4" style="text-align: center; float: right;">
												<p class="mt-0 mb-3 text-muted text-sm">
													<span class="text-success" id="star-review-0"></span><span class="text-nowrap mr-2 ml-2">별점</span> <br> <span class="text-danger" id="clean-review-0"></span><span class="text-nowrap mr-2 ml-2">청결도</span>
												</p>
												<div id="profile-review-0">
													<div class="icon icon-shape bg-warning text-white rounded-circle shadow" style="display: inline-block;"></div>
												</div>
												<h5 class="card-title text-uppercase text-muted mb-0 mt-0" id="nick-review-0">Nickname</h5>
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
												<h5 class="card-title text-uppercase text-muted mb-0 mt-0" id="nick-review-1">Nickname</h5>
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
												<h5 class="card-title text-uppercase text-muted mb-0 mt-0" id="nick-review-2">Nickname</h5>
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