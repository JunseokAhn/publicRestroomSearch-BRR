<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>화장실이 급할땐? - 부르르</title>




<link href="<c:url value="/resources/assets/img/brand/favicon.png"/>" rel="icon" type="image/png">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<!-- <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  	 -->
<link rel="stylesheet" href="../resources/css/hover.css">	
<!-- <link href="/resources/css/main.css" rel="stylesheet" type="text/css"> -->
<link href="<c:url value="/resources/assets/css/argon-dashboard.css?v=1.1.2"/>" rel="stylesheet" />
<link href="<c:url value="/resources/css/boardStyle.css"/>" rel="stylesheet" />
<link href="<c:url value="/resources/assets/js/plugins/@fortawesome/fontawesome-free/css/all.min.css"/>" rel="stylesheet" />
<link href="<c:url value="/resources/assets/js/plugins/nucleo/css/nucleo.css"/>" rel="stylesheet" /> 



<!-- <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script> -->
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> -->
<script src="<c:url value="/resources/js/jquery-3.4.1.js/"/>"></script>
<!-- <script src="/resources/js/board.js" ></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" integrity="sha256-R4pqcOYV8lt7snxMQO/HSbVCFRPMdrhAFMH+vr9giYI=" crossorigin="anonymous"></script>

<!--달력 -->
<script type="text/javaScript">

var today_info;
var date_list;

var test_result_list;
var test_result_index=0;

var user_id;

//대변 체크 결과
 var temp_info;
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
        
        new diaryGraphInfo(0, 5, 5, 2 ),
        new diaryGraphInfo(2, 1, 1, 4),
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

var pos = 
    function(lat, lng)
    {
    	this.lat = lat;
    	this.lng = lng;    	
    	return this;
    };
    
var lat;
var lng;
var now_pos;
function FindMyPos()
{
    // HTML5의 geolocation으로 사용할 수 있는지 확인합니다      
    if(navigator.geolocation)
    {       
    	navigator.geolocation.getCurrentPosition
    	(
    	    function (position) 
    	    {
    			lat = position.coords.latitude;
    			lng = position.coords.longitude;
    			now_pos=new pos(lat.toFixed(6),lng.toFixed(6));

    			console.log(now_pos.lat);
    			console.log(now_pos.lng);
    	    }
    	)
    	
    }
    else
    {
    	 console.log("불가능");
    }
}


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
			console.log(temp_info.stress,temp_info.moisture ,temp_info.ingredient)
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
				    	responsive: false,
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
    console.log("눌렀다");        
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
					alert(Json.Stringify(e));
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
						FindMyPos();
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
				function()
				{
					alert("에러");
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
				lat : now_pos.lat,
    			lng : now_pos.lng
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
					
					
					for(var i =0;i<5;i++)
					{
						contents+='<tr>';
						contents+='<th scope="col" style="text-align: left; font-size:14px;">'+(i+1) +'. 병원 이름 : ' + list_temp[i].dutyName + ' 전화번호 : ' + list_temp[i].dutyTel1+'<br>';
						contents+='평일 개시시간 : '+ list_temp[i].dutyTimeS + ' 평일 종료시간 : ' + list_temp[i].dutyTimeC +'<br>';
						contents+= '주소: '+ list_temp[i].dutyAddr;
						contents+='</th>';							
						contents+='</tr>';							
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

//그 달의 기록을 가져오는 함수
function getData(input_year, input_month,input1,input2)
{	
	//그에 따른 일 수
	$.ajax
	({
		url: "<c:url value='/calendar/diaryGetResultData'/>",
		type : "post",
		data:{year:input_year, month:input_month,id:user_id},
		success: 
        	function(value)
        	{        		
        		console.log("데이터 들고 오기 성공");
				test_result_list = value;			
				test_result_index=0;
				if(input1!=-9999&&input2!=-9999)
					getDays(input1,input2);					
    		}
		,
    	error: 
        	function()
        	{
    			console.log("일 수 받아오기 실패");
    		}			
	});	
}


//해당 년도와 달의 일수를 받아오는 함수
function getDays(input1, input2)
{
	if(input1!=-9999&&input2!=-9999)
	{
		//그에 따른 일 수
		$.ajax
		({
			url: "<c:url value='/calendar/diaryGetDate'/>",
			type : "post",
			data:{year:input1, month:input2},
			success: 
	        	function(value)
	        	{        		
					console.log("일 수 받아오기 성공");
					date_list=value;
					printDate();
	    		}
			,
	    	error: 
	        	function()
	        	{
	    			console.log("일 수 받아오기 실패");
	    		}			
		});
	}
	else
	{
		//그에 따른 일 수
		$.ajax
		({
			url: "<c:url value='/calendar/diaryGetDate'/>",
			type : "post",
			success: 
	        	function(value)
	        	{        	
					console.log("일 수 받아오기 성공");	
					date_list=value;
					printDate();
	    		}
			,
	    	error: 
	        	function()
	        	{
	    			console.log("일 수 받아오기 실패");
	    		}			
		});	
	}	
}


//초기화 함수
function Init(input1, input2)
{
	if(input1!=-9999&&input2!=-9999)
	{
		//년도랑 달
		$.ajax
		({
			url: "<c:url value='/calendar/diaryRecord'/>",
			type : "post",
			data:{year:input1, month:input2}
			,
	    	success: 
	        	function(value)
	        	{        	
	    			console.log("년도랑 월 수 받아오기 성공");			    						
	    			today_info=value;	    			
	    			getData(today_info.search_year, today_info.search_month,input1,input2); 
	    			//getDays(input1, input2); 			
	    		}
			,
	    	error: 
	        	function()
	        	{
	    			console.log("년도랑 월 수 받아오기 실패");
	    		}			
		});		
	}
	else
	{
		console.log("여기에서 시작");
		//년도랑 달
		$.ajax
		({
			url: "<c:url value='/calendar/diaryRecord'/>",
			type : "post",
			success: 
	        	function(value)
	        	{        	
					console.log("년도랑 월 수 받아오기 성공");					    	
					today_info=value;								
					getData(today_info.search_year, today_info.search_month);		
					//getDays();						
	    		}
			,
	    	error: 
	        	function()
	        	{
	    			console.log("년도랑 월 수 받아오기 실패");
	    		}			
		});		
	}		
}

function ShowResult(stress,moisture,ingredient,status)
{		
	$("input[name='save-data']").attr("hidden","hidden");
	$("#myChart").attr("hidden","hidden");
	$("#health-ment").attr("hidden","hidden");
	$("#health_test_table").attr("hidden","hidden");
	
	var temp_str;
	var temp_pic;
	
	for(var i =0;i<diaryGraphInfoArray.length;i++)
	{
		if(diaryGraphInfoArray[i].stress==stress&&diaryGraphInfoArray[i].moisture==moisture&&diaryGraphInfoArray[i].ingredient==ingredient)
		{			
			temp_pic = diaryPictureArray[i];
			temp_str = diaryDescriptionArray[i];
			break;
		}		
	}
	
	$("#result_picture").attr("src",temp_pic);
	$("#result_description").html(temp_str);
	

	$("#result_table").removeAttr("hidden","hidden");				
	
	$("#diary-container").show();
	$("#diary").fadeIn();
}
//달력 출력하는 함수
function printDate()
{		
	 //달 년도 표기
	var str_this_month ="";
	str_this_month+=today_info.search_year + ".";
		
	if(today_info.search_month<10)
	{
		str_this_month+=0;
	}
					
	str_this_month += today_info.search_month;        	
	$(".this_month").html(str_this_month);
	//여기까지 (달,년도)
	
	 var days_this_month="";
	//일 수 출력
	var test_date_index=0;
	for(var i=0;i<date_list.length;i++)
	{		
		 if(date_list[i].value=='today')
		{			
			if(i%7==0)
			{
				days_this_month+="<tr>";
			}
			days_this_month+="<td class='today'>";
			days_this_month+="<div class='date' style='width:100px;'>";		
		}
		 else if(i%7==6)
		{
			days_this_month+="<td class='sat_day'>";
			days_this_month+="<div class='sat' style='width:100px;'>";
		}
		 else if(i%7==0)
		{
			days_this_month+="</tr>";
			days_this_month+="<tr>";
			days_this_month+="<td class='sun_day'>";
			days_this_month+="<div class='sun' style='width:100px;'>";			 
		}
		 else
		{
			days_this_month+="<td class='normal_day'>";
			days_this_month+="<div class='date' style='width:100px;'>";		 
		}	

		 days_this_month+= date_list[i].date;

		if(test_result_list.length!=0&&test_result_index<test_result_list.length)
		{			
			if(date_list[i].date==test_result_list[test_result_index].day)
			{				
				for(test_result_index;test_result_index<test_result_list.length;test_result_index++)
				{	
					if(date_list[i].date!=test_result_list[test_result_index].day)
						break;
					
					//위험
					if(test_result_list[test_result_index].status==1)
					{
						days_this_month+="<br><img class='hvr-grow-shadow'  src='../resources/img/warning.png' style='width:30%;height:30%' onclick='javascript:ShowResult("+test_result_list[test_result_index].stress+","+test_result_list[test_result_index].moisture+","+test_result_list[test_result_index].ingredient+","+test_result_list[test_result_index].status+");'/>";					
					}	
					//경고	
					else if(test_result_list[test_result_index].status==2)
					{
						days_this_month+="<br><img class='hvr-grow-shadow' src='../resources/img/danger.png' style='width:30%;height:30%' onclick='javascript:ShowResult("+test_result_list[test_result_index].stress+","+test_result_list[test_result_index].moisture+","+test_result_list[test_result_index].ingredient+","+test_result_list[test_result_index].status+");'/>";						
					}	
					//보통	
					else if(test_result_list[test_result_index].status==3)
					{
						days_this_month+="<br><img class='hvr-grow-shadow'  src='../resources/img/normal.png' style='width:30%;height:30%' onclick='javascript:ShowResult("+test_result_list[test_result_index].stress+","+test_result_list[test_result_index].moisture+","+test_result_list[test_result_index].ingredient+","+test_result_list[test_result_index].status+");'/>";		
					}
					//건강
					else if(test_result_list[test_result_index].status==4)
					{
						days_this_month+="<br><img class='hvr-grow-shadow'  src='../resources/img/good.png' style='width:30%;height:30%' onclick='javascript:ShowResult("+test_result_list[test_result_index].stress+","+test_result_list[test_result_index].moisture+","+test_result_list[test_result_index].ingredient+","+test_result_list[test_result_index].status+");'/>";
					}					
				}					
			}
		}
		 days_this_month+="</div></td>";		
		
	} 
	
	$("#days").html(days_this_month); 	
	
}



function GoPrevMonth()
{
	Init((today_info.before_year),(today_info.before_month));	
}

function GoPrevYear()
{
	Init((today_info.search_year-1),(today_info.search_month-1));	
}

function GoNextMonth()
{
	Init((today_info.after_year),(today_info.after_month));	
}

function GoNextYear()
{
	Init((today_info.search_year+1),(today_info.search_month-1));	
}

//최근 이용했던 화장실
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
		if(id != null && id != "") {
			var content = "<table>";
			$("#Recent-contents").val("");
			$("input[name='Recent-x-button']").html();
			$("#Recent-contents").html();
			$("#Recent-container").show();
			$("#Recent").slideDown();
			content += '<h3 class="text-uppercase text-muted ls-1 mb-1">' + "최근이용 화장실" + "</h3>";
			for(var i = 0; i < 3; i++) {
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
		} else if(list.list1.length == 0 && id != null && id != ""){
			alert("저장된 데이터가 없습니다. 한 번 이상 길찾기를 해주세요.");
			return false;
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

//선호 화장실 출력
//선호하는 화장실
function Prefer() 
{
	var id = $("#sessionId").val();
	$.ajax({
	url : "<c:url value='/dayaver/recent'/>",
	type : "GET" ,
	data : {
			id : id
	},
	success : function(list) {
		console.log(list);
		if(id != null && id != "") {
			var content = "<table>";
			$("#Prefer-contents").val("");
			$("input[name='Prefer-x-button']").html();
			$("#Prefer-contents").html();
			$("#Prefer-container").show();
			$("#Prefer").slideDown();
				
			content += '<h3 class="text-uppercase text-muted ls-1 mb-1">' + "선호하는 화장실" + "</h3>";
			for(var i = 0; i < 3; i++) {
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
		}
		else if(list.list2.length == 0 && id != null && id != "")
		{
			alert("저장된 데이터가 없습니다. 한 번 이상 길찾기를 해주세요.");
			return false;
		}
		else
		{
			alert("로그인 후 사용가능 한 기능입니다 로그인 후 사용해주세요");
			location.href = "../member/login";
		}
	},
	error : function(e) {
		alert(JSON.stringify(e));
	}
	});
}

	$(
			function()
			{				
				window.myWidgetParam ? window.myWidgetParam : window.myWidgetParam = []; 
				window.myWidgetParam.push({id: 18,cityid: '1835848',appid: 'c08b376c4c1ca3b5e593c4991d91eb3c',
				units: 'metric',containerid: 'openweathermap-widget-18',  });  
				(function() {var script = document.createElement('script');script.async = true;script.charset = "utf-8";
					script.src = "//openweathermap.org/themes/openweathermap/assets/vendor/owm/js/weather-widget-generator.js";
						var s = document.getElementsByTagName('script')[0];s.parentNode.insertBefore(script, s);  })();
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
		    		
				user_id =$("#UseForCalenderById").val();
				Init(-9999,-9999);
			}
	);	
</script>

		
<style TYPE="text/css">	

			body 
			{
				scrollbar-face-color: #F6F6F6;
				scrollbar-highlight-color: #bbbbbb;
				scrollbar-3dlight-color: #FFFFFF;
				scrollbar-shadow-color: #bbbbbb;
				scrollbar-darkshadow-color: #FFFFFF;
				scrollbar-track-color: #FFFFFF;
				scrollbar-arrow-color: #bbbbbb;
				margin-left:"0px"; margin-right:"0px"; margin-top:"0px"; margin-bottom:"0px";
			}

			td {font-family: "돋움"; font-size: 9pt; color:#595959;}
			th {font-family: "돋움"; font-size: 9pt; color:#000000;}
			select {font-family: "돋움"; font-size: 9pt; color:#595959;}

			.divDotText 
			{
				overflow:hidden;
				text-overflow:ellipsis;
			}

			a:link { font-size:9pt; font-family:"돋움";color:#000000; text-decoration:none; }
			a:visited { font-size:9pt; font-family:"돋움";color:#000000; text-decoration:none; }
			a:active { font-size:9pt; font-family:"돋움";color:red; text-decoration:none; }
			a:hover { font-size:9pt; font-family:"돋움";color:red;text-decoration:none;}
			
			.day
			{
				width:100px; 
				height:30px;
				font-weight: bold;
				font-size:15px;
				font-weight:bold;
				text-align: center;
			}
			
			.sat
			{
				color:#529dbc;
			}
			
			.sun
			{
				color:red;
			}
			
			.today_button_div
			{
				float: right;
			}
			
			.today_button
			{
				width: 100px; 
				height:30px;
			}
			
			.calendar
			{
				width:70%;
				margin:auto;
			}
			
			.navigation
			{
				margin-top:100px;
				margin-bottom:30px;
				text-align: center;
				font-size: 25px;
				vertical-align: middle;
			}
			
			.calendar_body
			{
				width:100%;
				background-color: #FFFFFF;
				border:1px solid white;
				margin-bottom: 50px;
				border-collapse: collapse;
			}
			
			.calendar_body .today
			{
				border:1px solid white;
				height:120px;
				background-color:#c9c9c9;
				text-align: left;
				vertical-align: top;
			}
			
			.calendar_body .date
			{
				font-weight: bold;
				font-size: 15px;
				padding-left: 3px;
				padding-top: 3px;
			}
			
			.date
			{
				margin-bottom:10px;
			}
			
			.sat
			{
				margin-bottom:10px;
			}
			
			.sun
			{
				margin-bottom:10px;
			}
			
			.calendar_body .sat_day
			{
				border:1px solid white;
				height:120px;
				background-color:#EFEFEF;
				text-align:left;
				vertical-align: top;
			}
			
			.calendar_body .sat_day .sat
			{
				color: #529dbc; 
				font-weight: bold;
				font-size: 15px;
				padding-left: 3px;
				padding-top: 3px;
			}
				
			.calendar_body .sun_day
			{
				border:1px solid white;
				height:120px;
				background-color:#EFEFEF;
				text-align: left;
				vertical-align: top;
			}
				
			.calendar_body .sun_day .sun
			{
				color: red; 
				font-weight: bold;
				font-size: 15px;
				padding-left: 3px;
				padding-top: 3px;
			}
			.calendar_body .normal_day
			{
				border:1px solid white;
				height:120px;
				background-color:#EFEFEF;
				vertical-align: top;
				text-align: left;
			}
			
			.before_after_month
			{
				margin: 10px;
				font-weight: bold;
			}
				
			.before_after_year
			{
				font-weight: bold;
			}
			
			.this_month
			{
				margin: 10px;
			}
			
			.schdule_add_button
			{
				float:right;
			}		
</style>
</head>

<body class="">
	<input type="hidden" id="Profile" name="profile_image" value="${sessionScope.Profile}">
	<input type="hidden" id="sessionNickname" name="nickname" value="${sessionScope.sessionNickname}">
	<input type="hidden" id="sessionId" name="sessionId" value="${sessionScope.sessionId}">
	
	<!-- 최근 이용 화장실 nav-->
	<div id="Recent-container" style="display:none;"></div>
	<div id="Recent" class="col-xl-4" style="display:none;">
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
						<div class="card card-stats mb-4 mb-xl-0" id="Recent-contents">
						</div>
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
						<div class="card card-stats mb-4 mb-xl-0" id="Prefer-contents">
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<!-- 이메일 피드백 -->
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
	<!-- 이메일 피드백 끝 -->
	
	<!-- 다이어리 -->
	<div id="diary-container" style="display:none;"></div>	
	<div id="diary" class="col-xl-4" style="display:none;">
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
					<!-- 결과 그래프 출력  width="382" height="152"-->
					<canvas id="myChart" hidden="hidden" draggable="false" style=" width:100%; height:100%;"></canvas>					
					<table id="result_table"  hidden="hidden">
						<tr>							
							<td>
								<img id="result_picture" src=""  style="width:50%" />
							</td>
							<td>
								<p id="result_description"></p> 
							</td>
						</tr>
					</table>
					
					<table id="hopital_table"  class="table align-items-center table-flush"  hidden="hidden">
														
					</table>
					
					<!-- 테스트 목록 출력 -->
					<table id="health_test_table">
						<tr>
							<td style="width:230px;height:150px;"> 
								<img id="type1" class="hvr-grow-shadow"  name="1" src="../resources/img/type1_1.png" style="width:90%;"  />
							</td>
							<td style="width:230px;height:150px;">
								<img id="type2" class="hvr-grow-shadow" name="2" src="../resources/img/type2_1.png" style="width:90%; " />
							</td>
						</tr>
						<tr>
							<td style="width:230px;height:150px;">
								<img id="type3" class="hvr-grow-shadow" name="3" src="../resources/img/type3_1.png" style="width:90%"/>
							</td>
							<td style="width:230px;height:150px;">
								<img id="type4" class="hvr-grow-shadow" name="4" src="../resources/img/type4_1.png" style="width:90%" />
							</td>
						</tr>
					</table>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- 다이어리 끝 -->
	

	
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
							<span class="avatar avatar-sm rounded-circle"> 
							<c:if test="${sessionScope.sessionId != null}">
								<img alt="Image placeholder" src="${sessionScope.Profile}">
							</c:if>
							<c:if test="${sessionScope.sessionId == null}">
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

					<li class="nav-item"><br> <br>
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
	<!-- 네비끝 -->
	
		<!-- Header -->
		<div class="header pb-8 pt-5 pt-lg-8 d-flex align-items-center" style="min-height: 600px; background-image: url(<c:url value="${sessionScope.Profile}"/>); background-size: cover; background-position: center top;">
			<!-- Mask -->
			<span class="mask bg-gradient-default opacity-8"></span>
			<!-- Header container -->
			<div class="container-fluid d-flex align-items-center">
				<div class="row">
					<div class="col-lg-7 col-md-10">
						<c:if test="${sessionScope.sessionNaver != null}">
						<h1 class="display-2 text-white">${sessionScope.sessionNickname}</h1>
						<p class="text-white mt-0 mb-5">${sessionScope.sessionNickname}님 brr를 이용해 주셔서 감사합니다.</p>
						</c:if>
						<c:if test="${sessionScope.sessionNaver == null}">
						<h1 class="display-2 text-white">${sessionScope.sessionNickname}</h1>
						<p class="text-white mt-0 mb-5">${sessionScope.sessionNickname}님 brr를 이용해 주셔서 감사합니다.</p>
						</c:if>
<!-- 						<a href="#!" class="btn btn-info">Edit profile</a> -->
					</div>
				</div>
			</div>
			
			<div class="col-xl-8 order-xl-1" >
					<div class="card bg-secondary shadow" style="width: 70%; position: relative; left: 300px;">
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
						<div class="card-body" >
							<form>
								<h6 class="heading-small text-muted mb-4">User information</h6>
								<div class="pl-lg-4">
									<div class="row">
										<div class="col-lg-6">
											<div class="form-group">
												<c:if test="${sessionScope.sessionNaver != null}">
												<label class="form-control-label" for="input-username">Username</label> <input type="text" id="input-username" class="form-control form-control-alternative" style="color:black;"  value="${sessionScope.sessionNickname}">
												</c:if>
												<c:if test="${sessionScope.sessionGooglename != null}">
												<label class="form-control-label" for="input-username">Username</label> <input type="text" id="input-username" class="form-control form-control-alternative" style="color:black;"  value="${sessionScope.sessionGooglename}">
												</c:if>
											</div>
										</div>
										<div class="col-lg-6">
											<div class="form-group">
												<label class="form-control-label" for="input-email">Email address</label> <input type="email" id="input-email" class="form-control form-control-alternative" style="color:black;" value="${sessionScope.sessionEmail}">
											</div>
										</div>
									</div>									
								</div>
								<hr class="my-4" />																			
							</form>
						</div>
					</div>
				</div>
			
			
		</div>
		<!-- Page content -->
		
		<%-- <!-- 여기서부터 신경 써야한다.  -->
		<div class="container-fluid mt--7" style="width:1600px;margin: 0 auto;">
			<div class="row">				
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
												<c:if test="${sessionScope.sessionNaver != null}">
												<label class="form-control-label" for="input-username">Username</label> <input type="text" id="input-username" class="form-control form-control-alternative" placeholder="Username" value="${sessionScope.sessionNickname}">
												</c:if>
												<c:if test="${sessionScope.sessionNaver != null}">
												<label class="form-control-label" for="input-username">Username</label> <input type="text" id="input-username" class="form-control form-control-alternative" placeholder="Username" value="${sessionScope.sessionNickname}">
												</c:if>
											</div>
										</div>
										<div class="col-lg-6">
											<div class="form-group">
												<label class="form-control-label" for="input-email">Email address</label> <input type="email" id="input-email" class="form-control form-control-alternative" placeholder="${sessionScope.sessionEmail}">
											</div>
										</div>
									</div>									
								</div>
								<hr class="my-4" />																			
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- 여기까지  --> --%>
			
<!-- 달력 -->
	<input type="hidden" id="UseForCalenderById" value="${sessionScope.sessionId}">
	<form name="calendarFrm" id="calendarFrm" action="" method="GET">
	</form>
	
	<div class="calendar" >
		<div class="navigation">
			<!-- 이전해 -->
			<a class="before_after_year" href="javascript:GoPrevYear();">&lt;&lt;</a>
			<!-- 이전달 --> 
			<a class="before_after_month" href="javascript:GoPrevMonth();">	&lt;</a> 
			<span class="this_month">
				&nbsp;				
			</span>
			<!-- 다음달 -->
			<a class="before_after_month" href="javascript:GoNextMonth()">&gt;</a> 
			<!-- 다음해 -->
			<a class="before_after_year" href="javascript:GoNextYear()">&gt;&gt;</a> 			
		</div>
	</div>
	
	<table class="calendar_body">
		<thead>
			<tr bgcolor="#CECECE">
				<td class="day sun" >일	</td>
				<td class="day" >	월</td>
				<td class="day" >	화</td>
				<td class="day" >	수</td>
				<td class="day" >	목</td>
				<td class="day" >	금</td>
				<td class="day sat" >토</td>
			</tr>
		</thead>
		<tbody id="days">
				
		</tbody>
	</table>



<!-- 달력 여기까지 -->			
			<!-- Footer -->
			<footer class="footer">
				<div class="row align-items-center justify-content-xl-between">
					<div class="col-xl-6">
						<div class="copyright text-center text-xl-left text-muted">
							&copy; 2020 <a href="https://www.creative-tim.com" class="font-weight-bold ml-1" target="_blank">Create By BRR</a>
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

