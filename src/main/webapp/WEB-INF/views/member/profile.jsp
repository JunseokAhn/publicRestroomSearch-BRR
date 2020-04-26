<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 달력 임포트 -->

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
<link href="<c:url value="/resources/css/boardStyle.css"/>" rel="stylesheet" />
<link href="<c:url value="/resources/assets/css/argon-dashboard.css?v=1.1.2"/>" rel="stylesheet" />
<script src="<c:url value="/resources/js/jquery-3.4.1.js/"/>"></script>

<!--달력 -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<!-- jquery datepicker -->
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  	
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	
	
<link href="/resources/css/main.css" rel="stylesheet" type="text/css">
<script src="/resources/js/board.js" ></script>
<script type="text/javaScript" language="javascript"></script>

<!-- 차트 -->
<link rel="stylesheet" href="../resources/css/hover.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" integrity="sha256-R4pqcOYV8lt7snxMQO/HSbVCFRPMdrhAFMH+vr9giYI=" crossorigin="anonymous"></script>

<!--달력 -->
<script type="text/javaScript">

var today_info;
var date_list;

var test_result_list;
var test_result_index=0;

var user_id;

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
	var ctx = document.getElementById('myChart').getContext('2d');
	var myChart = new Chart(ctx, {
	    type: 'line',
	    data: {
	        labels: ['스트레스', '수분', '영양소'],
	        datasets: [{
	            label: '',
	            data: [stress, moisture, ingredient],
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
	$("#result_table").removeAttr("hidden","hidden");
	$("#myChart").removeAttr("hidden","hidden");
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
						days_this_month+="<br><img class='hvr-grow-shadow'  src='../resources/img/warning.png' style='width:30%;height:30%' />";						
					}	
					//경고	
					else if(test_result_list[test_result_index].status==2)
					{
						days_this_month+="<br><img class='hvr-grow-shadow' src='../resources/img/danger.png' style='width:30%;height:30%' onclick='javascript:ShowResult("+test_result_list[test_result_index].stress+","+test_result_list[test_result_index].moisture+","+test_result_list[test_result_index].ingredient+","+test_result_list[test_result_index].status+");'/>";						
					}	
					//보통	
					else if(test_result_list[test_result_index].status==3)
					{
						days_this_month+="<br><img class='hvr-grow-shadow'  src='../resources/img/normal.png' style='width:30%;height:30%' />";		
					}
					//건강
					else if(test_result_list[test_result_index].status==4)
					{
						days_this_month+="<br><img class='hvr-grow-shadow'  src='../resources/img/good.png' style='width:30%;height:30%' onclick='javascript:ShowResult();'/>";	
					}					
				}					
			}
		}
		 days_this_month+="</div></td>";
		//days_this_month+= date_list[i].date +"</div></td>";		
		
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

	$(
			function()
			{
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
	<!-- 차트 폼 -->
	<div id="diary-container" style="display: none"></div>	
	<div id="diary" class="col-xl-4" style="display:none" >
		<form action="">
			<div class="card shadow">
				<div class="card-header bg-transparent">
					<div class="row align-items-center">
						<div class="col">
							<h2 class="mb-0" style="display: inline-block">Health Chart</h2>
							<input id="x-button" name="feed-x-button" class="btn btn-sm btn-primary" value="X" onclick='$("#diary").hide(), $("#diary-container").fadeOut()'> <input id="register" hidden="hidden" name="save-data" class="btn btn-sm btn-primary" type="button" value="Save Data" onclick="SaveTest()"> <br>
						</div>
					</div>
					<div class="card-body2">
					<!-- 결과 그래프 출력 -->
					<canvas id="myChart" hidden="hidden" width="5" height="2"></canvas>					
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
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- 차트 폼 끝 -->
	
	<nav class="navbar navbar-vertical fixed-left navbar-expand-md navbar-light bg-white" id="sidenav-main">
		<div class="container-fluid">
			<!-- Toggler -->
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<!-- Brand -->
			<a class="navbar-brand pt-0" href="<c:url value="/maps/mapsMain"/>"> <img src="<c:url value="/resources/img/Logo.png"/>" class="navbar-brand-img" alt="...">
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
						<a href="<c:url value="/profile"/>" class="dropdown-item"> <i class="ni ni-single-02"></i> <span>My profile</span>
						</a> 
						<a href="<c:url value="/board/listSNS"/>" class="dropdown-item"> <i class="ni ni-settings-gear-65"></i> <span>SNS</span></a>
<%-- 						</a> <a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-calendar-grid-58"></i> <span>Activity</span> --%>
<%-- 						</a> <a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-support-16"></i> <span>Support</span> --%>
<!-- 						</a> -->
						<div class="dropdown-divider"></div>
						<a href="/member/logout" class="dropdown-item"> <i class="ni ni-user-run"></i> <span>Logout</span>
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
					<li class="nav-item"><a class="nav-link  active " href="<c:url value="/maps/mapsMain"/>"> <i class="ni ni-pin-3 text-orange"></i> Maps
					</a></li>
					<li class="nav-item"><a class="nav-link " href="<c:url value="/board/listSNS"/>"> <i class="ni ni-tv-2 text-primary"></i> SNS
					</a></li>
					<%-- <li class="nav-item  active "><a class="nav-link " href="<c:url value="/examples/index"/>">
							<i class="ni ni-tv-2 text-primary"></i> Dashboard
						</a></li> //nav-item  active는 무조건 검정색으로 표시됩니다. --%>
<%-- 					<li class="nav-item"><a class="nav-link " href="<c:url value="/examples/icons"/>"> <i class="ni ni-planet text-blue"></i> Icons --%>
<!-- 					</a></li> -->

					<li class="nav-item"><a class="nav-link " href="<c:url value="/diary/diaryMain"/>"> <i class="ni ni-bullet-list-67 text-red"></i> diary
					</a></li>
					<c:if test="${sessionScope.sessionId == null }">
						<li class="nav-item"><a class="nav-link" href="<c:url value="/member/login"/>"> <i class="ni ni-key-25 text-info"></i> Login
						</a></li>
<%-- 						<li class="nav-item"><a class="nav-link" href="<c:url value="/examples/register"/>"> <i class="ni ni-circle-08 text-pink"></i> Sign up --%>
<!-- 						</a></li> -->
					</c:if>
					<c:if test="${sessionScope.sessionId != null }">
<%-- 						<li class="nav-item"><a class="nav-link " href="<c:url value="/examples/profile"/>"> <i class="ni ni-single-02 text-yellow"></i> User profile --%>
<!-- 						</a></li> -->
						<li class="nav-item"><a class="nav-link" href="<c:url value="logout"/>"> <i class="ni ni-key-25 text-info"></i> Logout
						</a></li>
						<!-- 네이버 로그인 시 -->
						<c:if test="${sessionScope.sessionNaver != null}">
					<li class="nav-item">
					<a class="nav-link " href="<c:url value="./deleteNaver"/>"> 
					<i class="ni ni-single-02 text-gray-dark""></i> 회원탈퇴
					</a></li>
					</c:if>
					<!-- 구글 로그인 시 -->
					<c:if test="${sessionScope.sessionNaver == null}">
					<li class="nav-item"><a class="nav-link " href="<c:url value="./deleteGoogle"/>"> <i class="ni ni-bullet-list-67 text-red"></i> 회원탈퇴
					</a></li>
						</c:if>
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
				<a class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block" href="<c:url value="/examples/index"/>">User Profile</a>
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
								<span class="avatar avatar-sm rounded-circle"> <img alt="Image placeholder" src="<c:url value="${sessionScope.Profile}"/>">
								</span>
								<div class="media-body ml-2 d-none d-lg-block">
									<span class="mb-0 text-sm  font-weight-bold">${sessionScope.sessionNickname}</span>
								</div>
							</div>
					</a>
						<div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right">
							<div class=" dropdown-header noti-title">
								<h6 class="text-overflow m-0">Welcome!</h6>
							</div>
<%-- 							<a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-single-02"></i> <span>My profile</span> --%>
<%-- 							</a> <a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-settings-gear-65"></i> <span>Settings</span> --%>
<%-- 							</a> <a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-calendar-grid-58"></i> <span>Activity</span> --%>
<%-- 							</a> <a href="<c:url value="/examples/profile"/>" class="dropdown-item"> <i class="ni ni-support-16"></i> <span>Support</span> --%>
<!-- 							</a> -->
							<div class="dropdown-divider"></div>
							<a href="../member/logout" class="dropdown-item"> <i class="ni ni-user-run"></i> <span>Logout</span>
							
							</a>
						</div></li>
				</ul>
			</div>
		</nav>
		<!-- End Navbar -->
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
						<c:if test="${sessionScope.sessionGooglename != null}">
						<h1 class="display-2 text-white">${sessionScope.sessionNickname}</h1>
						<p class="text-white mt-0 mb-5">${sessionScope.sessionNickname}님 brr를 이용해 주셔서 감사합니다.</p>
						</c:if>
<!-- 						<a href="#!" class="btn btn-info">Edit profile</a> -->
					</div>
				</div>
			</div>
		</div>
		<!-- Page content -->
		
		<!-- 여기서부터 신경 써야한다.  -->
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
												<c:if test="${sessionScope.sessionGooglename != null}">
												<label class="form-control-label" for="input-username">Username</label> <input type="text" id="input-username" class="form-control form-control-alternative" placeholder="Username" value="${sessionScope.sessionGooglename}">
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
			<!-- 여기까지  -->
			
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

