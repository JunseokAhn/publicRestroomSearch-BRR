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
<link rel="stylesheet" type="text/css" href="../resources/css/snsBoardStyle.css">

<script>

//sns상세글부분
function deleteSNS() {
	if(confirm("삭제하시겠습니까?")) {
		location.href='deleteSNS?snsBoardnum=${snsBoard.snsBoardnum}';
	}	
}
function updateSNS() {
	if(confirm("수정하시겠습니까?")) {
		location.href='updateSNS?snsBoardnum=${snsBoard.snsBoardnum}';
	}	
}
function listSNS() {
	if(confirm("목록으로 돌아가겠습니까?")) {
		location.href='listSNS';
	}	
}

//sns댓글부분(ajax사용)
//readSNS페이지로 넘어오면 document에 넣은 함수가 한번 실행됨
$(document).ready(function() {
	$('#form').on('click', snsReplySave);
	init();
});

function snsReplySave() {
	var snsBoardnum = $('#snsBoardnum').val();
	var comments = $('#comments').val();

	if(comments.length == 0) {
		alert('댓글을 입력해 주세요.');
		return;
	}

	$.ajax({
		url: '../snsReply/insertSnsReply',
		type: 'POST',
		data: {
			snsBoardnum: snsBoardnum,
			comments: comments
		},
		success: function() {
			alert('댓글이 작성되었습니다.');
			$('#comments').val('');
			init();
		},
		error: function(e) {
			alert(JSON.stringify(e));//에러객체를 전달해서 문자열화하는 클래스의 함수사용
		}
	});
}

function init() {
	var snsBoardnum = $('#snsBoardnum').val();

	$.ajax({
		url: '../snsReply/listSnsReply',
		type: 'GET',
		data: {
			snsBoardnum: snsBoardnum
		},
		success: output
	});
}

function output(listSnsReply) {
	var str = '<div class="mx-auto replyComments form-group"><table>';

	$.each(listSnsReply, function(index, snsReply) {
		str += '<tr>';
		str += '<td class="id1">' + snsReply.id + '</td>';
		str += '<td class="comments1">' + snsReply.comments + '</td>';
		str += '<td class="inpudate1">' + snsReply.inputdate + '</td>';
		//사용자정의속성
		str += '<td class="upd_length"><input type="button" value="댓글수정" class="snsUpd btn btn-secondary btn-sm" freenum="'+ snsReply.snsReplynum +'"></td>';
		str += '<td class="del_length"><input type="button" value="댓글삭제" class="snsDel btn btn-secondary btn-sm" freenum="'+ snsReply.snsReplynum +'"></td>';
		str += '</tr>';
	});
	str +='</table></div>';
	//sns댓글목록
	$('#snsListDiv').html(str);
	//sns댓글수정
	$('input:button.snsUpd').on('click', updateSnsReply);
	//sns댓글삭제
	$('input:button.snsDel').on('click', deleteSnsReply);

}

//sns댓글수정
function updateSnsReply() {
	//1번방법 - .attr('freenum'속성의 값을 받아옴)
	var snsReplynum = $(this).attr('freenum');
	//2번방법 / 텍스트-html() / value값-val()
	var id = $(this).closest('tr').find('.id1').html();
	var comments = $(this).closest('tr').find('.comments1').html();

	//잘 값이 들어갔는지 확인
	console.log(snsReplynum);
	console.log(id);
	console.log(comments);

	//댓글수정 click시 버튼 숨기기
	$('.snsUpd').hide();

	var str = '';
	str += '<tr>';
	str += '	<td></td>';
	str += ' 	<td><input type="text" id="replyUpd" value="'+ comments +'"></td>';
	str += '	<td></td>';
	str += '	<td class="upd_length"><input type="button" id="confirmUpd" class="btn btn-secondary btn-sm" value="수정 확인"></td>';
	str += '	<td class="del_length"><input type="button" id="cancelUpd" class="btn btn-secondary btn-sm" value="취소"></td>';	
	str += '</tr>';

	$(this).closest('tr').after(str);

	$('#confirmUpd').on('click', function() {
		var replyUpd = $(this).closest('tr').find('#replyUpd').val();

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
				init();
			},
			error: function(e) {
				alert(JSON.stringify(e));
			}
		});		
	});
	//위의 코드가 실행된 이후에 이벤트를 걸어야 제대로 작동됨
	$('#cancelUpd').on('click', function() {
		//this(취소버튼)가까운 부모의 tr태그 즉 추가되었던 tr태그 remove(삭제)
		$(this).closest('tr').remove();
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
<body>
	<h1><span>b</span><span>rr</span></h1>
	<form action="">
		<!-- 		<div class="mx-auto mt-5 search-bar input-group mb-3">
			<input type="text" class="form-control" placeholder="검색" aria-label="Recipient's username" aria-describedby="button-addon2">
  				<div class="input-group-append">
    			<button class="btn btn-outline-secondary" type="button" id="button-addon2">Button</button>
  				</div>
		</div>
 -->
 		<!-- 게시판 글 -->
		<div class="mx-auto boardTitle form-group">
			<label for="exampleFormControlInput1">ID: ${snsBoard.id}
				&nbsp&nbsp 작성일: ${snsBoard.inputdate}</label> 
				<input class="form-control" type="text" value="${snsBoard.title}" readonly="readonly">	
		</div>
		<div class="mx-auto boardContents form-group">
			<label for="exampleFormControlTextarea1">내용</label>
			<textarea class="form-control" id="exampleFormControlTextarea1"
				rows="15" readonly="readonly">${snsBoard.contents}</textarea>
		</div>
		<!-- 삭제, 수정, 목록보기 버튼 -->
		<div class="mx-auto boardTitle form-group">
			<input type="button" class="btn btn-primary" value="삭제" onclick="deleteSNS()"> 
			<input type="button" class="btn btn-primary" value="수정" onclick="updateSNS()"> 
			<input type="button" class="btn btn-primary" value="목록보기" onclick="listSNS()">
		</div>
		<!-- 댓글쓰기 -->
		<div class="mx-auto boardTitle form-group">
			<input type="hidden" id="snsBoardnum" value="${snsBoard.snsBoardnum}">  
			<input class="form-control" type="text" id="comments" placeholder="댓글등록">
		</div>
		<div class="mx-auto boardTitle form-group">
			<input type="button" id="form" class="btn btn-primary" value="댓글등록">
		</div>		
		<!-- 댓글 table -->
		<div id="snsListDiv" class="mx-auto form-group"></div>	
		
	</form>
	
</body>

</html>