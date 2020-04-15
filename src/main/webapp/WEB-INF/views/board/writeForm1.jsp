<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>woogoogle</title>
<%--BootStrap Getting Started--%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="../resources/css/boardStyle.css">

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
	<h1><span>b</span><span>rr</span></h1>
	<form action="write" method="post" onsubmit="return formCheck()">
		<div class="mx-auto boardTitle form-group">
			<label for="exampleFormControlInput1">제목</label> <input
				type="text" class="form-control" id="exampleFormControlInput1"
				placeholder="제목을 입력해주세요."
				id="title" name="title" 
				>
		</div>

		<div class="mx-auto boardContents form-group">
			<label for="exampleFormControlTextarea1">내용</label>
			<textarea class="form-control" id="exampleFormControlTextarea1"
				rows="15"
				id="contents" name="contents"
				></textarea>
		</div>

		<div class="mx-auto boardButton form-group">
			<input class="btn btn-primary" type="reset" value="Reset">
			<input class="btn btn-primary" type="submit" value="Submit">
		</div>
	</form>
</body>

</html>