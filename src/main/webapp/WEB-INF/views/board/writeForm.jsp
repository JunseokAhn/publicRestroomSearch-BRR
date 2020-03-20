<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메모쓰기</title>
<!-- 제목 및 내용 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Brush+Script|Nanum+Pen+Script&display=swap" rel="stylesheet">	

<link rel="stylesheet" type="text/css" href="../resources/css/style.css">

<script>
//글쓰기폼 확인
function formCheck() {
	var title = document.getElementById('title');
	var contents = document.getElementById('contents');
	
	if (title.value == '') {
		alert("제목을 입력하세요.");
		title.focus();
		title.select();
		return false;
	}
	if (contents.value == '') {
		alert("메모를 입력하세요.");
		contents.focus();
		contents.select();
		return false;
	}
	return true;
}

</script>	
</head>
<body>
<div class="container6">
<h1>[ 게시판 쓰기 ]</h1>
<form action="write" method="post" onsubmit="return formCheck()">
<table>
<tr>
	<th>제목</th>
	<td><input type="text" id="title" name="title" class="writeTitle"> </td>
</tr>	
<tr>	
	<th>내용</th>
	<td>
		<textarea rows="20" cols="40" id="contents" name="contents"></textarea>
	</td>
</tr>
<tr>
	<td colspan="2" class="center">
		<input type="submit" value="저장">
	</td>
</tr>
</table>
</form>
</div>

</body>
</html>