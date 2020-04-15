<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>brr 상세글</title>
<script src="../resources/js/jquery-3.4.1.js/"/>"></script>
<%--BootStrap Getting Started--%>
<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../resources/css/boardStyle.css">

<script>
//메모글부분
function boardDelete() {
	if(confirm("삭제하시겠습니까?")) {
		location.href='deleteBoard?boardnum=${board.boardnum}';
	}	
}
function boardUpdate() {
	if(confirm("수정하시겠습니까?")) {
		location.href='updateBoard?boardnum=${board.boardnum}';
	}	
}
function boardList() {
	if(confirm("목록으로 돌아가겠습니까?")) {
		location.href='listBoard';
	}	
}

//댓글부분(ajax사용)
$(document).ready(function() {
	$('#form').on('click', formSave);
	init();	
});

function formSave() {

	var boardnum = $('#boardnum').val();
	var comments = $('#comments').val();

	if(comments.length == 0) {
		alert('댓글을 입력해주세요.');
		return;
	}	

	$.ajax({
		url: '../reply/insertReply'
		,type: 'POST'
		,data: { //서버로 보내기
			boardnum: boardnum
			,comments: comments
		}	
		,success: function() {
			alert('작성되었습니다.');
			$('#comments').val('');
			init();
		}
		,error: function(e) {
			alert(JSON.stringify(e));//에러객체를 전달해서 문자열화하는 클래스의 함수사용
		}
	});
}

function init() {

	var boardnum = $('#boardnum').val();
	
	$.ajax({
		url: '../reply/listReply',
		data: {
			boardnum: boardnum //ReplyController에 listReply에 넘겨줄 boardnum
		}, 	
		type: 'GET',
		success: output
	});
}

//전역변수
var replyId = ''; //리플삭제시 필요한 ID //전역변수를 초기화 해주고 씀

function output(listReply) {
	var str = '<div class="mx-auto replyComments form-group"><table>';
				
	$.each(listReply, function(index, item) {
		str += '<tr>';
		str += '<td class="id1">' + item.id + '</td>';
		str += '<td class="comments1">' + item.comments + '</td>';
		str += '<td class="inputdate1">' + item.inputdate + '</td>';
		//사용자정의속성
		str += '<td class="upd_length"><input type="button" value="수정" class="upd btn btn-secondary btn-sm" freenum="'+ item.replynum + '"></td>';
		str += '<td class="del_length"><input type="button" value="삭제" class="del btn btn-secondary btn-sm" freenum="'+ item.replynum + '"></td>';
		str += '<tr>';		
	});
	str +='</table></div>';
	//댓글목록
	$('#listDiv').html(str);
	//댓글수정
	$('input:button.upd').on('click', updateReply);
	//댓글삭제
	$('input:button.del').on('click', deleteReply);
}

//수정
function updateReply() {
	//1번방법 - .attr('freenum'속성의 값을 받아옴)
	var replynum = $(this).attr('freenum');
	//2번방법 / 텍스트-html() / value값-val()
	var id = $(this).closest('tr').find('.id1').html();
	var comments = $(this).closest('tr').find('.comments1').html();
	
 	console.log(replynum);
 	console.log(id);
 	console.log(comments);

	$(".upd").hide(); //댓글수정시 수정버튼숨기기!
	
	var str = '';
	str += '<tr>'
//	str += '	<td><input type="text" value="' + id + ' " readonly="true"> </td>';	
	str += '	<td></td>';	
	str += '	<td><input type="text" id="replyUpd" value="' + comments + ' "> </td>';
	str += '	<td></td>';
	str += '	<td class="upd_length"><input type="button" id="confirmUpd" class="upd btn btn-secondary btn-sm" value="수정 확인"> </td>';
	str += '	<td class="del_length"><input type="button" id="cancelUpd" class="upd btn btn-secondary btn-sm" value="취소"> </td>';
	str += '<tr>';

	$(this).closest('tr').after(str);

	$('#confirmUpd').on('click', function() {
		var replyUpd = $(this).closest('tr').find('#replyUpd').val();

		$.ajax({
			url: '../reply/updateReply'
			,type: 'POST'
			,data: {
				replynum: replynum
				,comments: replyUpd
			}
			,success: function(cnt) {
				alert(cnt);
				$(".upd").show(); //수정확인후 수정버튼 다시보임.
				init();
			}
			,error: function(e) {
				alert(JSON.stringify(e));
			}			
		});
	});
	
	//위의 코드가 실행된 이후에 이벤트를 걸어야 제대로 작동됨.
	$('#cancelUpd').on('click', function() {
		//this(취소버튼)가까운 부모의 tr태그 즉 추가되었던 tr태그 remove(삭제)
		$(this).closest('tr').remove();
	});
}

//삭제
function deleteReply() {
	var replynum = $(this).attr('freenum');
	//var id = replyId;
	//alert(replyId + '값확인');

	$.ajax({
		url: '../reply/deleteReply'
		,type: 'POST'
		,data: {
			replynum: replynum
		}
		,success: function(cnt) {
			alert(cnt);
			init();
		}	
	});
}


</script>


</head>
<body>
	<h1><span>b</span><span>rr</span></h1>

 		<!-- 게시판 글 -->
		<div class="mx-auto boardTitle form-group">
			<label for="exampleFormControlInput1">ID: ${board.id}
				&nbsp&nbsp 작성일: ${board.inputdate}</label> 
				<input class="form-control" type="text" value="${board.title}" readonly="readonly">	
		</div>
		<div class="mx-auto boardContents form-group">
			<label for="exampleFormControlTextarea1">내용</label>
			<textarea class="form-control" id="exampleFormControlTextarea1"
				rows="15" readonly="readonly">${board.contents}</textarea>
		</div>
		<!-- 삭제, 수정, 목록보기 버튼 -->
		<div class="mx-auto boardTitle form-group">
			<input type="button" class="btn btn-primary" value="삭제" onclick="boardDelete()"> 
			<input type="button" class="btn btn-primary" value="수정" onclick="boardUpdate()"> 
			<input type="button" class="btn btn-primary" value="목록보기" onclick="boardList()">
		</div>
		<!-- 댓글쓰기 -->
		<div class="mx-auto boardTitle form-group">
			<input type="hidden" id="boardnum" value="${board.boardnum}">  
			<input class="form-control" type="text" id="comments" placeholder="댓글등록">
		</div>
		<div class="mx-auto boardTitle form-group">
			<input type="button" id="form" class="btn btn-primary" value="댓글등록">
		</div>		
		<!-- 댓글 table -->
		<div id="listDiv" class="mx-auto form-group"></div>		
	
</body>

</html>