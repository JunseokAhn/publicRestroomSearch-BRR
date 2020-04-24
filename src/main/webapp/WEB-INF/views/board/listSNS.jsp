<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="../resources/js/jquery-3.4.1.js"></script>
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
<!-- snsBoardStyle -->
<link rel="stylesheet" type="text/css" href="../resources/css/snsBoardStyle.css">

<script>

// //snsBoard
// var count = 0;
// //스크롤 바닥 감지
// window.onscroll = function(e) {
//     //추가되는 임시 콘텐츠
//     //window height + window scrollY 값이 document height보다 클 경우,
//     if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
//     	//실행할 로직 (콘텐츠 추가)
//         count++;
//         var addContent = '<div class="mx-auto block form-group"><p>'+ count +'번째로 추가된 콘텐츠</p></div>';
// 			addContent += '<div class="mx-auto boardButton form-group"><button type="button" class="btn btn-secondary btn-sm">댓글</button>';
// 			addContent += '</div>';
//         //article에 추가되는 콘텐츠를 append
//         $('article').append(addContent);
//     }
// };

//sns상세글부분
function deleteSNS(e) {
	if(confirm("삭제하시겠습니까?")) {
		var snsBoardnum = e;
		console.log(snsBoardnum);
		location.href='deleteSNS?snsBoardnum='+ snsBoardnum;
	}	
}

function updateSNS(e) {
	if(confirm("수정하시겠습니까?")) {
		var snsBoardnum = e;
		console.log(snsBoardnum);
		location.href='updateSNS?snsBoardnum='+ snsBoardnum;
	}	
}

function listSNS() {
	if(confirm("목록으로 돌아가겠습니까?")) {
		location.href='listSNS';
	}	
}

// <table class="table">
// <thead>
//   <tr>
//      <th scope="col">#</th>
//      <th scope="col">First</th>
//      <th scope="col">Last</th>
//      <th scope="col">Handle</th>
//   </tr>
// </thead>
// <tbody>
//   <tr>
//      <th scope="row">1</th>
//      <td>Mark</td>
//      <td>Otto</td>
//      <td>@mdo</td>
//   </tr>
//   <tr>
//      <th scope="row">2</th>
//      <td>Jacob</td>
//      <td>Thornton</td>
//      <td>@fat</td>
//   </tr>
//   <tr>
//      <th scope="row">3</th>
//      <td>Larry</td>
//      <td>the Bird</td>
//      <td>@twitter</td>
//   </tr>
// </tbody>
// </table>


//sns댓글부분(ajax사용)
//readSNS페이지로 넘어오면 document에 넣은 함수가 한번 실행됨
$(document).ready(function() {
	$('.form1').hide();
	$('.form2').on('click', function(e) {
		console.log($(e.target).data("num"));
		var num = $(e.target).data("num");
		$('.form1[data-num="'+num+'"]').toggle();
	});
	//$("#form").on('click', snsReplySave);
	//$("#form + ${sns.snsBoardnum}").on('click', snsReplySave);
	//init();
});

function snsReplySave(snsBoardnum, email) {

	//잘 값이 들어갔는지 확인
	//var snsBoardnum = $(this).closest('div').find('#snsBoardnum').val();
	//var email = $(this).closest('div').find('#email').val();

	var snsBoardnum = snsBoardnum;
	var email = email;
	var comments = $('div').children("input[data-num='"+snsBoardnum+"']").val();
    	
	console.log(snsBoardnum);
	console.log(email);
	console.log(comments);
	
	if(comments.length == 0) {
		alert('댓글을 입력해 주세요.');
		return;
	}

	$.ajax({
		url: '../snsReply/insertSnsReply',
		type: 'POST',
		data: {
			snsBoardnum: snsBoardnum,
			email: email,
			comments: comments
		},
		success: function() {
			alert('댓글이 작성되었습니다.');
			$("input[data-num='"+snsBoardnum+"']").val('');
			init(snsBoardnum);
		},
		error: function(e) {
			alert(JSON.stringify(e));//에러객체를 전달해서 문자열화하는 클래스의 함수사용
		}
	});
}

function init(snsBoardnum) {
	var snsBoardnum = snsBoardnum;
	
	$.ajax({
		url: '../snsReply/listSnsReply',
		type: 'GET',
		data: {
			snsBoardnum: snsBoardnum
		},
		success: output
	});
}

////sns댓글목록
//function output(listSnsReply) {
//	console.log(listSnsReply);
//	$('#replies').html("");
//	$.each(listSnsReply, function(index, snsReply) {
//		var str = '<div class="list-group">';
//		str += '	<a href="#" class="list-group-item list-group-item-action">';
//		str += '		<div class="d-flex w-100 justify-content-between">';
//		str += '			<h5 class="mb-1">'+ snsReply.email +'</h5>';
//		str += '			<small>'+ snsReply.inputdate +'</small> </div>';
//		str += '			<p class="mb-1" style="text-align: left;">'+ snsReply.comments +'</p>';
//		//사용자정의속성
//		str += '			<small><input type="button" value="댓글수정" class="snsUpd btn btn-secondary btn-sm" freeboardnum="'+ snsReply.snsBoardnum +'" freeid="'+ snsReply.id +'" freenum="'+ snsReply.snsReplynum +'" freecomments="'+ snsReply.comments +'">';
//		str += '			<input type="button" value="댓글삭제" class="snsDel btn btn-secondary btn-sm" freenum="'+ snsReply.snsReplynum +'"></small> </a>';
//		str +='			</div>';
//		console.log($('#replies[data-num="'+snsReply.snsBoardnum+'"]'));
//		$('#replies[data-num="'+snsReply.snsBoardnum+'"]').append(str);
//	});

//	//sns댓글수정
//	$('input:button.snsUpd').on('click', updateSnsReply);
//	//sns댓글삭제
//	$('input:button.snsDel').on('click', deleteSnsReply);
	
//}

function output(listSnsReply) {
	$('#replies').html("");
	$.each(listSnsReply, function(index, snsReply) {
		var str = '<div class="mx-auto replyComments form-group"><table class="table">';
		str += '<thead>';
		str += '	<tr>';
		str += '		<th scope="col" class="id1" style="text-align: left;">' + snsReply.email + '</th>';
		str += '		<th scope="col"></th>';
		str += '		<th scope="col" class="inpudate1">' + snsReply.inputdate + '</th>';
		str += '	</tr>';
		str += '</thead>';
		//사용자정의속성
		str += '<tbody>';
		str += '	<tr>'
		str += '		<td class="comments1" colspan="2" style="text-align: left;">' + snsReply.comments + '</td>';
		str += '		<td class="upd_length">';
		str += '			<input type="button" value="댓글수정" class="snsUpd btn btn-secondary btn-sm" freenum="'+ snsReply.snsReplynum +'">';
		str += '			<input type="button" value="댓글삭제" class="snsDel btn btn-secondary btn-sm" freenum="'+ snsReply.snsReplynum +'">';
		str += '		</td>';
//		str += '	<td class="del_length"><input type="button" value="댓글삭제" class="snsDel btn btn-secondary btn-sm" freenum="'+ snsReply.snsReplynum +'"></td>';
		str += '	</tr>';
		str += '</tbody>';
		str += '</table></div>';
		$('#replies[data-num="'+snsReply.snsBoardnum+'"]').html(str);
	});
	
	//sns댓글목록
	//$('#snsListDiv').html(str);
	//sns댓글수정
	$('input:button.snsUpd').on('click', updateSnsReply);
	//sns댓글삭제
	$('input:button.snsDel').on('click', deleteSnsReply);

}

//sns댓글수정
function updateSnsReply() {

	var snsBoardnum = $(this).attr('freeboardnum');
	//1번방법 - .attr('freenum'속성의 값을 받아옴)
	var snsReplynum = $(this).attr('freenum');
	//2번방법 / 텍스트-html() / value값-val()
	var id = $(this).attr('freeid');
	//var comments = $(this).closest('div').find('p.commentsUpd').html();
	//var comments = $(this).find('.snsUpd').val();
	var comments = $(this).attr('freecomments');
	
	//잘 값이 들어갔는지 확인
	console.log(snsBoardnum);
	console.log(snsReplynum);
	console.log(id);
	console.log(comments);

	//댓글수정 click시 버튼 숨기기
	$('.snsUpd').hide();

	var str = '<div class="mx-auto replyComments form-group"><table class="table">';
		str += '<thead>';
		str += '	<tr>';
		str += '		<td><input class="form-control form-control-sm" type="text" id="replyUpd" value="'+ comments +'"></td>';
		str += '		<td class="upd_length"><input type="button" id="confirmUpd" class="btn btn-secondary btn-sm" value="수정 확인"></td>';
		str += '		<td class="del_length"><input type="button" id="cancelUpd" class="btn btn-secondary btn-sm" value="취소"></td>';	
		str += '	</tr>
		str += '</thead>';	
		str += '</table></div>';


		

// 	var str = '<div class="mx-auto replyComments form-group">';
// 		str += '<p>';
// 		str += '	<span class="review'+ snsReplynum +'"><input class="form-control form-control-sm" type="text" id="replyUpd"></span>';
// 		str += '	<span style="float:left;"><input type="button" id="confirmUpd" class="btn btn-secondary btn-sm" value="수정 확인">';
// 		str += '	<input type="button" id="cancelUpd" class="btn btn-secondary btn-sm" value="취소"></span>';
// 		str += '</p>';
// 		str += '</div>';
	
	$(this).after(str);

	$('#confirmUpd').on('click', function() {
		var replyUpd = $("span.review" + snsReplynum).find('#replyUpd').val();
		
		console.log(replyUpd);
        
		$.ajax({
			url: '../snsReply/updateSnsReply',
			type: 'POST',
			data: {
				snsReplynum: snsReplynum,
				comments: replyUpd
			},
			success: function(cnt) {
				alert(cnt);
				$('.snsUpd').show();//수정확인후 수정버튼 다시보임
				init(snsBoardnum);
			},
			error: function(e) {
				alert(JSON.stringify(e));
			}
		});		
	});
	//위의 코드가 실행된 이후에 이벤트를 걸어야 제대로 작동됨
	$('#cancelUpd').on('click', function() {
		//this(취소버튼)가까운 부모의 tr태그 즉 추가되었던 tr태그 remove(삭제)
		$(this).closest('p').remove();
	});
}

//sns댓글삭제
function deleteSnsReply() {
	var snsReplynum = $(this).attr('freenum');

	$.ajax({
		url: '../snsReply/deleteSnsReply',
		type: 'POST',
		data: {
			snsReplynum: snsReplynum
		},
		success: function(cnt) {
			alert(cnt);
			init();
		}
	});
}

</script>

</head>

<body class="">
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
					<c:if test="${sessionScope.sessionId==null }">
						<li class="nav-item"><a class="nav-link" href="<c:url value="/examples/login"/>"> <i class="ni ni-key-25 text-info"></i> Login
						</a></li>
						<li class="nav-item"><a class="nav-link" href="<c:url value="/examples/register"/>"> <i class="ni ni-circle-08 text-pink"></i> Sign up
						</a></li>
					</c:if>
					<c:if test="${sessionScope.sessionId!=null }">
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
				<a class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block" href="<c:url value="/examples/upgrade"/>">Icons</a>
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
									<span class="mb-0 text-sm  font-weight-bold">${sessionScope.sessionId}</span>
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
		<!-- Page content -->
		<div class="container-fluid mt--7">
			<!-- Table -->
			<div class="row">
				<div class="col">
					<div class="card shadow">
					<!-- 무한스크롤 -->
					<c:if test="${listSNS == null}">
							<p>게시물이 존재하지 않습니다.</p>
					</c:if>

					<c:if test="${listSNS != null}">
					</c:if>
					<!-- 제일처음에 넣을 부분 -->
					<div class="mx-auto form-group">
					</div>
					<article>
							<div class="mx-auto snsBoardButton form-group">
								<input class="btn btn-primary" type="button" value="sns글쓰기" onclick="location.href='snsWrite';">
								<input class="btn btn-primary" type="button" value="리뷰게시판" onclick="location.href='../review/listBoard';">
							</div>

							<c:forEach var="sns" items="${listSNS}">	
							<!-- 반복시작 -->
							<div class="mx-auto block form-group" style="position: relative;">
							<!-- 글쓰기 -->
								<div class="row">
									<div class="id col-md-auto"><span>${sns.email}</span></div>
									<div class="date col"><span>등록일: ${sns.inputdate}</span></div>
								</div>
								<br>
								<div class="row">
									<div class="col-md-auto"><span>${sns.contents}</span></div>
								</div>
							<!-- 삭제, 수정  버튼 -->
								<div class="row1">
								<!-- 삭제, 수정을 위한 Boardnum 받기 -->	
								<c:if test="${sessionScope.sessionId == sns.id}">
									<button type="button" class="btn btn-primary btn-sm"
										onclick="deleteSNS('${sns.snsBoardnum}')">삭제</button>
									<button type="button" class="btn btn-primary btn-sm"
										onclick="updateSNS('${sns.snsBoardnum}')">수정</button>
								</c:if>		
									<button type="button" class="form2 btn btn-primary btn-sm" data-num="${sns.snsBoardnum}">댓글쓰기</button>
										
								</div>
							</div>
								
							<div class="mx-auto snsBoardButton form-group">

<!-- 								<button type="button" class="btn btn-secondary btn-sm"  -->
<%-- 								onclick="location.href='readSNS?snsBoardnum=${sns.snsBoardnum}';">댓글</button> --%>
							
							<!-- 댓글쓰기 -->
								<div class="form1 mx-auto form-group" data-num="${sns.snsBoardnum}">
									<div>
										<input type="hidden" id="snsBoardnum" value="${sns.snsBoardnum}">
										<input type="hidden" id="email" value="${sns.email}">
										<div>
											<input style="margin-bottom: 5px;" class="form-control" type="text" data-num="${sns.snsBoardnum}" placeholder="댓글등록">
											<button type="button" class="btn btn-primary btn-sm" onclick="snsReplySave(${sns.snsBoardnum},'${sns.email}');">댓글등록</button>
										</div>
										
									</div>										
								</div>
								
								<!-- 댓글 table -->
								<div id="replies" data-num="${sns.snsBoardnum}" class="mx-auto form-group"></div>
						
							</div>
						</c:forEach>
						<!-- 반복종료 -->
					<!-- 반복 -->	

					</article>					
					
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
	<!--   Optional JS   -->
	<script src="<c:url value="/resources/assets/js/plugins/clipboard/dist/clipboard.min.js"/>"></script>
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
