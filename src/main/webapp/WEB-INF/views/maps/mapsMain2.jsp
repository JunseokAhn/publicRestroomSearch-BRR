<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<script src="<c:url value="/resources/js/jquery-3.4.1.js/"/>"></script>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>화장실이 급할땐? - 부르르</title>
<script src="../resources/js/jquery-3.4.1.js"></script>
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
    //대변 체크 결과
    var diaryGraphInfo = function (stress, moisture, ingredient, status) {
        this.stress = stress;
        this.moisture = moisture;
        this.ingredient = ingredient;
        this.status = status
        return this;
    }

    var diaryPictureArray = [ "../resources/img/normal.png",
        "../resources/img/dangerous.png", "../resources/img/dangerous.png",
        "../resources/img/normal.png",

        "../resources/img/good.png", "../resources/img/dangerous.png",
        "../resources/img/dangerous.png", "../resources/img/normal.png",

        "../resources/img/normal.png", "../resources/img/dangerous.png",
        "../resources/img/dangerous.png", "../resources/img/normal.png",

        "../resources/img/normal.png", "../resources/img/dangerous.png",
        "../resources/img/sobad.png", "../resources/img/normal.png" ];
    
    var diaryGraphInfoArray = [ new diaryGraphInfo(3, 1, 2, 3),
        new diaryGraphInfo(5, 1, 3, 2), new diaryGraphInfo(4, 2, 2, 2),
        new diaryGraphInfo(4, 1.5, 0.5, 3),

        new diaryGraphInfo(0, 5, 5, 2), new diaryGraphInfo(2, 1, 1, 4),
        new diaryGraphInfo(3, 2, 2, 2), new diaryGraphInfo(2, 2, 3, 3),

        new diaryGraphInfo(3, 1, 2, 3), new diaryGraphInfo(3, 2, 2, 2),
        new diaryGraphInfo(3, 1, 1, 2), new diaryGraphInfo(1, 1, 2, 3),

        new diaryGraphInfo(2, 4, 4, 3), new diaryGraphInfo(4, 1, 2, 2),
        new diaryGraphInfo(5, 0.5, 0.5, 1), new diaryGraphInfo(1, 1, 2, 3) ];
    
    var diaryresult = "";
    var result_show_flag = true;
    var diaryDescriptionArray = [
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
        "<p>수분이나 당분,지방을 지나치게 많이 먹어 장이 자극받은 상태입니다.<br>휴식이 필요해요.</p>" ];
    $(function () {
        
        setTimeout(function () {
            window.myWidgetParam
                    ? window.myWidgetParam : window.myWidgetParam = [ ];
            window.myWidgetParam.push({
                id : 18,
                cityid : '1835848',
                appid : 'c08b376c4c1ca3b5e593c4991d91eb3c',
                units : 'metric',
                containerid : 'openweathermap-widget-18',
            });
            ( function () {
                var script = document.createElement('script');
                script.async = true;
                script.charset = "utf-8";
                script.src = "//openweathermap.org/themes/openweathermap/assets/vendor/owm/js/weather-widget-generator.js";
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(script, s);
            } )();
        }, 1000)
        // type모양별 체크시 각 함수를 다르게 지정해서 건강진단을 함    
        $("#type1").on("click", clickFunc);
        $("#type2").on("click", clickFunc);
        $("#type3").on("click", clickFunc);
        $("#type4").on("click", clickFunc);
    })
    function FeedbackShow () {
        $.ajax({
            url : "<c:url value="/checkAvailSend"/>",
            type : "get",
            dataType : "text",
            success : function (flag) {
                if(flag == "success"){
                    $("#feedback-contents").val("");
                    $("input[name='feed-x-button']")
                            .removeAttr("disabled", "disabled");
                    $("input[name='feedback-send']")
                            .removeAttr("disabled", "disabled");
                    $("#feedback-contents").removeAttr("disabled", "disabled");
                    $("#feedback-container").show();
                    $("#feedback").fadeIn();
                }
                else if(flag == "error"){
                    alert("로그인을 해야 사용할 수 있는 기능입니다.\n로그인 페이지로 이동합니다.");
                    location.href = "<c:url value='/member/login'/>";
                }
            },
            error : function (e) {
                alert(Json.Stringify(e));
            }
        });
    }

    function SendFeedback () {
        var contents = $("#feedback-contents").val();
        
        if(contents.length == 0 || contents.length <= 10){
            alert("내용을 충분히 입력해주세요(최소 10자 이상)");
            return;
        }
        
        $("input[name='feed-x-button']").attr("disabled", "disabled");
        $("input[name='feedback-send']").attr("disabled", "disabled");
        $("#feedback-contents").attr("disabled", "disabled");
        
        $.ajax({
            url : "<c:url value="/sendFeedBack"/>",
            type : "post",
            data : {
                contentFromUser : contents
            },
            dataType : "text",
            success : function (flag) {
                if(flag == "success"){
                    alert("피드백을 보내주셔서 감사합니다.\n더 나은 서비스를 제공하기 위해서 더욱 힘쓰겠습니다.");
                    $("#feedback").hide();
                    $("#feedback-container").fadeOut();
                    return;
                }
            },
            error : function (e) {
                alert(Json.Stringify(e));
                return;
            }
        });
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
			alert(JSON.stringify(e));
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
			alert(JSON.stringify(e));
		}
	});
}

    function resize (obj) {
        obj.style.height = "1px";
        obj.style.height = ( 12 + obj.scrollHeight ) + "px";
    }

    var temp_info;
    //type1의 진단결과
    function clickFunc () {
        diaryresult += $(this).attr("id");
        console.log(diaryresult);
        
        if($(this).attr("id") == "type1" || $(this).attr("id") == "type2" || $(this)
                .attr("id") == "type3" || $(this).attr("id") == "type4"){
            $('#health-ment').text('STEP2.대변의 색깔을 선택해주세요');
            $('#type1').attr('src', '../resources/img/brown.png');
            $('#type2').attr('src', '../resources/img/gray.png');
            $('#type3').attr('src', '../resources/img/red.png');
            $('#type4').attr('src', '../resources/img/yellow.png');
            $("#type1").attr('id', 'brown');
            $("#type2").attr('id', 'gray');
            $("#type3").attr('id', 'red');
            $("#type4").attr('id', 'yellow');
        }
        else{
            var temp_str;
            var temp_src;
            
            $("#health_test_table").attr("hidden", "hidden");
            $("#health-ment").attr("hidden", "hidden");
            
            if(diaryresult == "type1brown"){
                temp_info = diaryGraphInfoArray[0];
                temp_str = diaryDescriptionArray[0];
                temp_src = diaryPictureArray[0];
            }
            
            else if(diaryresult == "type1gray"){
                temp_info = diaryGraphInfoArray[1];
                temp_str = diaryDescriptionArray[1];
                temp_src = diaryPictureArray[1];
            }
            else if(diaryresult == "type1red"){
                temp_info = diaryGraphInfoArray[2];
                temp_str = diaryDescriptionArray[2];
                temp_src = diaryPictureArray[2];
            }
            else if(diaryresult == "type1yellow"){
                temp_info = diaryGraphInfoArray[3];
                temp_str = diaryDescriptionArray[3];
                temp_src = diaryPictureArray[3];
            }
            else if(diaryresult == "type2brown"){
                temp_info = diaryGraphInfoArray[4];
                temp_str = diaryDescriptionArray[4];
                temp_src = diaryPictureArray[4];
            }
            else if(diaryresult == "type2gray"){
                temp_info = diaryGraphInfoArray[5];
                temp_str = diaryDescriptionArray[5];
                temp_src = diaryPictureArray[5];
            }
            else if(diaryresult == "type2red"){
                temp_info = diaryGraphInfoArray[6];
                temp_str = diaryDescriptionArray[6];
                temp_src = diaryPictureArray[6];
            }
            else if(diaryresult == "type2yellow"){
                temp_info = diaryGraphInfoArray[7];
                temp_str = diaryDescriptionArray[7];
                temp_src = diaryPictureArray[7];
            }
            else if(diaryresult == "type3brown"){
                temp_info = diaryGraphInfoArray[8];
                temp_str = diaryDescriptionArray[8];
                temp_src = diaryPictureArray[8];
            }
            else if(diaryresult == "type3gray"){
                temp_info = diaryGraphInfoArray[9];
                temp_str = diaryDescriptionArray[9];
                temp_src = diaryPictureArray[9];
            }
            else if(diaryresult == "type3red"){
                temp_info = diaryGraphInfoArray[10];
                temp_str = diaryDescriptionArray[10];
                temp_src = diaryPictureArray[10];
            }
            else if(diaryresult == "type3yellow"){
                temp_info = diaryGraphInfoArray[11];
                temp_str = diaryDescriptionArray[11];
                temp_src = diaryPictureArray[11];
            }
            else if(diaryresult == "type4brown"){
                temp_info = diaryGraphInfoArray[12];
                temp_str = diaryDescriptionArray[12];
                temp_src = diaryPictureArray[12];
            }
            else if(diaryresult == "type4gray"){
                temp_info = diaryGraphInfoArray[13];
                temp_str = diaryDescriptionArray[13];
                temp_src = diaryPictureArray[13];
            }
            else if(diaryresult == "type4red"){
                temp_info = diaryGraphInfoArray[14];
                temp_str = diaryDescriptionArray[14];
                temp_src = diaryPictureArray[14];
            }
            else if(diaryresult == "type4yellow"){
                temp_info = diaryGraphInfoArray[15];
                temp_str = diaryDescriptionArray[15];
                temp_src = diaryPictureArray[15];
            }
            
            if(result_show_flag){
                console.log("계속 돈다");
                var ctx = document.getElementById('myChart').getContext('2d');
                var myChart = new Chart(ctx, {
                    type : 'line',
                    data : {
                        labels : [ '스트레스', '수분', '영양소' ],
                        datasets : [ {
                            label : '',
                            data : [ temp_info.stress, temp_info.moisture,
                                temp_info.ingredient ],
                            backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(0, 255, 0, 0.2)' ],
                            borderColor : [ 'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)', 'rgba(0, 255, 0, 1)' ],
                            borderWidth : 1
                        } ]
                    },
                    options : {
                        
                        legend : {
                            showLines : false,
                            display : false
                        },
                        scales : {
                            yAxes : [ {
                                ticks : {
                                    beginAtZero : true,
                                    display : false
                                
                                },
                                gridLines : {
                                    lineWidth : 0
                                
                                }
                            } ]
                        }
                    }
                });
                result_show_flag = false;
            }
            
            $("#result_picture").attr("src", temp_src);
            $("#result_description").html(temp_str);
            $("input[name='save-data']").removeAttr("hidden", "hidden");
            $("#result_table").removeAttr("hidden", "hidden");
            $("#myChart").removeAttr("hidden", "hidden");
        }
    } //요기가 함수 끝
    
    function DiaryShow () {
        console.log("눌렀다");
        diaryresult = "";
        result_show_flag = true;
        $("#hopital_table").attr("hidden", "hidden");
        $("input[name='save-data']").attr("hidden", "hidden");
        $("#myChart").attr("hidden", "hidden");
        $("#result_table").attr("hidden", "hidden");
        
        $("#health_test_table").removeAttr("hidden", "hidden");
        $("#health-ment").html("STEP1.대변의 모양을 선택해주세요");
        
        $("#health-ment").removeAttr("hidden", "hidden");
        
        $("#health-ment").removeAttr("hidden", "hidden");
        $('#brown').attr('src', '../resources/img/type1_1.png');
        $('#gray').attr('src', '../resources/img/type2_1.png');
        $('#red').attr('src', '../resources/img/type3_1.png');
        $('#yellow').attr('src', '../resources/img/type4_1.png');
        
        $('#brown').attr('id', 'type1');
        $('#gray').attr('id', 'type2');
        $('#red').attr('id', 'type3');
        $('#yellow').attr('id', 'type4');
        
        $("#diary-container").show();
        $("#diary").fadeIn();
    }

    function SaveTest () {
        $.ajax({
            url : "<c:url value="/checkAvailSend"/>",
            type : "get",
            dataType : "text",
            success : function (flag) {
                if(flag == "success"){
                    InsertResult();
                }
                else if(flag == "error"){
                    alert("로그인을 해야 사용할 수 있는 기능입니다.\n로그인 페이지로 이동합니다.");
                    location.href = "<c:url value='/member/login'/>";
                }
            },
            error : function (e) {
                alert(Json.Stringify(e));
            }
        });
    }

    function ShowHospitalList () {
        $
                .ajax({
                    url : "<c:url value="/toilet/receive_near_hospital"/>",
                    type : "post",
                    data : {
                        lat : pos.lat.toFixed(6),
                        lng : pos.lng.toFixed(6)
                    },
                    success : function (list) {
                        $("#result_table").attr("hidden", "hidden");
                        $("#myChart").attr("hidden", "hidden");
                        $("input[name='save-data']").attr("hidden", "hidden");
                        var contents = "";
                        var list_temp = list;
                        for(var i = 0; i < 5; i++){
                            console.log(list_temp[i].dutyName);
                            
                            for(var i = 0; i < 5; i++){
                                contents += '<tr>';
                                contents += '<td style="float:left">' + ( i + 1 ) + '</td>';
                                contents += '</tr>';
                                
                                contents += '<tr style="float: left;">';
                                contents += '<td>병원 이름 : ' + list_temp[i].dutyName + ' 전화번호 : ' + list_temp[i].dutyTel1 + '</td>';
                                contents += '</tr>';
                                
                                contents += '<tr style="float: left;">';
                                contents += '<td style="width:100%">평일 개시시간 : ' + list_temp[i].dutyTimeS + ' 평일 종료시간 : ' + list_temp[i].dutyTimeC + '</td>';
                                contents += '</tr>';
                                
                                contents += '<tr style="float:left;">';
                                contents += '<td style="font-size:15px;">' + list_temp[i].dutyAddr + '</td>';
                                contents += '</tr>';
                            }
                            
                            $("#hopital_table").html(contents);
                            $("#hopital_table").removeAttr("hidden", "hidden");
                            
                            /* 						<tr style="float: left;">
                             <td>병원 이름 : 최평락한의원  전화번호 : 02-501-1488</td>															
                             </tr>
                             <tr style="float: left;">							
                             <td>평일 개시시간 : 0930,  평일 종료시간 : 1830</td>														
                             </tr>	
                             <tr style="float: left;border-bottom: 1px solid;">													
                             <td>서울특별시 강남구 영동대로 309, 2층 (대치동, 준오빌딩 2층)</td>		
                             <td><br></td>													
                             </tr>								 */

                        }
                    },
                    error : function (e) {
                        
                    }
                });
    }

    function InsertResult () {
        $
                .ajax({
                    url : "<c:url value="/diary/insert"/>",
                    type : "post",
                    dataType : "text",
                    data : {
                        stress : temp_info.stress,
                        moisture : temp_info.moisture,
                        ingredient : temp_info.ingredient,
                        status : temp_info.status
                    },
                    success : function (flag) {
                        if(flag == "warning"){
                            alert("데이터를 저장했지만 건강이 위험한 상태입니다.\n 반경 1km 병원의 위치를 알려드리겠습니다.");
                            ShowHospitalList();
                        }
                        else if(flag == "success"){
                            alert("저장에 성공했습니다. 프로필의 달력에서 기록을 확인 할 수 있습니다.");
                            $("#diary").hide();
                            $("#diary-container").fadeOut();
                            
                        }
                        else if(flag == "error"){
                            alert("저장이 실패하였습니다. 다시 시도해주세요.");
                        }
                    },
                    error : function () {
                        alert("에러");
                    }
                });
    }
</script>
</head>

<body class="">
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
	<input type = "hidden" id = "sessionId" value = "${sessionScope.sessionId}">
	<div id="Recent-container"></div>
	<div id="Recent" class="col-xl-4">
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


							<input id="x-button" name="feed-x-button" class="btn btn-sm btn-primary" value="X" onclick='$("#diary").hide(), $("#diary-container").fadeOut()'> <input id="register" hidden="hidden" name="save-data" class="btn btn-sm btn-primary" type="button" value="Save Data" onclick="SaveTest()"> <br>
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

						<table id="hopital_table" hidden="hidden">

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
					<li class="nav-item"><a class="nav-link " href="<c:url value="/maps/mapsMain"/>">
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
				<a class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block" href="<c:url value="/maps/mapsMain2"/>">Transit</a>
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
		<div class="header bg-gradient-primary pb-8 pt-5 pt-md-8">
			<div class="container-fluid">
				<div class="header-body"></div>
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
			<!-- Card stats -->
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
	<!--   Optional JS   -->
	<script>
        // Note: This example requires that you consent to location sharing when
        // prompted by your browser. If you see the error "The Geolocation service
        // failed.", it means you probably did not give permission for the browser to
        // locate you.
        var map, pos, marker, i, nearbyToilet;
        var locations = [ ];
        window.onload = function () {
            infowindow = new google.maps.InfoWindow();
        }

        function initMap () {
            map = new google.maps.Map(document.getElementById('map'), {
                center : {
                    lat : 38.903301,
                    lng : -77.035532
                },
                zoom : 14,
                mapTypeId : google.maps.MapTypeId.ROADMAP
            });
            infoWindow = new google.maps.InfoWindow();
            
            // 내위치설정
            if(navigator.geolocation){
                navigator.geolocation
                        .getCurrentPosition(function (position) {
                            pos = {
                                lat : 38.903301,
                                lng : -77.035532
                            };
                            $.ajax({
                                url : "<c:url value='/maps/getLocation2'/>",
                                data : {
                                    lat : pos.lat.toFixed(6),
                                    lng : pos.lng.toFixed(6)
                                },
                                type : "post",
                                success : setMarkers,
                                error : function (e) {
                                    console.log(e)
                                }
                            })
                            infoWindow.setPosition(pos);
                            infoWindow.setContent('Location found.');
                            infoWindow.open(map);
                            map.setCenter(pos);
                            console.log("this location : " + JSON
                                    .stringify(pos));
                            document.getElementById('start').value = pos.lat + "," + pos.lng
                        }, function () {
                            handleLocationError(true, infoWindow, map
                                    .getCenter());
                        });
            }
            else{
                // Browser doesn't support Geolocation
                handleLocationError(false, infoWindow, map.getCenter());
            }
            
            //마커설정
            function setMarkers (e) {
                //nearbyToilet = e
                //console.log(nearbyToilet[0])
                /* for(var i = 0; i < nearbyToilet.length; i++){
                    //locations[i].lat = nearbyToilet[i].lat;
                    //locations[i].lng = nearbyToilet[i].lng;
                     locations[i] = {
                        lat : nearbyToilet[i].lat,
                        lng : nearbyToilet[i].lng
                    } 
                   
                } */
                locations[0] = {
                    lat : 38.905802,
                    lng : -77.029213
                }
                locations[1] = {
                    lat : 38.904146,
                    lng : -77.042485
                }
                locations[2] = {
                    lat : 38.914466,
                    lng : -77.033995
                }
                locations[3] = {
                    lat : 38.889109,
                    lng : -77.005504
                }
                locations[4] = {
                    lat : 38.908440,
                    lng : -76.992326
                }

                var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
                for(var i = 0; i < locations.length; i++){
                    marker = new google.maps.Marker({
                        id : i,
                        position : new google.maps.LatLng(locations[i].lat, locations[i].lng),
                        label : labels[i % labels.length],
                        map : map
                    });
                    
                    google.maps.event
                            .addListener(marker, 'click', ( function (marker, i) {
                                return function () {
                                    console.log(i);
                                    infowindow
                                            .setContent(locations[i].contents);
                                    infowindow.open(map, marker);
                                }
                            } )(marker, i));
                    if(marker){
                        marker.addListener('click', function () {
                            map.setZoom(14);
                            map.setCenter(this.getPosition());
                            target = this.getPosition()
                            target = String(target)
                            target = target.replace('(', '');
                            target = target.replace(')', '');
                            target = target.replace(' ', '');
                            console.log("target location : " + target);
                            document.getElementById('end').value = target;
                            console.log("start : " + document
                                    .getElementById('start').value);
                            console.log("end : " + document
                                    .getElementById('end').value);
                            onChangeHandler();
                            
                        });
                    }
                }
            }
            // Create an array of alphabetical characters used to label the markers.
            
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

            // Add a marker clusterer to manage the markers.
            /*var markerCluster = new MarkerClusterer(map, marker,
            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});*/

            //길찾기설정
            var directionsService = new google.maps.DirectionsService();
            var directionsRenderer = new google.maps.DirectionsRenderer();
            directionsRenderer.setMap(map);
            
            var onChangeHandler = function () {
                calculateAndDisplayRoute(directionsService, directionsRenderer);
            };
            
            //document.getElementById('start').addEventListener('change', onChangeHandler);
            // document.getElementById('end').addEventListener('change', onChangeHandler);
            
        }

        function handleLocationError (browserHasGeolocation, infoWindow, pos) {
            infoWindow.setPosition(pos);
            infoWindow.setContent(browserHasGeolocation
                    ? 'Error: The Geolocation service failed.'
                    : 'Error: Your browser doesn\'t support geolocation.');
            infoWindow.open(map);
        }

        function calculateAndDisplayRoute (directionsService, directionsRenderer) {
            directionsService.route({
                origin : {
                    query : document.getElementById('start').value
                },
                destination : {
                    query : document.getElementById('end').value
                },
                travelMode : 'TRANSIT'
            }, function (response, status) {
                if(status === 'OK'){
                    directionsRenderer.setDirections(response);
                }
                else{
                    //window.alert('Directions request failed due to ' + status);
                }
            });
        }

        //마커 위치설정
        //lat, lng, 
        //contents(내용),
        //
        
        /* locations = [ {
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
        } ] */

        /* https://maps.googleapis.com/maps/api/directions/json?origin=41.43206,-81.38992&destination=41.43206,-81.8992&key=AIzaSyDkQ00U2AUBQSS1CJF5YveL-1YWsTjaRGA*/

        /*https://maps.googleapis.com/maps/api/directions/json?origin=37.5728359,126.9746922&destination=37.5129907,127.1005382&key=AIzaSyDkQ00U2AUBQSS1CJF5YveL-1YWsTjaRGA*/
        /*https://maps.googleapis.com/maps/api/directions/
         json?origin=37.5728359,126.9746922&destination=37.5129907,127.1005382&mode=transit&departure_time=now&key=AIzaSyDkQ00U2AUBQSS1CJF5YveL-1YWsTjaRGA&callback=initMap*/
    </script>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDkQ00U2AUBQSS1CJF5YveL-1YWsTjaRGA&callback=initMap">
        
    </script>
</body>

</html>