<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<meta name = "google-signin-client_id"content = "1008960346250-33jebt3kge8r04ac3dh0fqoamfidshjs.apps.googleusercontent.com">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>google 로그인 페이지입니다.</title>
<script>
function onSignIn(googleUser) {
	
	  var profile = googleUser.getBasicProfile();
	  console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
	  console.log('Name: ' + profile.getName());
	  console.log('Image URL: ' + profile.getImageUrl());
	  console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.

	  var id_token = googleUser.getAuthResponse().id_token;
		var xhr = new XMLHttpRequest();
		xhr.open('POST', 'http://localhost:8888/test1/callbackTestGoo');
		xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		xhr.onload = function() {
			console.log(id_token);
			console.log('Signed in as: ' + xhr.responseText);
		};
		xhr.send('idtoken=' + id_token);
		
		setTimeout(function(){ BackHome(); }, 5000);
	}
function BackHome(){
	
	location.href = "/test1";
}

function signOut() {
	var auth2 = gapi.auth2.getAuthInstance();
	auth2.signOut().then(function () {
		console.log('로그아웃');
	});
	auth2.disconnect();
}

</script>
</head>
<body>

<div class="g-signin2" data-onsuccess="onSignIn"></div>
<a href = "#" onclick="signOut();">Sign out</a>

<!--   1008960346250-33jebt3kge8r04ac3dh0fqoamfidshjs.apps.googleusercontent.com => 클라이언트 ID %> -->
<!-- f1MZy7mODbXN11sYkQjtVZO0 => 클라이언트 secret -->



</body>
</html>