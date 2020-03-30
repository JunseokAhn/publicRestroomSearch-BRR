<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>똥 일기</title>
<link rel="stylesheet" href="../resources/css/style.css">

<link rel="stylesheet" href="../resources/css/bootstrap.css">
<script src="../resources/jquery/jquery-3.4.1.min.js"></script>
<style>
	#level1{ display: block; margin: 0px auto; }
	aside {
    width: 150%;
    padding-left: .5rem;
    margin-left: .5rem;
    float: right;
    box-shadow: inset 5px 0 5px -5px #29627e;
    font-style: italic;
    color: #29627e;
}
aside > p {
    margin: .5rem;
}
	</style>

<script>


 $(function(){

 $("#bt").on("click",function(){
	 $.ajax({
			url : 'dairy2',
			type : 'get',
			datatype:'' 
			,
			success : function() {
				
				init();
			},
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
});
});
function init() {
	location.href='http://localhost:8888/brr/api/dairy2';
	
} 
</script>
</head>
<body>
<p><img id="level1" src="../resources/img/ddongmain.png"></p>

<center>
<button id='bt' type="button" style="width:660pt" class="btn btn-secondary btn-lg btn-block">분석하기</button>
</center>

<aside class="recommendation thumb_type" style="display: none;" aria-hidden="true">
<a class="recommendation-link no-text" href="/360" role="button" aria-label="추천 글, 상업적으로 사용할 수 있는 무료 한글 웹폰트들을 모아놓은 사이트 '눈누' 읽기">상업적으로 사용할 수 있는 무료 한글 웹폰트들을 모아놓은 사이트 '눈누'</a>
<div class="recommendation-visual" aria-hidden="true">
<div class="recommendation-text">
<span>이 글은 어떠세요?</span>
<p>상업적으로 사용할 수 있는 무료 한글 웹폰트들을 모아놓은 사이트 '눈누'</p>
</div>
<figure style="background-image:url(//img1.daumcdn.net/thumb/R300x0/?fname=https://img1.daumcdn.net/thumb/R1200x0/?scode=mtistory2&amp;fname=https%3A%2F%2Ft1.daumcdn.net%2Fcfile%2Ftistory%2F99384D375B0D0D2536)"></figure>
</div>
<button class="fc-icon fc-appearance fc-button close-alert">닫기</button>
</aside>

</body>
</html>