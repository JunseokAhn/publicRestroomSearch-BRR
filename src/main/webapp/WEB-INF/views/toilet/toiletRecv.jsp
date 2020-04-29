<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<title>화장실 데이터 받기</title>

<script src="<c:url value="/resources/js/jquery-3.4.1.js/"/>" type="text/javascript"></script>
<script type="text/javascript" >		
	$(
			function()
			{
				$.ajax({
					url:"<c:url value="/toilet/receive"/>",
					type:"get",
					dataType:"text",
					success:
						function(flag)
						{
							if(flag=="success")
							{
								alert("모든 데이터 업데이트가 완료되었습니다.\n 메인화면으로 이동합니다.");
								location.href="<c:url value="/maps/mapsMain"/>";
							}
							else if(flag=="error")
							{
								alert("데이터를 받는 도중 이상이 생겼습니다. 브라우저를 다시 실행해주세요.");
								location.href="<c:url value="/maps/mapsMain"/>";
							}
							else if(flag=="problemofsever")
							{
								alert("공공포털api서버에 문제가 있어서 접속이 안 되고 있습니다.\n나중에 실행시켜 주십시오.\n이용에 불편을 드려 죄송합니다.");
								location.href="<c:url value="/maps/mapsMain"/>";
							}
						}
					,
					error:
						function()
						{
							console.log("로직 에러!!");
							alert("데이터를 받는 도중 이상이 생겼습니다. 브라우저를 다시 실행해주세요.");
							location.href="<c:url value="/maps/mapsMain"/>"
						}
				});				 				
			}
	);
</script>
</head>
<body style="text-align: center;">
	<br>
	<br>
	<br>
	<br>
	<h1 style="text-align: center;">화장실 데이터를 받아오고 있습니다. <br> 잠시만 기다려주세요.</h1>
	<img style="width:280px;height:280px;" src="<c:url value="/resources/img/Loading.gif"/>">
	
</body>
</html>