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
		<div class="mx-auto boardTitle form-group">
			<label for="exampleFormControlInput1">ID: ${board.id} &nbsp&nbsp 작성일: ${board.inputdate}</label> <input
				type="email" class="form-control" id="exampleFormControlInput1" value="${board.title}" readonly="readonly"
				placeholder="name@example.com">
		</div>

		<div class="mx-auto boardContents form-group">
			<label for="exampleFormControlTextarea1">내용</label>
			<textarea class="form-control" id="exampleFormControlTextarea1"
				rows="15" readonly="readonly">${board.contents}</textarea>
		</div>

	</form>
</body>

</html>