<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name = "google-signin-client_id"content = "1008960346250-33jebt3kge8r04ac3dh0fqoamfidshjs.apps.googleusercontent.com">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<title>로그아웃</title>
<script>



function onLoad() {
	gapi.load('auth2', function() { 
		gapi.auth2.init();
		
	});
}
function signOut() {
	var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function () {
    console.log('로그아웃 완료');
    });
	auth2.disconnect();
	goHome();
}



function goHome() {
	
	location.href = "/brr/maps/mapsMain";
}


</script>
</head>
<body>

<h1>로그아웃 되었습니다.</h1>

<form action="/brr/maps/mapsMain" method = "GET" onsubmit="signOut()">
<input type="submit" value="홈으로 돌아가기">
</form>


</body>
</html>