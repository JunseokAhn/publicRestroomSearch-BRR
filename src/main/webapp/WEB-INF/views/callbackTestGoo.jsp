<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<title></title>
<script>
$(document).ready(function() {
	setTimeout(function(){ BackHome(); }, 2000);
});

function BackHome(){
	
	location.href = "/test1";
}


</script>
</head>
<body>

<h1>로그인에 성공하였습니다.</h1>

<p>잠시후 홈으로 돌아갑니다.</p>


</body>
</html>