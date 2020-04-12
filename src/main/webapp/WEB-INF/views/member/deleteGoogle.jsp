<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<meta name = "google-signin-client_id"content = "1008960346250-33jebt3kge8r04ac3dh0fqoamfidshjs.apps.googleusercontent.com">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>구글회원 탈퇴</title>
<script>
function onLoad() { 
	gapi.load('auth2', function() { 
		gapi.auth2.init(); 
	});
}

function signOut() {
	var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function () {
    console.log('회원 탈퇴 완료');
    });
    	auth2.disconnect();
}

</script>
</head>
<body>
<h1>${sessionScope.sessionEmail}</h1>
<form action="delGoogle" method = "post" onsubmit="signOut()">
<input type = "submit" value="탈퇴">
</form>
</html>