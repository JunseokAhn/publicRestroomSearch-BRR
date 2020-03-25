<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sample</title>

<script src="<c:url value="/resources/js/jquery-3.4.1.js/"/>" type="text/javascript"></script>
<!-- <script src="http://api.data.go.kr/openapi/pblic-toilet-std?serviceKey=WxmY00Tj2kX1M75S9K3bJ6T83gRglX6tD1NR1RFQaYq8C9FWrOA2%2FloB0ciJYKIuP5%2BQ8fQw8VIi5UiIK0rIEA%3D%3D" type="text/javascript"></script> -->

<script type="text/javascript" >	

	/* $.ajax({ 
		url: "http://api.data.go.kr/openapi/pblic-toilet-std?serviceKey=WxmY00Tj2kX1M75S9K3bJ6T83gRglX6tD1NR1RFQaYq8C9FWrOA2%2FloB0ciJYKIuP5%2BQ8fQw8VIi5UiIK0rIEA%3D%3D&type=json&pageNo=1&numOfRows=100&insttNm=전라남도 광양시",
		dataType: 'jsonp', 
		jsonpCallback: "myCallback", 
		success: callback 
	});  */

	$.ajax({
		url: "http://api.bus.go.kr/contents/sub02/getStationByPos.html"
		, type: "GET"
		, success: function(resp) {
			alert(resp)
		}
	});
	
	/* $.getJSON(url + "?callback=?", data, callback);
 */
	
</script>
</head>
<body>
	<h1>Sample</h1>
</body>
</html>