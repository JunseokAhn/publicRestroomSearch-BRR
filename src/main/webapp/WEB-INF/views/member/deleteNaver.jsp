<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<meta name = "google-signin-client_id"content = "1008960346250-33jebt3kge8r04ac3dh0fqoamfidshjs.apps.googleusercontent.com">
<title>네이버 탈퇴 페이지</title>
<script>
$(document).ready(function () {
	$("#delete").on("click", init);
	
});

function init() {
	
	$.ajax({
		url:"delNaver",
		type: "GET",
		success: function() {
				alert("회원 탈퇴가 정상적으로 이루어졌습니다.");
				window.location.replace("/brr");
		},
		error: function(e){
			alert(JSON.stringify(e));
			console.log(JSON.stringify(e));
		}
	});
	
}

</script>

</head>
<body>

<div>
<table>
	<tr>
		<td>확인 된 이메일</td>
		<td>${sessionScope.sessionEmail}</td>
	</tr>
	<tr>
		<td><input type = "button" id = "delete" name = "delete" value = "회원 탈퇴"></td>
	</tr>
</table>
</div>


<!-- https://nid.naver.com/oauth2.0/token?
grant_type=delete&
client_id={클라이언트 아이디}&
client_secret={클라이언트 시크릿}&
access_token={접근 토큰}&
service_provider=NAVER -->
</body>
</html>