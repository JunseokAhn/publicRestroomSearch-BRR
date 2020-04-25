<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 달력 임포트 -->
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	Calendar cal = Calendar.getInstance(); 

	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month"); 

	int year = cal.get(Calendar.YEAR);

	int month = cal.get(Calendar.MONTH);

	int date = cal.get(Calendar.DATE); 

	if(strYear != null)
	{
  		year = Integer.parseInt(strYear);
 	 	month = Integer.parseInt(strMonth);
	}
	else
	{
	}
	
	//년도/월 셋팅
	cal.set(year, month, 1); 

	int startDay = cal.getMinimum(java.util.Calendar.DATE);
	int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
	int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
	int newLine = 0; 

	//오늘 날짜 저장.

	Calendar todayCal = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyMMdd");
	int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));	
%>






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
<script src="<c:url value="/resources/js/jquery-3.4.1.js/"/>"></script>

<!--달력 -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<!-- jquery datepicker -->
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  	
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	
	
	<link href="/resources/css/main.css" rel="stylesheet" type="text/css">
	<script src="/resources/js/board.js" ></script>
	<script type="text/javaScript" language="javascript"></script>

<!--달력 -->
	<script type="text/javaScript" language="javascript"></script>
	
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
	<form name="calendarFrm" id="calendarFrm" action="" method="post">
		<DIV id="content" style="width:712px;">
			<table width="100%" border="0" cellspacing="1" cellpadding="1">
				<tr>
       				<td align ="right">
             			<input type="button" onclick="javascript:location.href='<c:url value='/CalendarExam2.jsp' />'" value="오늘"/>
       				</td>
				</tr>
			</table>
			<!--날짜 네비게이션  -->
			<table width="100%" border="0" cellspacing="1" cellpadding="1" id="KOO" bgcolor="#F3F9D7" style="border:1px solid #CED99C">
				<tr>
					<td height="60">
       					<table width="100%" border="0" cellspacing="0" cellpadding="0">
       					<tr>
             				<td height="10"></td>
       					</tr>
       					<tr>
             				<td align="center" >
             				<!-- 이전해 -->
                    		<a href="<c:url value='/CalendarExam2.jsp' />?year=<%=year-1%>&amp;month=<%=month%>" target="_self"><b>&lt;&lt;</b></a>

                    <%if(month > 0 ){ %>

                    <a href="<c:url value='/CalendarExam2.jsp' />?year=<%=year%>&amp;month=<%=month-1%>" target="_self">

                           <b>&lt;</b><!-- 이전달 -->

                    </a>

                    <%} else {%>

                           <b>&lt;</b>

                    <%} %>

                    &nbsp;&nbsp;

                    <%=year%>년

                   

                    <%=month+1%>월

                    &nbsp;&nbsp;

                    <%if(month < 11 ){ %>

                    <a href="<c:url value='/CalendarExam2.jsp' />?year=<%=year%>&amp;month=<%=month+1%>" target="_self">

                           <!-- 다음달 --><b>&gt;</b>

                    </a>

                    <%}else{%>

                           <b>&gt;</b>

                    <%} %>

                    <a href="<c:url value='/CalendarExam2.jsp' />?year=<%=year+1%>&amp;month=<%=month%>" target="_self">

                           <!-- 다음해 --><b>&gt;&gt;</b>

                    </a>

             </td>

       </tr>

       </table>

 

</td>

</tr>

</table>

<br>

<table border="0" cellspacing="1" cellpadding="1" bgcolor="#FFFFFF">

<THEAD>

<TR bgcolor="#CECECE">

       <TD width='100px'>

       <DIV align="center"><font color="red">일</font></DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center">월</DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center">화</DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center">수</DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center">목</DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center">금</DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center"><font color="#529dbc">토</font></DIV>

       </TD>

</TR>

</THEAD>

<TBODY>

<TR>

<%

 

//처음 빈공란 표시

for(int index = 1; index < start ; index++ )

{

  out.println("<TD >&nbsp;</TD>");

  newLine++;

}

 

for(int index = 1; index <= endDay; index++)

{

       String color = "";

 

       if(newLine == 0){          color = "RED";

       }else if(newLine == 6){    color = "#529dbc";

       }else{                     color = "BLACK"; };

 

       String sUseDate = Integer.toString(year); 

       sUseDate += Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1) : Integer.toString(month+1);

       sUseDate += Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index);

 

       int iUseDate = Integer.parseInt(sUseDate);

      

      

       String backColor = "#EFEFEF";

       if(iUseDate == intToday ) {

             backColor = "#c9c9c9";

       }

       out.println("<TD valign='top' align='left' height='92px' bgcolor='"+backColor+"' nowrap>");

       %>

       <font color='<%=color%>'>

             <%=index %>

       </font>

 

       <%

      

       out.println("<BR>");

       out.println(iUseDate);

       out.println("<BR>");

      

      

       //기능 제거 

       out.println("</TD>");

       newLine++;

 

       if(newLine == 7)

       {

         out.println("</TR>");

         if(index <= endDay)

         {

           out.println("<TR>");

         }

         newLine=0;

       }

}

//마지막 공란 LOOP

while(newLine > 0 && newLine < 7)

{

  out.println("<TD>&nbsp;</TD>");

  newLine++;

}

%>

</TR>

 

</TBODY>

</TABLE>

</DIV>
</form>




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
tml>
